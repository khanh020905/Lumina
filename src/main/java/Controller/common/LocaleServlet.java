package Controller.common;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.jsp.jstl.core.Config;

@WebServlet(name = "LocaleServlet", urlPatterns = {"/language"})
public class LocaleServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lang = request.getParameter("lang");
        HttpSession session = request.getSession();
        
        if (lang != null && lang.equals("en") || lang.equals("vi")) {
            Config.set(session, Config.FMT_LOCALE, new java.util.Locale(lang));
            
            session.setAttribute("lang", lang);
        }
        
        String referer = request.getHeader("Referer");
        if(referer != null){
            response.sendRedirect(referer);
        }else{
            response.sendRedirect("home");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}
