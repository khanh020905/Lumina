package Controller.feature;

import Dal.applicationDAO;
import Dal.recruitmentDAO;
import Model.Application;
import Model.Recruitment;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CareerServlet", urlPatterns = {"/careers", "/apply"})
public class CareerServlet extends HttpServlet {
    
    private final recruitmentDAO d = new recruitmentDAO();
    private final applicationDAO ad = new applicationDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if ("/careers".equals(path)) {
            careerGet(request, response);
        } else if ("/apply".equals(path)) {
            applyGet(request, response);
        }
    }
    
    protected void careerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Recruitment> recruitList = d.getRecruitment();
        
        if (recruitList == null) {
            recruitList = new ArrayList<>();
        }
        
        request.setAttribute("recruitList", recruitList);
        request.getRequestDispatcher("careers.jsp").forward(request, response);
    }
    
    protected void applyGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        System.out.println("idStr = " + idStr);
        
        int id = 0;
        if (idStr != null && !idStr.isEmpty()) {
            try {
                id = Integer.parseInt(idStr);
                
                Recruitment job = d.getRecruitmentById(id);
                System.out.println("job = " + job);
                
                if (job != null) {
                    request.setAttribute("job", job);
                    request.getRequestDispatcher("apply.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid Job ID: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/careers");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path.equals("/apply")) {
            applyPost(request, response);
        }
    }
    
    protected void applyPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        long COOL_DOWN_TIME = 30000;
        long currentTime = System.currentTimeMillis();
        Long lastSubmissionTime = (Long) session.getAttribute("lastSubmission");
        
        if (lastSubmissionTime != null && currentTime - lastSubmissionTime < COOL_DOWN_TIME) {
            long secondLeft = (COOL_DOWN_TIME - (currentTime - lastSubmissionTime)) / 1000;
            session.setAttribute("error", "Please wait " + secondLeft + "s before try again!");
            response.sendRedirect("careers");
            return;
        }
        
        session.setAttribute("lastSubmission", currentTime);
        
        String jobIdStr = request.getParameter("jobId");
        int id = 0;
        try {
            id = Integer.parseInt(jobIdStr);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String cvUrl = request.getParameter("cvUrl");
        
        Application isApply = ad.hasUserApplied(id, user.getId());
        if (isApply != null) {
            session.setAttribute("error", "You already apply for this position");
            response.sendRedirect("careers"); return;
        }
        
        Recruitment recruitment = d.getRecruitmentById(id);
        
        ad.addApplication(recruitment.getId(), user.getId(), fullName, email, phoneNumber, cvUrl);
        response.sendRedirect("applicationsuccess.jsp");
    }
    
}
