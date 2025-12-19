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

            if (url == null || username == null || password == null) {
                // --- LOCALHOST (SQL Server) ---
                String dbName = "CourseManagement";
                String port = "1433";
                String ip = "localhost";
                
                // Load SQL Server Driver
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                
                String connectionUrl = "jdbc:sqlserver://" + ip + ":" + port + 
                                       ";databaseName=" + dbName + 
                                       ";encrypt=true;trustServerCertificate=true;";
                connection = DriverManager.getConnection(connectionUrl, "sa", "123");
            } else {
                // --- RENDER (PostgreSQL) ---
                // Load PostgreSQL Driver
                Class.forName("org.postgresql.Driver");
                
                // Render provides the full URL in the environment variable, 
                // so we just pass it directly.
                connection = DriverManager.getConnection(url, username, password);
            }
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Connection Error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}