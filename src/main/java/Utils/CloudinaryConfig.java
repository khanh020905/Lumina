package Utils;

import com.cloudinary.Cloudinary;
import io.github.cdimascio.dotenv.Dotenv;

public class CloudinaryConfig {

    public Cloudinary getCloudinary() {
        Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();

        String CLOUDINARY_URL = dotenv.get("CLOUDINARY_URL");

        if (CLOUDINARY_URL == null) {
            CLOUDINARY_URL = System.getenv("CLOUDINARY_URL");
        }

        if (CLOUDINARY_URL == null) {
            throw new RuntimeException("CLOUDINARY_URL is not set in .env or environment variables!");
        }

        return new Cloudinary(CLOUDINARY_URL);
    }
}
