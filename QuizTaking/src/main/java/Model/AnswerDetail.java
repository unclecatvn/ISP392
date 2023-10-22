/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class AnswerDetail {
    private int id;
    private AttemptQuiz attemptQuiz;
    private Quiz quiz;
    private Question question;
    private Answer answer;

    public AnswerDetail(int id, AttemptQuiz attemptQuiz, Quiz quiz, Question question, Answer answer) {
        this.id = id;
        this.attemptQuiz = attemptQuiz;
        this.quiz = quiz;
        this.question = question;
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public AttemptQuiz getAttemptQuiz() {
        return attemptQuiz;
    }

    public void setAttemptQuiz(AttemptQuiz attemptQuiz) {
        this.attemptQuiz = attemptQuiz;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }

    @Override
    public String toString() {
        return "AnswerDetail{" + "id=" + id + ", attemptQuiz=" + attemptQuiz + ", quiz=" + quiz + ", question=" + question + ", answer=" + answer + '}';
    }


    
   
    
}
