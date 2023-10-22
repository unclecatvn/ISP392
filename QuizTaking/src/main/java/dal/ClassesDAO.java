/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Classes;
import Model.Course;
import Model.Enroll;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class ClassesDAO {

    public int countClass() {
        String sql = "SELECT COUNT(*) FROM Class";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void insertClass(String name, String start, String end) {
        String sql = "insert into Class values (?, ?, ?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, start);
            stm.setString(3, end);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<Classes> getAllClass() {
        ArrayList<Classes> list = new ArrayList<>();
        String sql = "SELECT * FROM Class";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes c = new Classes(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public ArrayList<Classes> getAllTakenClass() {
        ArrayList<Classes> list = new ArrayList<>();
        String sql = "select class_id from Enroll group by class_id";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes c = new Classes(rs.getInt(1));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void insertUser(int classId, int courseId, int studentId, int teacherId) {
        String sql = "insert into Enroll values (?, ?, ?, ?) ";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            stm.setInt(3, studentId);
            stm.setInt(4, teacherId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<User> listAssignTeacher() {
        ArrayList<User> list = new ArrayList<>();
        String sql = "select user_id, roll_number, user_name, email from [user] where role_id = 2";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User c = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public ArrayList<User> listAssignStudent() {
        ArrayList<User> list = new ArrayList<>();
        String sql = "select user_id, roll_number, user_name, email from [user] where role_id = 3";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User c = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void assignTeacher(int teacherId, int classId, int courseId) {
        String sql = "update Enroll set teacher_id = ? where class_id = ? and course_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, teacherId);
            stm.setInt(2, classId);
            stm.setInt(3, courseId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void assignStudent(int classId, int courseId, int studentId, int teacherId) {
        String sql = "insert Enroll values(?,?,?,?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            stm.setInt(3, studentId);
            stm.setInt(4, teacherId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<Enroll> listCourseByClass(int classId) {
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "select Course.course_id, class_id, course_name from Enroll join Course on Enroll.course_id = Course.course_id where class_id = ? group by Course.course_id, class_id, course_name";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getInt(1), rs.getString(3));
                Classes cl = new Classes(rs.getInt(2));
                Enroll e = new Enroll(c, cl);
                list.add(e);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Enroll> studentInClass(int classId, int courseId) {
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "select user_id, user_name, email, roll_number from Enroll join [User] on Enroll.student_id = user_id where class_id = ? and course_id = ? group by user_id, user_name, email, roll_number";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                Enroll e = new Enroll(u);
                list.add(e);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public int getTeacherIdOfClass(int classId, int courseId) {
        String sql = "select teacher_id from Enroll where class_id = ? and course_id = ? group by teacher_id";
        int teacherId = 0;
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                teacherId = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return teacherId;
    }

    public void deleteClassById(int classId) {
        String sql = "DELETE\n"
                + "FROM Class\n"
                + "WHERE class_id= ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void editClassById(int classId, String className, String startDate, String endDate) {
        String sql = "update Class\n"
                + "set class_name = ?, start_date = ?, end_date = ?\n"
                + "where class_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(4, classId);
            stm.setString(1, className);
            stm.setString(2, startDate);
            stm.setString(3, endDate);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public User getUserById(int teacherId) {
        User u = new User();
        String sql = "select user_name, email, phone from [User] where user_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, teacherId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                u = new User(rs.getString(1), rs.getString(2), rs.getString(3));
            }
        } catch (Exception e) {
        }
        return u;
    }
    
    public ArrayList<Enroll> getStudentIdByCourse(int courseId){
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "select student_id from Enroll where course_id = ? group by student_id";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1));
                Enroll e = new Enroll(u);
                list.add(e);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }
    
    public void insertEnroll(int classId, int courseId, int studentId, int teacherId) {
        String sql = "insert Enroll values(?, ?, ?, ?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            stm.setInt(3, studentId);
            stm.setInt(4, teacherId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        ClassesDAO c = new ClassesDAO();
        ArrayList<Enroll> list = c.getStudentIdByCourse(1);
        for (Enroll enroll : list) {
            System.out.println(enroll);
        }
//        for (Enroll enroll : list) {
//            System.out.println(enroll);
//        }
    }
}
