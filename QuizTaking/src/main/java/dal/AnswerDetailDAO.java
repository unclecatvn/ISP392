/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;

/**
 *
 * @author ADMIN
 */
public class AnswerDetailDAO {

    public void insertAnswerDetail(int attemptId, int quizId, int questionId, int answerId) {
        String sql = "INSERT INTO [dbo].[AnswerDetail]\n"
                + "           ([attempt_id]\n"
                + "           ,[quiz_id]\n"
                + "           ,[question_id]\n"
                + "           ,[answer_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            stm.setInt(1, attemptId);
            stm.setInt(2, quizId);
            stm.setInt(3, questionId);
            stm.setInt(4, answerId);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }
}
