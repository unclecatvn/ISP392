/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Question;
import Model.Quiz;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class QuestionDAO {

    public ArrayList<Question> getAllQuestionByQuizId(int quizId) {
        ArrayList<Question> list = new ArrayList<>();
        String sql = "SELECT e.* FROM Quiz z\n"
                + "JOIN Question e\n"
                + "ON z.quiz_id = e.quiz_id\n"
                + "WHERE e.quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Quiz q = new Quiz(rs.getInt("quiz_id"));
                Question e = new Question(rs.getInt("question_id"), rs.getString("name"), rs.getBoolean("type"), rs.getInt("correct_answer"),q);
                list.add(e);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void updateTotalQuestion(int quizId, String a) {
        String sql = "";
        if(a.equals("+")){
            sql += "UPDATE [dbo].[Quiz]\n"
                + "   SET [total_question] = (SELECT total_question FROM Quiz WHERE quiz_id = ?) + 1  \n"
                + " WHERE quiz_id = ?";
        } else if (a.equals("-")){
            sql += "UPDATE [dbo].[Quiz]\n"
                + "   SET [total_question] = (SELECT total_question FROM Quiz WHERE quiz_id = ?) - 1  \n"
                + " WHERE quiz_id = ?";
        }
        
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, quizId);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertQuestion(String name, String type, int quizId, int correctAnswer) {
        String sql = "INSERT INTO [dbo].[Question]\n"
                + "           ([name]\n"
                + "           ,[type]\n"
                + "           ,[quiz_id]\n"
                + "           ,[correct_answer])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, type);
            stm.setInt(3, quizId);
            stm.setInt(4, correctAnswer);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Question getLastQuestionId(int quizId) {
        String sql = "SELECT TOP 1 *\n"
                + "FROM Question\n"
                + "WHERE quiz_id = ?\n"
                + "ORDER BY question_id DESC";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Question q = new Question(rs.getInt("question_id"));
                return q;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void deleteQuestionByQuestionId(int questionId) {
        String sql = "DELETE FROM [dbo].[Question]\n"
                + "      WHERE question_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, questionId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }
    public void deleteQuestionByQuizId(int quizId) {
        String sql = "DELETE FROM [dbo].[Question]\n"
                + "      WHERE quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    

    public static void main(String[] args) {
        QuestionDAO dao = new QuestionDAO();
        ArrayList<Question> list = dao.getAllQuestionByQuizId(42);
        for (Question question : list) {
            System.out.println(question.toString());
        }
        dao.insertQuestion("10+10=?", "0", 43, 0);
//        Question q = dao.getLastQuestionId(19);
//        System.out.println(q.toString());
//        dao.deleteQuestionByQuestionId(50);
    }
}
