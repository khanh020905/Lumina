package Dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Lấy biến từ Render (Đảm bảo tên biến trên Render là DB_USER và DB_PASSWORD)
            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            Class.forName("org.postgresql.Driver");

            if (url != null && username != null) {
                // TỰ ĐỘNG SỬA LỖI: Driver JDBC yêu cầu tiền tố "jdbc:postgresql://"
                if (!url.startsWith("jdbc:postgresql://")) {
                    url = "jdbc:" + url;
                }

                // Nếu URL vẫn chứa 'user:pass@', Driver có thể bị lỗi parse khi dùng 3 tham số.
                // Giải pháp tốt nhất là truyền URL sạch (chỉ host/dbname)
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Connected to Render PostgreSQL successfully!");
            } else {
                // Chạy Localhost
                String localUrl = "jdbc:postgresql://localhost:5432/lumina";
                connection = DriverManager.getConnection(localUrl, "postgres", "your_password");
            }
        } catch (Exception ex) {
            System.err.println("Database Connection Error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
