/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Answer;
import Model.Question;
import Model.Quiz;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class AnswerDAO {

    public ArrayList<Answer> getAllAnswerByQuizId(int quizId) {
        ArrayList<Answer> list = new ArrayList<>();
        String sql = "SELECT a.* FROM Question q\n"
                + "JOIN Answer a\n"
                + "ON a.question_id = q.question_id\n"
                + "WHERE q.quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                Question e = new Question(rs.getInt("question_id"));
                Answer a = new Answer(rs.getInt("answer_id"), rs.getString("answer"), rs.getBoolean("answer_check"), rs.getString("explain"), e);
                list.add(a);
            }
        } catch (Exception e) {
        }
        return list;
    }

//    public String getExplain(int quizId, int questionId) {
//        String explain = null;
//        String sql = "SELECT a.explain FROM Question q "
//                + "JOIN Answer a ON a.question_id = q.question_id "
//                + "WHERE q.quiz_id = ? AND q.question_id = ? AND a.answer_check = 1 "
//                + "GROUP BY a.explain";
//        try {
//            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
//            stm.setInt(1, quizId);
//            stm.setInt(2, questionId);
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                explain = rs.getString(1);
//            }
//        } catch (Exception e) {
//        }
//        return explain;
//    }

    public void insertAnswer(String answer, String answerCheck, String explain, int questionId) {
        try {
            String sql = "INSERT INTO [dbo].[Answer] ([answer], [answer_check], [question_id], [explain]) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);

            // Set values for parameters
            stm.setString(1, answer);
            stm.setString(2, answerCheck);
            stm.setInt(3, questionId);
            stm.setString(4, answerCheck.equals("True") ? explain : null);

            stm.executeUpdate();
        } catch (Exception e) {
            // Handle the exception appropriately, e.g., log it or throw a custom exception
            e.printStackTrace();
        }
    }

    public void deleteAllAnswerByQuestionId(int questionId) {
        String sql = "DELETE FROM [dbo].[Answer]\n"
                + "      WHERE question_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, questionId);
            stm.executeUpdate();

        } catch (Exception e) {
        }
    }

    public int getTotalAnswerByQuesId(int questionId) {
        String sql = "SELECT COUNT(*) AS total_answer FROM Answer\n"
                + "WHERE question_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, questionId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int total = rs.getInt("total_answer");
                return total;
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public static void main(String[] args) {
        AnswerDAO dao = new AnswerDAO();
//        dao.insertAnswer("100", "True", "Boi vi no the", 33);
//        dao.insertAnswer("200", "False", "Boi vi no the", 33);
//        dao.deleteAllAnswerByQuestionId(60);
        int total = dao.getTotalAnswerByQuesId(88);
        System.out.println(total);
    }
}
