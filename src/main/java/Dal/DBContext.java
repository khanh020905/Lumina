package Dal;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");
            String driver = System.getenv("DB_DRIVER");

            if (url == null) {
                Dotenv env = Dotenv.load();
                url = env.get("DB_URL");
                username = env.get("DB_USER");
                password = env.get("DB_PASSWORD");
                driver = env.get("DB_DRIVER");
            }

            if (url == null || driver == null) {
                throw new RuntimeException("DATABASE ENV NOT FOUND");
            }

            System.out.println("===== DB DEBUG =====");
            System.out.println("URL=" + url);
            System.out.println("USER=" + username);
            System.out.println("DRIVER=" + driver);
            System.out.println("====================");

            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);

            System.out.println("Database connected successfully");

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("DATABASE CONNECTION FAILED");
        }
    }
}
