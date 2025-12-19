package Dal;

import Model.Notification;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class notificationDAO extends DBContext {

    public Notification getActiveNotification() {
        String sql = "SELECT * FROM Notification WHERE is_active=1 ORDER BY id desc";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Notification noti = new Notification();
                noti.setId(rs.getInt("id"));
                noti.setMessage(rs.getString("message"));
                noti.setType(rs.getString("type"));
                noti.setButtonText(rs.getString("button_text"));
                noti.setButtonUrl(rs.getString("button_url"));
                noti.setIsActive(rs.getInt("is_active"));

                return noti;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static void main(String[] args) {
        notificationDAO d = new notificationDAO();
        
        Notification noti = d.getActiveNotification();
        
        System.out.println(noti.getType());
    }
}
