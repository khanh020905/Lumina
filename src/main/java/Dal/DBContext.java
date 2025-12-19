package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Retrieve credentials from environment variables (for Render)
            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            // Load the PostgreSQL Driver
            Class.forName("org.postgresql.Driver");

            if (url == null || username == null || password == null) {
                // --- LOCALHOST (PostgreSQL) ---
                // Default PostgreSQL local port is 5432
                String dbName = "lumina";
                String port = "5432"; 
                String ip = "localhost";
                
                // PostgreSQL JDBC URL format
                String connectionUrl = "jdbc:postgresql://" + ip + ":" + port + "/" + dbName;
                
                // Replace "postgres" and "your_password" with your local pgAdmin credentials
                connection = DriverManager.getConnection(connectionUrl, "postgres", "your_password");
            } else {
                // --- REMOTE (Render/PostgreSQL) ---
                // Render environment variables usually provide the correct JDBC string
                connection = DriverManager.getConnection(url, username, password);
            }
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Connection Error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}