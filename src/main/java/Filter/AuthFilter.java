package Filter;

import Model.User;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession();

        User currentUser = (User) session.getAttribute("user");

        boolean isLogin = currentUser != null;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        boolean isPublic = uri.contains("/home")
                || uri.contains("/login")
                || uri.contains("/register")
                || uri.contains("/logout")
                || uri.contains("/courses")
                || uri.contains("/course-details")
                || uri.contains("/auth/")
                || uri.contains("/assets/")
                || uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".png")
                || uri.endsWith(".jpg")
                || uri.equals(contextPath + "/")
                || uri.contains("index.jsp")
                || uri.contains("/api/chat")
                || uri.contains("/language")
                || uri.contains("/forgot")
                || uri.contains("/verifyOtp")
                || uri.contains("/resetPassword")
                || uri.contains("/resendOtp")
                || uri.contains("verifyOtp.jsp")
                || uri.contains("resetPassword.jsp")
                || uri.contains("forgot.jsp");

        if (isLogin) {
            chain.doFilter(request, response);
            return;
        }

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        res.sendRedirect("login.jsp");
    }
}
