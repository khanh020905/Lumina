package Controller.feature;

import Utils.AIConfig;
import Utils.GeminiCall;
import io.github.cdimascio.dotenv.Dotenv;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "ChatServlet", urlPatterns = {"/api/chat", "/api/learningPath"})
public class GeminiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(404, "Use POST for chat.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("/api/chat")) {
            chatPost(request, response);
        }
    }

    protected void chatPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userMessage = request.getParameter("message");
        response.setContentType("text/plain; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (userMessage == null || userMessage.trim().isEmpty()) {
            out.print("Please type a message.");
            return;
        }

        try {
            String prompt = buildPrompt(userMessage, AIConfig.SYSTEM_INSTRUCTION);
            String reply = GeminiCall.callGemini(prompt);
            out.print(reply);
        } catch (Exception e) {
            e.printStackTrace();
            out.print("System Error: " + e.getMessage());
        }
    }

    private String buildPrompt(String userMessage, String systemInstruction) {
        return systemInstruction + userMessage;
    }
}
