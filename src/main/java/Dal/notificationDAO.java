package Dal;

import Model.Notification;
import java.sql.*;

public class notificationDAO extends DBContext {

    public Notification getActiveNotification() {

        String sql = """
            SELECT *
            FROM notifications
            WHERE is_active = true
            ORDER BY id DESC
            LIMIT 1
        """;

        try (
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                Notification noti = new Notification();
                noti.setId(rs.getInt("id"));
                noti.setMessage(rs.getString("message"));
                noti.setType(rs.getString("type"));
                noti.setButtonText(rs.getString("button_text"));
                noti.setButtonUrl(rs.getString("button_url"));
                noti.setIsActive(rs.getBoolean("is_active"));
                return noti;
            }

        } catch (Exception e) {
            e.printStackTrace(); // IMPORTANT
        }

        return null;
    }
}
