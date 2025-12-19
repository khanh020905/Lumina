package Dal;

import Model.Application;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class applicationDAO extends DBContext {

    public void addApplication(int recruitmentId, int userId, String fullName, String email, String phone, String cvUrl) {
        String sql = "INSERT INTO [dbo].[Application]\n"
                + "           ([recruitment_id]\n"
                + "           ,[user_id]\n"
                + "           ,[full_name]\n"
                + "           ,[email]\n"
                + "           ,[phone]\n"
                + "           ,[cv_url])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, recruitmentId);
            ps.setInt(2, userId);
            ps.setString(3, fullName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, cvUrl);
            ps.execute();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Application hasUserApplied(int recruitmentId, int userId) {
        String sql = "SELECT * FROM Application WHERE recruitment_id=? AND user_id=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, recruitmentId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Application a = new Application();
                a.setId(rs.getInt("id"));
                a.setRecruitmentId(rs.getInt("recruitment_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setFullName(rs.getString("full_name"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setCvUrl(rs.getString("cv_url"));

                return a;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        applicationDAO d = new applicationDAO();

        Application a = d.hasUserApplied(1,22);
        
        System.out.println(a.getEmail());
    }
}
