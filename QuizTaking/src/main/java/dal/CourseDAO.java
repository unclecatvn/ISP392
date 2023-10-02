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
    
    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();
        ArrayList<Course> list = new ArrayList<>();
        list = dao.getAllCourse();
        for (Course course : list) {
            System.out.println(course.toString());
        }
    }
}
