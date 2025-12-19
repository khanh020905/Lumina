package Controller.auth;

import Dal.userDAO;
import Model.User;
import Service.MailService;
import Utils.generateOtp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ForgotServlet", urlPatterns = {"/forgot", "/verifyOtp", "/resetPassword", "/resendOtp"})
public class ForgotServlet extends HttpServlet {

    private final MailService mail = new MailService();
    private final generateOtp otp = new generateOtp();
    private final userDAO d = new userDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("forgot")) {
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        } else if (uri.contains("verifyOtp")) {
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
        } else if (uri.contains("resetPassword")) {
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } else if (uri.contains("resendOtp")) {
            resendOtpPost(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("forgot")) {
            forgotPost(request, response);
        } else if (uri.contains("verifyOtp")) {
            verifyOtpPost(request, response);
        } else if (uri.contains("resetPassword")) {
            resetPasswordPost(request, response);
        }
    }

    protected void forgotPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        User user = d.checkAccount(email);

        if (user == null) {
            request.setAttribute("error", "Email not found in our system.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        String genOtp = otp.generateOtp();

        otp.storeOtp(email, genOtp);

        boolean isSent = mail.sendMail(email, genOtp);
        if (!isSent) {
            request.setAttribute("error", "OTP send unsucessfully!");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        }

        session.setAttribute("email", email);
        response.sendRedirect("verifyOtp");
    }

    protected void verifyOtpPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String otpGet = request.getParameter("otp");
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        boolean isVerified = otp.verifyOtp(email, otpGet);

        if (isVerified) {
            response.sendRedirect("resetPassword.jsp");
        } else {
            request.setAttribute("error", "Wrong OTP or out of time please try again.");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
            return;
        }
    }

    protected void resetPasswordPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        if (newPassword.equals(confirmPassword)) {
            String hash_password = d.hashPassword(confirmPassword);
            d.updateUser(email, hash_password);
            session.removeAttribute("email");
            response.sendRedirect("login.jsp");
            return;
        } else {
            request.setAttribute("error", "new password must match confirm password.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }

    protected void resendOtpPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        String otpGen = otp.generateOtp();
        otp.storeOtp(email, otpGen);
        boolean isSent = mail.sendMail(email, otpGen);

        if (!isSent) {
            request.setAttribute("error", "OTP send unsucessfully!");

        } else {
            request.setAttribute("success", "A new OTP has been sent to your email.");
        }

        request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
    }
}
