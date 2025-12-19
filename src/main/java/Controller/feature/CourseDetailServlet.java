package Controller.feature;

import Dal.courseDAO;
import Model.Course;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CourseDetailServlet", urlPatterns = {"/course-details"})
public class CourseDetailServlet extends HttpServlet {

    private courseDAO d = new courseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        int id = 0;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        if (idStr != null && !idStr.isEmpty()) {
            Course course = d.getCourseById(id);
            request.setAttribute("course", course);
        }

        request.getRequestDispatcher("course-details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
