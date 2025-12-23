package Dal;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;
    Dotenv env = Dotenv.load();

    public DBContext() {
        try {
            String url = env.get("DB_URL");
            String username = env.get("DB_USER");
            String password = env.get("DB_PASSWORD");
            String driver = env.get("DB_DRIVER");

            if (driver == null || url == null) {
                throw new RuntimeException("Database environment variables (DB_URL, DB_DRIVER, etc.) are not set!");
            }

            Class.forName(driver);

            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Database connected successfully using Environment Variables!");

        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Connection Error: " + ex.getMessage());
        } catch (Exception e) {
            System.out.println("General Error: " + e.getMessage());
        }
    }
}
