package Service;

import Dal.userDAO;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AccountSettingServlet", urlPatterns = {"/accountSetting", "/newPasswordAccountSetting"})
public class AccountSettingServlet extends HttpServlet {

    private final userDAO d = new userDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("accountSetting")) {
            request.getRequestDispatcher("accountSetting.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("newPasswordAccountSetting")) {
            resetPasswordPost(request, response);
        } else if (uri.contains("accountSetting")) {
            updateInfoPost(request, response);
        }
    }

    protected void updateInfoPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser != null) {
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String bio = request.getParameter("bio");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            String targetUsername = (username != null) ? username : currentUser.getUsername();

            boolean isUpdated = d.updateUserSetting(targetUsername, email, phone, bio, fullName);

            if (isUpdated) {
                User refreshUser = d.checkAccount(email);
                if (refreshUser != null) {
                    session.setAttribute("user", refreshUser);
                }
                request.setAttribute("msg", "Information updated successfully!");
            } else {
                request.setAttribute("msg", "Cannot update your information.");
            }
            request.getRequestDispatcher("accountSetting.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void resetPasswordPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        User getUser = (User) request.getSession().getAttribute("user");

        if (getUser != null) {
            boolean hashed_password = d.verifyPassword(currentPassword, getUser.getHash_password());

            if (hashed_password) {
                if (newPassword.equals(confirmPassword)) {
                    d.updateUser(getUser.getEmail(), confirmPassword);
                    request.setAttribute("msg", "Password Updated successfully!");
                } else {
                    request.setAttribute("msg", "Passwords do not match.");
                }
            } else {
                request.setAttribute("msg", "Wrong current password.");
            }
            
            request.setAttribute("activeTab", "security");
            request.getRequestDispatcher("accountSetting.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
