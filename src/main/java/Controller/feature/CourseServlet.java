package Controller.feature;

import Dal.courseDAO;
import Model.Course;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CourseServlet", urlPatterns = {"/courses"})
public class CourseServlet extends HttpServlet {

    private final courseDAO d = new courseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");

        List<Course> finalResultList = new ArrayList<>();

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            finalResultList = d.searchCourse(searchQuery.trim());

            request.setAttribute("searchKeyword", searchQuery.trim());

            request.setAttribute("activeCategory", "All");

        } else {
            if (category == null || category.isEmpty() || category.equals("All")) {
                finalResultList = d.getCourses();
                request.setAttribute("activeCategory", "All");
            } else {
                finalResultList = d.getCourseByCategory(category);
                request.setAttribute("activeCategory", category);
            }
        }

        request.setAttribute("courseList", finalResultList);

        request.getRequestDispatcher("courses.jsp").forward(request, response);
    }
}
