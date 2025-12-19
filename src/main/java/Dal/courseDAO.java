package Dal;

import Model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class courseDAO extends DBContext {

    public List<Course> getCourses() {
        List<Course> list = new ArrayList<>();

        String sql = "SELECT * FROM Course";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setDuration(rs.getInt("duration"));
                course.setRating(rs.getInt("rating"));
                course.setStatus(rs.getInt("status"));
                course.setCategory(rs.getString("category"));
                course.setImg_url(rs.getString("img_url"));

                list.add(course);
            }
            rs.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Course> getCourseByCategory(String category) {
        String sql = "SELECT * FROM Course WHERE category=?";

        List<Course> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setDuration(rs.getInt("duration"));
                course.setRating(rs.getInt("rating"));
                course.setStatus(rs.getInt("status"));
                course.setCategory(rs.getString("category"));
                course.setImg_url(rs.getString("img_url"));

                list.add(course);
            }
            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Course getCourseByCode(String courseCode) {
        String sql = "SELECT * FROM Course WHERE course_code=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, courseCode);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setDuration(rs.getInt("duration"));
                course.setRating(rs.getInt("rating"));
                course.setStatus(rs.getInt("status"));
                course.setCategory(rs.getString("category"));
                course.setImg_url(rs.getString("img_url"));

                return course;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Course getCourseById(int id) {
        String sql = "SELECT * FROM Course WHERE course_id=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setDuration(rs.getInt("duration"));
                course.setRating(rs.getInt("rating"));
                course.setStatus(rs.getInt("status"));
                course.setCategory(rs.getString("category"));
                course.setImg_url(rs.getString("img_url"));

                return course;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Course> searchCourse(String keyword) {
        String sql = "SELECT * FROM Course WHERE course_code LIKE ? OR title LIKE ?";
        List<Course> courseList = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course course = new Course();

                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setDuration(rs.getInt("duration"));
                course.setRating(rs.getInt("rating"));
                course.setStatus(rs.getInt("status"));
                course.setCategory(rs.getString("category"));
                course.setImg_url(rs.getString("img_url"));
                courseList.add(course);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return courseList;
    }

    public void insertCourseUserBuy(int userId, int courseId, double price) {
        String sql = "INSERT INTO [dbo].[Enrollment]\n"
                + "           ([user_id]\n"
                + "           ,[course_id]\n"
                + "           ,[price_paid])\n"
                + "     VALUES\n"
                + "           (?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setDouble(3, price);
            ps.execute();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        courseDAO d = new courseDAO();

       Course course = d.getCourseById(1);
       
        System.out.println(course.getCourseCode());
    }
}
