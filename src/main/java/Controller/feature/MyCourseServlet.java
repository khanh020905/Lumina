package Controller.feature;

import Model.Course;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "MyCourseServlet", urlPatterns = {"/myCourses"})
public class MyCourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // right way: get user through session then get List courses by id then setAttribute to jsp
        
        HttpSession session = request.getSession();
        
        List<Course> myCourse = (List<Course>) session.getAttribute("myCourse");
        
        request.setAttribute("myCourse", myCourse);
        request.getRequestDispatcher("myCourses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}
