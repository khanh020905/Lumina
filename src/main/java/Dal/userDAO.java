package Dal;

import Model.User;
import at.favre.lib.crypto.bcrypt.BCrypt;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDAO extends DBContext {

    public String hashPassword(String plainTextPassword) {
        return BCrypt.withDefaults().hashToString(12, plainTextPassword.toCharArray());
    }

    public boolean verifyPassword(String plainTextPassword, String storeHash) {
        try {
            return BCrypt.verifyer().verify(plainTextPassword.toCharArray(), storeHash).verified;
        } catch (Exception e) {
            System.out.println("Cannot verify pass word: " + plainTextPassword);
            return false;
        }
    }

    public User checkAccount(String userKey) {
        String sql = "SELECT * FROM Users WHERE username=? OR email=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userKey);
            ps.setString(2, userKey);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setHash_password(rs.getString("hash_password"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setRole(rs.getInt("role_id"));
                user.setUserAvt(rs.getString("user_avt"));
                user.setBio(rs.getString("bio"));
                user.setName(rs.getString("full_name"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean createAccount(String username, String email, String phone, String hash_password, String userAvt, String bio, String name) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([username]\n"
                + "           ,[email]\n"
                + "           ,[phone]\n"
                + "           ,[hash_password]\n"
                + "           ,[role_id]\n"
                + "           ,[user_avt]\n"
                + "           ,[bio]\n"
                + "           ,[full_name]) \n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?, ?)";

        String checkUserAvt = null;

        if (userAvt == null || userAvt.isEmpty()) {
            checkUserAvt = "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";
        } else {
            checkUserAvt = userAvt;
        }

        String checkBio = null;

        if (bio == null || bio.isEmpty()) {
            checkBio = "Hello! Welcome to my Profile";
        }

        if (name == null || name.isEmpty()) {
            name = username;
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, hash_password);
            ps.setInt(5, 3);
            ps.setString(6, checkUserAvt);
            ps.setString(7, checkBio);
            ps.setString(8, name);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void updateUser(String email, String hash_password) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [hash_password] = ?\n"
                + "   WHERE email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hash_password);
            ps.setString(2, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean updateUserSetting(String username, String email, String phoneNumber, String bio, String name) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [username] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[bio] = ?\n"
                + "      ,[full_name] = ?\n"
                + " WHERE email = ?";

        User user = checkAccount(email);

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, phoneNumber != null ? phoneNumber : user.getPhoneNumber());
            ps.setString(3, bio != null ? bio : user.getBio());
            ps.setString(4, name != null ? name : user.getName());
            ps.setString(5, user.getEmail());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    //ver anh Khoa
    public void updateAvt(String email, String avt) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [user_avt] = ?\n"
                + " WHERE email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, avt);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        userDAO d = new userDAO();

        User u = d.checkAccount("lenguyenquockhanh57@gmail.com");

        System.out.println(u.getName());

    }
}
