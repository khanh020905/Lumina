package Controller.auth;

import Dal.courseDAO;
import Dal.userDAO;
import Model.Course;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {

    private final userDAO d = new userDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("login")) {
            request.getRequestDispatcher("login.jsp");
        } else if (uri.contains("register")) {
            request.getRequestDispatcher("register.jsp");
        } else if (uri.contains("logout")) {
            logoutPost(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("login")) {
            loginPost(request, response);
        } else if (uri.contains("register")) {
            registerPost(request, response);
        }
    }

    protected void loginPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userKey = request.getParameter("userKey");
        String password = request.getParameter("password");
        String rem = request.getParameter("rememberme");

        User u = d.checkAccount(userKey);
        HttpSession session = request.getSession();
        if (u != null) {
            boolean isVerify = d.verifyPassword(password, u.getHash_password());

            if (isVerify) {
                session.setAttribute("user", u);
                if (rem != null && !rem.isEmpty()) {
                    Cookie userCookie = new Cookie(rem, userKey);
                    userCookie.setMaxAge(60 * 60 * 24 * 7);
                    response.addCookie(userCookie);
                }
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Wrong Password! Please Try Again");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Wrong User Name Or Password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void registerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        String password_hash = d.hashPassword(password);
        boolean isCreated = d.createAccount(username, email, phoneNumber, password_hash, null, null, null);
        User createdUser = null;
        if (isCreated) {
            createdUser = d.checkAccount(username);
        }

        if (isCreated && createdUser != null) {
            session.setAttribute("createdUser", createdUser);
            response.sendRedirect("register.jsp");
        } else {
            if (!isCreated) {
                request.setAttribute("error", "Registration failed. Username/Email/Phone may already be in use.");
            } else {
                request.setAttribute("error", "Registration succeeded, but failed to retrieve user data.");
            }

            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void logoutPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.getAttribute("user");
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
}
