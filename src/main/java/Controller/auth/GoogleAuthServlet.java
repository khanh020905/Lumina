package Controller.auth;

import Dal.userDAO;
import Model.User;
import Utils.CloudinaryConfig;
import com.cloudinary.utils.ObjectUtils;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

@WebServlet(name = "GoogleServlet", urlPatterns = {"/auth/google", "/auth/google/callback"})
public class GoogleAuthServlet extends HttpServlet {

    private final String CLIENT_ID = "922060682286-edvm7r75dkis9a371jpou899uo8n39j4.apps.googleusercontent.com";
    private final String CLIENT_SECRET = "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";
    private final String REDIRECT_URI = "https://lumina-1-3col.onrender.com/CourseManagement/auth/google/callback";
    private final String SCOPE = "openid email profile";
    private final String OAUTH_PASSWORD_HASH = "OAUTH_LOGIN_ONLY";
    private final String OAUTH_PHONE = "OAUTH_PHONE_ONLY";

    private final userDAO d = new userDAO();
    private final CloudinaryConfig cconfig = new CloudinaryConfig();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("/auth/google") && !uri.endsWith("callback")) {
            authGet(request, response);
        } else if (uri.endsWith("callback")) {
            callbackGet(request, response);
        }
    }

    protected void authGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oauthUrl = "https://accounts.google.com/o/oauth2/auth?"
                + "scope=" + SCOPE
                + "&redirect_uri=" + REDIRECT_URI
                + "&response_type=code"
                + "&client_id=" + CLIENT_ID
               // + "&prompt=select_account"
                + "&access_type=offline";

        response.sendRedirect(oauthUrl);
    }

    protected void callbackGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        final String CONTEXT_PATH = request.getContextPath();

        try {
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(new NetHttpTransport(),
                    GsonFactory.getDefaultInstance(),
                    CLIENT_ID, CLIENT_SECRET, code, REDIRECT_URI).execute();

            String idTokenString = tokenResponse.getIdToken();
            GoogleIdToken idToken = GoogleIdToken.parse(GsonFactory.getDefaultInstance(), idTokenString);
            GoogleIdToken.Payload payload = idToken.getPayload();

            String email = payload.getEmail();
            String username = (String) payload.get("name");
            String avt = (String) payload.get("picture");

            User checkExist = d.checkAccount(email);

            if (checkExist == null) {

                Map uploadResult = cconfig.getCloudinary().uploader().upload(avt, ObjectUtils.asMap(
                        "folder", "user_uploads",
                        "resource_type", "image"
                ));
                
                String getUrl = (String) uploadResult.get("url");

                boolean isCreated = d.createAccount(username, email, OAUTH_PHONE, OAUTH_PASSWORD_HASH, getUrl, null, null);

                if (isCreated) {
                    User newUser = d.checkAccount(email);

                    if (newUser != null) {
                        request.getSession().setAttribute("user", newUser);
                        response.sendRedirect(CONTEXT_PATH + "/home.jsp");
                        return;
                    } else {
                        request.getSession().setAttribute("error", "Account created but failed to log in automatically. Please try logging in manually.");
                        response.sendRedirect(CONTEXT_PATH + "/login.jsp");
                        return;
                    }
                } else {
                    request.getSession().setAttribute("error", "Sign-up failed. Please check your details or try manually.");
                    response.sendRedirect(CONTEXT_PATH + "/login.jsp");
                    return;
                }
            } else {
                request.getSession().setAttribute("user", checkExist);
                response.sendRedirect(CONTEXT_PATH + "/home");
                return;
            }
        } catch (IOException e) {
            System.err.println("Google OAuth Token Exchange Error: " + e.getMessage());
            e.printStackTrace();

            request.getSession().setAttribute("error", "Google sign-in failed. Please try again.");
            response.sendRedirect(CONTEXT_PATH + "/login.jsp");
            return;
        }
    }
}
