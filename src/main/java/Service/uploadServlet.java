package Service;

import Dal.userDAO;
import Model.User;
import Utils.CloudinaryConfig;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.Map;

@WebServlet(name = "uploadServlet", urlPatterns = {"/uploadImage"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 50
)
public class uploadServlet extends HttpServlet {

    private CloudinaryConfig cconfig = new CloudinaryConfig();
    private userDAO d = new userDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Part filePart = request.getPart("imageFile");

            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("Error: No file selected.");
                return;
            }

            Cloudinary cloudinary = cconfig.getCloudinary();
            byte[] fileBytes = filePart.getInputStream().readAllBytes();

            Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap(
                    "folder", "user_uploads",
                    "resource_type", "image"
            ));

            String imageUrl = (String) uploadResult.get("url");
            String publicId = (String) uploadResult.get("public_id");
            d.updateAvt(currentUser.getEmail(), imageUrl);

            User afterChangeUser = d.checkAccount(currentUser.getEmail());
            session.setAttribute("user", afterChangeUser);

            request.setAttribute("msg", "Upload successful!");

            request.getRequestDispatcher("accountSetting.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Upload failed: " + e.getMessage());
        }
    }
}
