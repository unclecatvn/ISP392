/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Classes;
import Model.Course;
import Model.Quiz;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class QuizDAO {

    public void insertQuiz(String title, String description, String startDate,
            String endDate, int attemptTime, int duration, int status, int classId, int courseId) {
        String sql = "INSERT INTO [dbo].[Quiz]\n"
                + "           ([title]\n"
                + "           ,[description]\n"
                + "           ,[start_date]\n"
                + "           ,[end_date]\n"
                + "           ,[attempt_time]\n"
                + "           ,[duration]\n"
                + "           ,[status]\n"
                + "           ,[class_id]\n"
                + "           ,[course_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, description);
            startDate = startDate.replace("T", " ");
            endDate = endDate.replace("T", " ");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date parsedStartDate = dateFormat.parse(startDate);
            Date parsedEndDate = dateFormat.parse(endDate);

            stm.setTimestamp(3, new Timestamp(parsedStartDate.getTime()));
            stm.setTimestamp(4, new Timestamp(parsedEndDate.getTime()));
            stm.setInt(5, attemptTime);
            stm.setInt(6, duration);
            stm.setInt(7, status);
            stm.setInt(8, classId);
            stm.setInt(9, courseId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<Quiz> getAllQuiz(int classId, int courseId) {
        ArrayList<Quiz> list = new ArrayList<>();
        String sql = "SELECT * FROM Quiz\n"
                + "WHERE class_id = ? AND course_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"));
                Course c = new Course(rs.getInt("course_id"));
                Quiz q = new Quiz(rs.getInt("quiz_id"), rs.getString("title"),
                        rs.getString("description"), rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date"), rs.getInt("attempt_time"), rs.getInt("duration"), rs.getBoolean("status"), rs.getInt("total_question"), c, s);
                list.add(q);
            }

        } catch (Exception e) {
        }
        return list;
    }

    public Quiz getQuizById(int classId, int courseId, int quizId) {
        String sql = "SELECT * FROM Quiz\n"
                + "WHERE class_id = ? AND course_id = ? AND quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            stm.setInt(3, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Classes s = new Classes(rs.getInt("class_id"));
                Course c = new Course(rs.getInt("course_id"));
                Quiz q = new Quiz(rs.getInt("quiz_id"), rs.getString("title"),
                        rs.getString("description"), rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date"), rs.getInt("attempt_time"), rs.getInt("duration"), rs.getBoolean("status"), rs.getInt("total_question"), c, s);
                return q;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateQuiz(int quizId, String title, String description, String startDate,
            String endDate, int attemptTime, int duration, int status) {
        String sql = "UPDATE [dbo].[Quiz]\n"
                + "   SET [title] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[start_date] = ?\n"
                + "      ,[end_date] = ?\n"
                + "      ,[attempt_time] = ?\n"
                + "      ,[duration] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, description);
            startDate = startDate.replace("T", " ");
            endDate = endDate.replace("T", " ");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date parsedStartDate = dateFormat.parse(startDate);
            Date parsedEndDate = dateFormat.parse(endDate);

            stm.setTimestamp(3, new Timestamp(parsedStartDate.getTime()));
            stm.setTimestamp(4, new Timestamp(parsedEndDate.getTime()));
            stm.setInt(5, attemptTime);
            stm.setInt(6, duration);
            stm.setInt(7, status);
            stm.setInt(8, quizId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Quiz deleteQuizByID(int classId, int courseId, int quizId) {
        String sql = "delete from Quiz\n"
                + "where class_id = ? AND course_id = ? AND quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, courseId);
            stm.setInt(3, quizId);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        QuizDAO dao = new QuizDAO();
//        dao.insertQuiz("Test", "hehe", "2023-09-09T09:50", "2023-09-09T09:50", 1, 70, 1, 1, 1);
//        ArrayList<Quiz> list = dao.getAllQuiz(1, 1);
//        for (Quiz quiz : list) {
//            System.out.println(quiz.toString());
//        }
//        Quiz q = dao.getQuizById(1, 1, 19);
//        System.out.println(q.toString());

        System.out.println(dao.deleteQuizByID(1, 1, 38));
    }
}
