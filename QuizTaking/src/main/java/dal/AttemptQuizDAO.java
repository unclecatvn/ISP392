/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.AttemptQuiz;
import Model.Enroll;
import Model.Quiz;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class AttemptQuizDAO {

    public int getAttemptTime(int enrollId, int quizId) {
        String sql = "SELECT COUNT(a.attempt_id) AS attempt \n"
                + "FROM Attempt_Quiz a\n"
                + "WHERE a.enroll_id = ? AND a.quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, enrollId);
            stm.setInt(2, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("attempt");
            }
        } catch (Exception e) {
        }
        return -1;
    }

    public void insertAttemptQuiz(int enrollId, int quizId) {
        String sql = "INSERT INTO [dbo].[Attempt_Quiz]\n"
                + "           ([enroll_id]\n"
                + "           ,[quiz_id]\n"
                + "           ,[finish_time]\n"
                + "           ,[score])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,0\n"
                + "           ,0)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, enrollId);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public AttemptQuiz getLastAttempt(int enrollId, int quizId) {
        String sql = "SELECT TOP 1 * FROM Attempt_Quiz\n"
                + "WHERE enroll_id = ? AND quiz_id = ?\n"
                + "ORDER BY attempt_id DESC";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, enrollId);
            stm.setInt(2, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Enroll e = new Enroll(rs.getInt("enroll_id"));
                Quiz q = new Quiz(rs.getInt("quiz_id"));
                AttemptQuiz a = new AttemptQuiz(rs.getInt("attempt_id"), e, q, rs.getInt("finish_time"), rs.getFloat("score"));
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public ArrayList<AttemptQuiz> getAllAttempt(int enrollId, int quizId) {
        ArrayList<AttemptQuiz> list = new ArrayList<>();
        String sql = "SELECT * FROM Attempt_Quiz\n"
                + "WHERE enroll_id = ? AND quiz_id = ?";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, enrollId);
            stm.setInt(2, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                Enroll e = new Enroll(rs.getInt("enroll_id"));
                Quiz q = new Quiz(rs.getInt("quiz_id"));
                AttemptQuiz a = new AttemptQuiz(rs.getInt("attempt_id"), e, q, rs.getInt("finish_time"), rs.getFloat("score"));
                list.add(a);
            }
            
        } catch (Exception e) {
        }
        return list;
    }

    
    

    public static void main(String[] args) {
        AttemptQuizDAO dao = new AttemptQuizDAO();
//        dao.insertAttemptQuiz(1, 43);
//        System.out.println(dao.getAttemptTime(1, 43));
//        System.out.println(dao.getAttemptTime(1, 43));
        AttemptQuiz a = dao.getLastAttempt(1, 45);
        System.out.println(a.toString());
    }

}
