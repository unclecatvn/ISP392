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
public class EnrollDAO {

    public ArrayList<Enroll> getAllCourseByUser(int studentId) {
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    e.teacher_id,\n"
                + "    (\n"
                + "        SELECT user_name \n"
                + "        FROM [User] \n"
                + "        WHERE user_id = e.teacher_id\n"
                + "    ) AS teacher_name,\n"
                + "    (\n"
                + "        SELECT COUNT(*) \n"
                + "        FROM Enroll \n"
                + "        WHERE class_id = c.class_id AND course_id = co.course_id\n"
                + "    ) AS total_student\n"
                + "FROM Class c\n"
                + "JOIN Enroll e ON c.class_id = e.class_id\n"
                + "JOIN Course co ON co.course_id = e.course_id\n"
                + "JOIN [User] u ON u.user_id = e.student_id\n"
                + "WHERE u.user_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, studentId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"), rs.getString("class_name"), rs.getDate("start_date"), rs.getDate("end_date"));
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                User u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"));
                Enroll e = new Enroll(s, c, u, rs.getInt("total_student"));
                list.add(e);
            }
//            return list;

        } catch (Exception e) {
        }
        return list;
    }

    public ArrayList<Enroll> getAllCourseByTeacher(int teacherId) {
        ArrayList<Enroll> listTea = new ArrayList<>();
        String sql = "SELECT \n"
                + "    c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    e.teacher_id,\n"
                + "    (\n"
                + "        SELECT user_name \n"
                + "        FROM [User] \n"
                + "        WHERE user_id = e.teacher_id\n"
                + "    ) AS teacher_name,\n"
                + "    (\n"
                + "        SELECT COUNT(*) \n"
                + "        FROM Enroll \n"
                + "        WHERE class_id = c.class_id AND course_id = co.course_id\n"
                + "    ) AS total_student\n"
                + "FROM Class c\n"
                + "JOIN Enroll e ON c.class_id = e.class_id\n"
                + "JOIN Course co ON co.course_id = e.course_id\n"
                + "JOIN [User] u ON u.user_id = e.teacher_id\n"
                + "WHERE e.teacher_id = ?\n"
                + "GROUP BY c.class_id,\n"
                + "    c.class_name,\n"
                + "    co.course_id,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    e.teacher_id";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, teacherId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"), rs.getString("class_name"), rs.getDate("start_date"), rs.getDate("end_date"));
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                User u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"));
                Enroll e = new Enroll(s, c, u, rs.getInt("total_student"));
                listTea.add(e);
            }
            return listTea;

        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Enroll> getAllCourse() {
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    e.teacher_id,\n"
                + "    (\n"
                + "        SELECT user_name \n"
                + "        FROM [User] \n"
                + "        WHERE user_id = e.teacher_id\n"
                + "    ) AS teacher_name,\n"
                + "    (\n"
                + "        SELECT COUNT(*) \n"
                + "        FROM Enroll \n"
                + "        WHERE class_id = c.class_id AND course_id = co.course_id\n"
                + "    ) AS total_student\n"
                + "FROM Class c\n"
                + "JOIN Enroll e ON c.class_id = e.class_id\n"
                + "JOIN Course co ON co.course_id = e.course_id\n"
                + "JOIN [User] u ON u.user_id = e.teacher_id\n"
                + "GROUP BY c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    e.teacher_id";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"), rs.getString("class_name"), rs.getDate("start_date"), rs.getDate("end_date"));
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                User u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"));
                Enroll e = new Enroll(s, c, u, rs.getInt("total_student"));
                list.add(e);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public int getAllClassAndCourseWorking() {
        String sql = "SELECT COUNT(*) AS Total\n"
                + "FROM (\n"
                + "    SELECT c.class_id, co.course_id\n"
                + "    FROM Class c\n"
                + "    JOIN Enroll e\n"
                + "    ON e.class_id = c.class_id\n"
                + "    JOIN Course co\n"
                + "    ON co.course_id = e.course_id\n"
                + "    GROUP BY c.class_id, co.course_id\n"
                + ") AS Subquery;";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList<Enroll> getAllClassByCourseId(int courseId) {
        ArrayList<Enroll> list = new ArrayList<>();
        String sql = "SELECT c.class_id,c.class_name,c.start_date,c.end_date,\n"
                + "co.course_id,co.course_name, co.course_description,\n"
                + "u.user_id AS teacher_id, u.user_name AS teacher_name,\n"
                + "(SELECT COUNT(*) FROM Enroll WHERE class_id = c.class_id AND co.course_id = course_id) AS total_student\n"
                + "FROM Enroll e\n"
                + "JOIN Course co\n"
                + "ON co.course_id = e.course_id\n"
                + "JOIN Class c\n"
                + "ON c.class_id = e.class_id\n"
                + "JOIN [User] u \n"
                + "ON u.user_id = e.teacher_id\n"
                + "WHERE co.course_id = ?\n"
                + "GROUP BY  c.class_id,c.class_name,c.start_date,c.end_date,\n"
                + "co.course_id,co.course_name, co.course_description,\n"
                + "u.user_id, u.user_name";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"), rs.getString("class_name"), rs.getDate("start_date"), rs.getDate("end_date"));
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                User u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"));
                Enroll e = new Enroll(s, c, u, rs.getInt("total_student"));
                list.add(e);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public Enroll getCourseById(int classId, int courseId) {
//        String sql = "SELECT \n"
//                + "    c.class_id,\n"
//                + "    c.class_name,\n"
//                + "	c.start_date,\n"
//                + "	c.end_date,\n"
//                + "    co.course_id,\n"
//                + "    co.course_name,\n"
//                + "    co.course_description,\n"
//                + "    e.teacher_id,\n"
//                + "    (\n"
//                + "        SELECT user_name \n"
//                + "        FROM [User] \n"
//                + "        WHERE user_id = e.teacher_id\n"
//                + "    ) AS teacher_name,\n"
//                + "    (\n"
//                + "        SELECT COUNT(*) \n"
//                + "        FROM Enroll \n"
//                + "        WHERE class_id = c.class_id AND course_id = co.course_id\n"
//                + "    ) AS total_student\n"
//                + "FROM Class c\n"
//                + "JOIN Enroll e ON c.class_id = e.class_id\n"
//                + "JOIN Course co ON co.course_id = e.course_id\n"
//                + "JOIN [User] u ON u.user_id = e.student_id\n"
//                + "WHERE c.class_id = ? AND co.course_id = ?\n"
//                + "GROUP BY c.class_id,\n"
//                + "    c.class_name,\n"
//                + "	c.start_date,\n"
//                + "	c.end_date,\n"
//                + "    co.course_id,\n"
//                + "    co.course_name,\n"
//                + "    co.course_description,\n"
//                + "    e.teacher_id";
        String sql = "SELECT \n"
                + "    c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    u.user_id AS teacher_id,\n"
                + "	u.user_name AS teacher_name,\n"
                + "	u.email AS teacher_email,\n"
                + "    (\n"
                + "        SELECT COUNT(*) \n"
                + "        FROM Enroll \n"
                + "        WHERE class_id = c.class_id AND course_id = co.course_id\n"
                + "    ) AS total_student\n"
                + "FROM Class c\n"
                + "JOIN Enroll e ON c.class_id = e.class_id\n"
                + "JOIN Course co ON co.course_id = e.course_id\n"
                + "JOIN [User] u ON u.user_id = e.teacher_id\n"
                + "WHERE c.class_id = ? AND co.course_id = ?\n"
                + "GROUP BY c.class_id,\n"
                + "    c.class_name,\n"
                + "	c.start_date,\n"
                + "	c.end_date,\n"
                + "    co.course_id,\n"
                + "    co.course_name,\n"
                + "    co.course_description,\n"
                + "    u.user_id,\n"
                + "	u.user_name,\n"
                + "	u.email";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"), rs.getString("class_name"), rs.getDate("start_date"), rs.getDate("end_date"));
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                User u = new User(rs.getInt("teacher_id"), rs.getString("teacher_name"), rs.getString("teacher_email"));
                Enroll e = new Enroll(s, c, u, rs.getInt("total_student"));
                return e;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<User> getAllStudentPerCourse(int classId, int courseId) {
        ArrayList<User> sp = new ArrayList<>();
        String sql = "SELECT u.user_id, u.user_name, u.email, u.gender, u.roll_number\n"
                + "FROM [User] u \n"
                + "JOIN Enroll e\n"
                + "ON u.user_id = e.student_id\n"
                + "WHERE e.class_id = ? AND e.course_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("user_id"), rs.getString("user_name"), rs.getString("email"), rs.getBoolean("gender"), rs.getString("roll_number"));
                sp.add(u);
            }
            return sp;
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        EnrollDAO dao = new EnrollDAO();
//        ArrayList<Enroll> list = dao.getAllCourseByUser(1);
//
//        if (list.isEmpty()) {
//            System.out.println("Nothing");
//        } else {
//            for (Enroll enroll : list) {
//                System.out.println(enroll);
//            }
//
//        }

//        System.out.println("");
//        ArrayList<Enroll> listTea = dao.getAllCourseByTeacher(10);
//        for (Enroll enroll : listTea) {
//            System.out.println(enroll);
//        }
//        System.out.println("");
//        ArrayList<Enroll> listc = dao.getAllCourse();
//        for (Enroll enroll : listc) {
//            System.out.println(enroll);
//        }
//        System.out.println("");
//        System.out.println(dao.getAllClassAndCourseWorking());
//        Enroll e = dao.getCourseById(1, 2);
//        System.out.println(e.toString());
//        ArrayList<User> sp = dao.getAllStudentPerCourse(1, 2);
//        for (User user : sp) {
//            System.out.println(user);
//        }
        ArrayList<Enroll> list = dao.getAllClassByCourseId(2);
        for (Enroll enroll : list) {
            System.out.println(enroll.toString());
        }
    }
}
