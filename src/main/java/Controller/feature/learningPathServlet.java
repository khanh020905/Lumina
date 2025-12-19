package Controller.feature;

import Dal.applicationDAO;
import Dal.courseDAO;
import Dal.recruitmentDAO;
import Model.Application;
import Model.Course;
import Model.Recruitment;
import Model.User;
import Utils.AIConfig;
import Utils.GeminiCall;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "learningPathServlet", urlPatterns = {"/createPath"})
public class learningPathServlet extends HttpServlet {

    private final recruitmentDAO d = new recruitmentDAO();
    private final applicationDAO ad = new applicationDAO();
    private final courseDAO cd = new courseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String semesterStr = request.getParameter("semester");
        String specific = request.getParameter("specialization");
        String[] skills = request.getParameterValues("skills");
        HttpSession session = request.getSession();

        int semester = 0;
        try {
            semester = Integer.parseInt(semesterStr);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        List<String> semesterCourse = AIConfig.semesterCourse().getOrDefault(semester, new ArrayList<>());

        String userSpecific = "";
        switch (specific) {
            case "se":
                userSpecific = "Software Engineering";
                break;
            case "ai":
                userSpecific = "Artificial Intelligence";
                break;
            case "web-front":
                userSpecific = "Front-end Development";
                break;
            case "web-back":
                userSpecific = "Back-end Development";
                break;
            case "full-stack":
                userSpecific = "Full-Stack Development";
                break;
            case "java":
                userSpecific = "Deep Java";
                break;
            case "mobile":
                userSpecific = "Mobile App Dev";
                break;
            case "data":
                userSpecific = "Data Science";
                break;
        }

        String userSkills = "";

        if (skills != null) {
            for (String s : skills) {
                userSkills += s + ", ";
            }
        }

        String prompt = AIConfig.promptLearningPath(semester, userSpecific, userSkills, semesterCourse);

        String reply = null;

        try {
            reply = GeminiCall.callGemini(prompt);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        Map<String, String> learningPath = jsonSolve(reply);
        Map<Course, String> courseMap = new HashMap();

        if (learningPath != null) {
            for (Map.Entry<String, String> entry : learningPath.entrySet()) {
                String courseCode = entry.getKey();
                String reason = entry.getValue();

                courseMap.put(cd.getCourseByCode(courseCode), reason);
            }
        }
        System.out.println(courseMap);

        session.removeAttribute("learningPath");
        session.setAttribute("courseMap", courseMap);
        response.sendRedirect("learningResult.jsp");
    }

    public Map<String, String> jsonSolve(String reply) {
        if (reply.contains("```")) {
            reply = reply.replaceAll("```json", "");
            reply = reply.replaceAll("```", "");
        }

        JSONObject jsonResponse = new JSONObject(reply);

        JSONArray jo = jsonResponse.getJSONArray("relevantCourses");
        Map<String, String> learningPath = new HashMap<>();

        for (int i = 0; i < jo.length(); i++) {
            JSONObject course = jo.getJSONObject(i);

            String courseCode = course.getString("courseCode");
            String reason = course.getString("reason");

            learningPath.put(courseCode, reason);
        }
        return learningPath;
    }
}
