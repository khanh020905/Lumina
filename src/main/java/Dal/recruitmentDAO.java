package Dal;

import Model.Recruitment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class recruitmentDAO extends DBContext {

    public List<Recruitment> getRecruitment() {
        List<Recruitment> list = new ArrayList<>();

        String sql = "SELECT * FROM Recruitment";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Recruitment r = new Recruitment();
                r.setId(rs.getInt("id"));
                r.setTitle(rs.getString("title"));
                r.setDescription(rs.getString("description"));
                r.setOpenDate(rs.getDate("openDate"));
                r.setCloseDate(rs.getDate("closeDate"));

                list.add(r);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Recruitment getRecruitmentById(int id) {
        String sql = "SELECT * FROM Recruitment WHERE id=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Recruitment r = new Recruitment();
                r.setId(rs.getInt("id"));
                r.setTitle(rs.getString("title"));
                r.setDescription(rs.getString("description"));
                r.setOpenDate(rs.getDate("openDate"));
                r.setCloseDate(rs.getDate("closeDate"));
                return r;
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        recruitmentDAO d = new recruitmentDAO();

       Recruitment r = d.getRecruitmentById(2);

        System.out.println(r.getDescription());
    }
}
