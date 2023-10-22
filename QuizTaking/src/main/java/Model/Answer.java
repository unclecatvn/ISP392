/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Answer {
    private int answerId;
    private String answer;
    private boolean answerCheck;
    private String explain;
    private Question question;

    public Answer(int answerId, String answer, boolean answerCheck, String explain, Question question) {
        this.answerId = answerId;
        this.answer = answer;
        this.answerCheck = answerCheck;
        this.explain = explain;
        this.question = question;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public boolean isAnswerCheck() {
        return answerCheck;
    }

    public void setAnswerCheck(boolean answerCheck) {
        this.answerCheck = answerCheck;
    }

    public String getExplain() {
        return explain;
    }

    public void setExplain(String explain) {
        this.explain = explain;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    @Override
    public String toString() {
        return "Answer{" + "answerId=" + answerId + ", answer=" + answer + ", answerCheck=" + answerCheck + ", explain=" + explain + ", question=" + question + '}';
    }
    
    
}
