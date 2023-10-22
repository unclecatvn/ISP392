/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class AttemptQuiz {
    private int attemptId;
    private Enroll enroll;
    private Quiz quiz;
    private int finishTime;
    private float score;

    public AttemptQuiz(int attemptId, Enroll enroll, Quiz quiz, int finishTime, float score) {
        this.attemptId = attemptId;
        this.enroll = enroll;
        this.quiz = quiz;
        this.finishTime = finishTime;
        this.score = score;

    }

    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public Enroll getEnroll() {
        return enroll;
    }

    public void setEnroll(Enroll enroll) {
        this.enroll = enroll;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(int finishTime) {
        this.finishTime = finishTime;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "AttemptQuiz{" + "attemptId=" + attemptId + ", enroll=" + enroll + ", quiz=" + quiz + ", finishTime=" + finishTime + ", score=" + score + '}';
    }



    
        
}
