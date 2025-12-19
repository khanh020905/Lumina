package Dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Lấy thông tin từ Environment Variables của Render
            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            Class.forName("org.postgresql.Driver");

            if (url != null && username != null) {
                // TỰ ĐỘNG SỬA LỖI: Thêm tiền tố jdbc: nếu thiếu
                if (!url.startsWith("jdbc:postgresql://")) {
                    url = "jdbc:" + url;
                }

                // Kết nối bằng URL sạch và các tham số xác thực riêng biệt
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Connected to Render PostgreSQL successfully!");
            } else {
                // Chạy Localhost (Nếu không tìm thấy biến môi trường)
                connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/lumina", "postgres", "your_password");
            }
        } catch (Exception ex) {
            System.err.println("Database Connection Error: " + ex.getMessage());
            ex.printStackTrace();
        }

    }
}
