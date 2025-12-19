package Controller.feature;

import Dal.courseDAO;
import Model.Course;
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

@WebServlet(name = "CartServlet", urlPatterns = {"/addToCart", "/removeFromCart", "/paid"})
public class CartServlet extends HttpServlet {

    private final courseDAO d = new courseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("/addToCart")) {
            addToCartGet(request, response);
        } else if (uri.contains("/removeFromCart")) {
            removeFromCartGet(request, response);
        } else if (uri.contains("/paid")) {
            paidGet(request, response);
        }
    }

    protected void addToCartGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        HttpSession session = request.getSession();

        if (idStr == null || idStr.trim().isEmpty()) {
            session.setAttribute("error", "Invalid course code.");
            response.sendRedirect("courses");
            return;
        }

        int id = 0;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        Course course = d.getCourseById(id);

        if (course == null) {
            session.setAttribute("error", "Course not found.");
            response.sendRedirect("courses");
            return;
        }

        List<Course> cart = (List<Course>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean isExisted = false;
        for (Course c : cart) {
            if (c.getCourseCode() != null && c.getCourseCode().equals(course.getCourseCode())) {
                isExisted = true;
                break;
            }
        }

        if (!isExisted) {
            cart.add(course);
            session.setAttribute("cart", cart);
            session.setAttribute("success", "Course added successfully!");
        } else {
            session.setAttribute("error", "You have already added this course!");
        }

        String referer = request.getHeader("Referer");

        // Prevent redirect loops
        if (referer == null || referer.contains("addToCart") || referer.contains("removeFromCart")) {
            response.sendRedirect("courses");
        } else {
            response.sendRedirect(referer);
        }
    }

    protected void removeFromCartGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexStr = request.getParameter("index");

        if (indexStr != null) {
            try {
                int index = Integer.parseInt(indexStr);
                HttpSession session = request.getSession();
                List<Course> cart = (List<Course>) session.getAttribute("cart");

                if (cart != null && index >= 0 && index < cart.size()) {
                    cart.remove(index);
                    session.setAttribute("cart", cart);
                    session.setAttribute("success", "Item removed successfully!");
                }

            } catch (NumberFormatException e) {
                System.out.println("Error parsing index: " + e.getMessage());
            }
        }
        response.sendRedirect("cart.jsp");
    }

    protected void paidGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        List<Course> cartItems = (List<Course>) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cartItems == null) {
            request.setAttribute("error", "You don't have any Course.");
            request.getRequestDispatcher("cart.jsp");
            return;
        }

        List<Course> myCourse = (List<Course>) session.getAttribute("myCourse");
        if (myCourse == null) {
            myCourse = new ArrayList<>();
        }

        for (Course c : cartItems) {
            d.insertCourseUserBuy(user.getId(), c.getId(), c.getPrice());
            myCourse.add(c);
        }

        session.removeAttribute("cart");
        session.setAttribute("success", "Payment successful! You are now enrolled.");
        session.setAttribute("myCourse", myCourse);

        response.sendRedirect("cart.jsp");
    }
}
