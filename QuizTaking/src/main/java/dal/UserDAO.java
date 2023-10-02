/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.SendMail;

/**
 *
 * @author HoaiNam
 */
public class UserDAO {

    //Login google
    public User loginByGoogle(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
                return u;
            }

        } catch (Exception e) {
            System.out.println("loginByGoogle Error:" + e.getMessage());
        }
        return null;
    }

    //login
    public User login(String email, String password) {
        try {
            String sql = "SELECT * FROM [User] where email = ? and password = ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
                return u;
            }
        } catch (Exception e) {
            System.out.println("login Error:" + e.getMessage());
        }
        return null;
    }

    public User UpDatePassWord(String password, String email) {
        try {
            String sql = "UPDATE [User]\n"
                    + "   SET [password] = ?\n"
                    + " WHERE [email] = ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updatePassword Error:" + e.getMessage());
        }
        return null;
    }

    public User getUserById(int id) {
        String sql = "SELECT *\n"
                + "FROM [User]\n"
                + "WHERE user_id = ? ";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            rs = stm.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
            }
        } catch (Exception e) {
            System.out.println("add Error:" + e.getMessage());
        }
        return null;
    }

    public User getUserByGmail(String gmail) {
        String sql = "SELECT *\n"
                + "FROM [User]\n"
                + "WHERE email = ? ";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, gmail);
            ResultSet rs = stm.executeQuery();
            rs = stm.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
            }
        } catch (Exception e) {
            System.out.println("add Error:" + e.getMessage());
        }
        return null;
    }

    public UserDAO() {
        connectDB();
    }

    Connection cnn = null; // ket noi db
    PreparedStatement stm = null; // thuc thi cac cau lenh sql
    ResultSet rs = null; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public void updateUser(String user_name, String phone, boolean gender, String rollNumber, int role_id, String email) {
        String query = "update [User] "
                + "set user_name=?, "
                + "phone=?, "
                + "gender=?, "
                + "roll_number=?, "
                + "role_id=? "
                + "where email=?";
        try {
            cnn = new DBContext().getConnection();
            stm = cnn.prepareStatement(query);
            stm.setString(1, user_name);
            stm.setString(2, phone);
            stm.setBoolean(3, gender);
            stm.setString(4, rollNumber);
            stm.setInt(5, role_id);
            stm.setString(6, email);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public ArrayList<User> getAllUser() {
        ArrayList<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
                list.add(u);
            }

        } catch (Exception e) {
        }
        return list;
    }

    //Vanhle
    public boolean checkEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            boolean exists = rs.next();
            return exists;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void sendEmailForgot(String email) {
        try {
            String forgotKey = "";
            forgotKey = new SendMail().createCaptcha();
            String sql = "UPDATE [dbo].[User]\n"
                    + "   SET [forgot_key] = ?\n"
                    + " WHERE [email] = ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, forgotKey);
            stm.setString(2, email);
            stm.executeUpdate();
            new SendMail().send(email, "Forgot password", "Hi, we get a request for password change, click on the link below to confirm (1 minute period):\n"
                    + "If you don't do that, ignore it\n"
                    + "OTP CODE: " + forgotKey + "\n"
                    + "Or you can click the link below:\n"
                    + "http://localhost:8080/QuizPractice/confirmKey?email=" + email + "&forgot_key=" + forgotKey);
        } catch (Exception e) {
        }
    }

    public void removeForgotKey(String email) {
        try {
            String sql = "UPDATE [User]\n"
                    + "   SET forgot_key = NULL\n"
                    + " WHERE email = ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, email);
            stm.executeUpdate();
        } catch (Exception ex) {

        }
    }

    public boolean checkForgotKeyExist(String email, String forgotKey) {
        try {
            String sql = "SELECT * FROM [User] WHERE [email] = ? AND forgot_key= ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, forgotKey);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (Exception e) {
        }
        return false;
    }

    public void changePassword(String password, String email) {
        try {
            String sql = "UPDATE [User]\n"
                    + "   SET [password] = ?\n"
                    + " WHERE [email] = ?";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updatePassword Error:" + e.getMessage());
        }
    }

    public int countUserByRoleId(int roleId) {
        String sql = "SELECT COUNT(*) FROM [User]\n"
                + "WHERE role_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, roleId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    //end Vanhle

    public ArrayList<User> search(boolean status, int role_id, String name) {
        ArrayList<User> list = new ArrayList<>();
        String sql = "select * from [User] where\n"
                + "status = ? and role_id = ? and user_name like ?";

        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, role_id);
            stm.setString(3, "%" + name + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getInt(8),
                        rs.getString(9));
                list.add(u);
            }

        } catch (Exception e) {
        }
        return list;
    }

    public void updateUserAdmin(int id, String user_name, String email, boolean gender, String password, String phone, boolean status, int role_id, String rollNumber) {
        String query
                = "update [User] set user_name = ?, \n"
                + "email = ?, gender = ?, password = ?, phone = ?, status = ?, role_id = ?, roll_number = ?\n"
                + "where user_id = ?";
        try {
            cnn = new DBContext().getConnection();
            stm = cnn.prepareStatement(query);
            stm.setString(1, user_name);
            stm.setString(2, email);
            stm.setBoolean(3, gender);
            stm.setString(4, password);
            stm.setString(5, phone);
            stm.setBoolean(6, status);
            stm.setInt(7, role_id);
            stm.setString(8, rollNumber);
            stm.setInt(9, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void deleteUserByID(int id) {
        String query = "delete from [User] where user_id = ?";
        try {
            cnn = new DBContext().getConnection();
            stm = cnn.prepareStatement(query);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {

        }
    }

    public void createNewProfile(String user_name, String email, boolean gender, String password, String phone, boolean status, int role_id, String rollNumber) {
        String query = "insert into [User] (user_name, email, gender, password, phone, status, role_id, roll_number)\n"
                + "values(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            cnn = new DBContext().getConnection();
            stm = cnn.prepareStatement(query);
            stm.setString(1, user_name);
            stm.setString(2, email);
            stm.setBoolean(3, gender);
            stm.setString(4, password);
            stm.setString(5, phone);
            stm.setBoolean(6, status);
            stm.setInt(7, role_id);
            stm.setString(8, rollNumber);
            stm.executeUpdate();
            new SendMail().send(email, "Your temporary password", "Hi, we send you the temporary password"
                    + "If you don't do that, ignore it\n"
                    + "Password: " + password + "\n");

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public int[] getClassIDStudent(int sId) {

        String query
                = "select class_id from Enroll join [User] on student_id = user_id where student_id = ?";
        try {
            cnn = new DBContext().getConnection();
            stm = cnn.prepareStatement(query);
            stm.setInt(1, sId);
            ResultSet rs = stm.executeQuery();
            int i = 0;
            while (rs.next()) {
                i++;
            }
            int[] arr = new int[i];
            while (rs.next()) {
                for (int j = 0; j < i; i++) {
                    arr[j] = rs.getInt(1);
                }
            }
            return arr;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        //dao.updateUser("hahaha", email, phone, true, rollNumber, 0);
        //dao.updateUser("haha",  "11111", false, "h111", 2, "haha@fpt.edu.vn");
//        User u = dao.getUserById(9);
//        System.out.println(u);
//        if(dao.checkEmail("ssss")==true){
//            System.out.println("Yes");
//        } else {
//            System.out.println("No");
//        }
//        User u = dao.loginByGoogle("anhlvhe172133@fpt.edu.vn");
//        System.out.println(u.toString());
//        if(dao.checkEmail("anhlvhe172133@fpt.edu.vn")==true){
//            System.out.println("hehe");
//        } else {
//            System.out.println("Nothing");
//        }
//        dao.sendEmailForgot("anhlvhe172133@fpt.edu.vn");
//        if (dao.checkForgotKeyExist("anhlvhe172133@fpt.edu.vn", "bITFj0") == true) {
//            System.out.println("True");
//        } else {
//            System.out.println("False");
//        }
//        dao.changePassword("1235", "anhlvhe172133@fpt.edu.vn");
        System.out.println(dao.countUserByRoleId(2));
    }

}
