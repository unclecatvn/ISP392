/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Question {
    private int questionId;
    private String name;
    private boolean type;
    private int correctAnswer;
    private Quiz quizz;

    public Question(int questionId, String name, boolean type, int correctAnswer,Quiz quizz) {
        this.questionId = questionId;
        this.name = name;
        this.type = type;
        this.quizz = quizz;
        this.correctAnswer = correctAnswer;
    }

    public Question(int questionId) {
        this.questionId = questionId;
    }
    
    

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isType() {
        return type;
    }

    public void setType(boolean type) {
        this.type = type;
    }

    public int getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(int correctAnswer) {
        this.correctAnswer = correctAnswer;
    }
    
    
    public Quiz getQuizz() {
        return quizz;
    }

    public void setQuizz(Quiz quizz) {
        this.quizz = quizz;
    }

//    @Override
//    public String toString() {
//        return "Question{" + "questionId=" + questionId + ", name=" + name + ", type=" + type + ", quizz=" + quizz + '}';
//    }

    @Override
    public String toString() {
        return "Question{" + "questionId=" + questionId + ", name=" + name + ", type=" + type + ", correctAnswer=" + correctAnswer + ", quizz=" + quizz + '}';
    }
    
    
    
    
}
