/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class CourseDAO {

    public ArrayList<Course> getAllCourse() {
        ArrayList<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM Course";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int countCourse() {
        String sql = "SELECT COUNT(*) FROM Course";
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

    public Course getCourseByCourseId(int courseId) {
        String sql = "SELECT * FROM Course\n"
                + "WHERE course_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course(rs.getInt("course_id"), rs.getString("course_name"), rs.getString("course_description"));
                return course;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void editCourseById(int courseId, String courseName, String courseDescription) {
        String sql = "UPDATE [dbo].[Course]\n"
                + "   SET [course_name] = ?\n"
                + "      ,[course_description] = ?\n"
                + " WHERE course_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(3, courseId);
            stm.setString(1, courseName);
            stm.setString(2, courseDescription);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<Course> getCourseTaken() {
        ArrayList<Course> list = new ArrayList<>();
        String sql = "SELECT e.course_id \n"
                + "FROM Enroll e\n"
                + "GROUP BY e.course_id";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getInt("course_id"));
                list.add(c);
            }

        } catch (Exception e) {
        }
        return list;
    }

    public void deleteCourseById(int courseId) {
        String sql = "DELETE\n"
                + "FROM Course\n"
                + "WHERE course_id= ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertCourse(String courseName, String courseDescription) {
        String sql = "INSERT INTO [dbo].[Course]\n"
                + "           ([course_name]\n"
                + "           ,[course_description])\n"
                + "     VALUES\n"
                + "           (?,?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, courseName);
            stm.setString(2, courseDescription);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();
//        ArrayList<Course> list = new ArrayList<>();
//        list = dao.getAllCourse();
//        for (Course course : list) {
//            System.out.println(course.toString());
//        }
//        Course l = dao.getCourseByCourseId(2);
//        System.out.println(l.toString());
//        dao.editCourseById(7, "DBIIII", "Dataaaaaa");
//        ArrayList<Course> list = dao.getCourseTaken();
//        for (Course course : list) {
//            System.out.println(course.toString());
//        }
        dao.insertCourse("TRANS601", "Englishlv6");
    }
}
