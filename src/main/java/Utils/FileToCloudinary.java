package Utils;

import Dal.DBContext;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

public class FileToCloudinary extends DBContext {

    private static final String IMAGE_FOLDER_PATH = "D:\\Quoc Khanh\\CourseBanner";
    private static final CloudinaryConfig cconfig = new CloudinaryConfig();

    public void fileToCloudinary() {
        try {
            Cloudinary cloudinary = cconfig.getCloudinary();

            File folder = new File(IMAGE_FOLDER_PATH);
            File[] fileLists = folder.listFiles();

            if (fileLists == null || fileLists.length == 0) {
                System.out.println("No file detected!");
            }

            for (File file : fileLists) {
                if (file.isFile()) {
                    String fileName = file.getName();

                    String courseId = fileName.substring(0, fileName.lastIndexOf('.'));

                    System.out.print("Processing Course: " + courseId + "... ");

                    try {
                        Map uploadResult = cloudinary.uploader().upload(file, ObjectUtils.asMap(
                                "folder", "course_thumbnails",
                                "public_id", courseId,
                                "overwrite", true
                        ));

                        String cloudUrl = (String) uploadResult.get("url");

                        String sql = "UPDATE Course SET img_url = ? WHERE course_code = ?";

                        PreparedStatement ps = connection.prepareStatement(sql);
                        ps.setString(1, cloudUrl);
                        ps.setString(2, courseId);
                        ps.executeUpdate();

                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        FileToCloudinary file = new FileToCloudinary();
        
        file.fileToCloudinary();
    }
}
