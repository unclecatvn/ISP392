/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Quiz {
    private int quizId;
    private String title;
    private String description;
    private Timestamp startDate;
    private Timestamp endDate;
    private int attemptTime;
    private int duration;
    private boolean status;
    private int totalQuestion;
    private Course course;
    private Classes classes;

    public Quiz(int quizId, String title, String description, Timestamp startDate, Timestamp endDate, int attemptTime, int duration, boolean status, int totalQuestion, Course course, Classes classes) {
        this.quizId = quizId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.attemptTime = attemptTime;
        this.duration = duration;
        this.status = status;
        this.totalQuestion = totalQuestion;
        this.course = course;
        this.classes = classes;
    }

    public Quiz(int quizId) {
        this.quizId = quizId;
    }

    

    

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public int getAttemptTime() {
        return attemptTime;
    }

    public void setAttempTime(int attemptTime) {
        this.attemptTime = attemptTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getTotalQuestion() {
        return totalQuestion;
    }

    public void setTotalQuestion(int totalQuestion) {
        this.totalQuestion = totalQuestion;
    }
    
    
    
   

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Classes getClasses() {
        return classes;
    }

    public void setClasses(Classes classes) {
        this.classes = classes;
    }

    @Override
    public String toString() {
        return "Quiz{" + "quizId=" + quizId + ", title=" + title + ", description=" + description + ", startDate=" + startDate + ", endDate=" + endDate + ", attemptTime=" + attemptTime + ", duration=" + duration + ", status=" + status + ", totalQuestion=" + totalQuestion + ", course=" + course + ", classes=" + classes + '}';
    }

    

    

    
    
    
}
