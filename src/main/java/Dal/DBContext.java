package Dal;

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
