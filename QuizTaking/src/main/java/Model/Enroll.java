/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Enroll {
    private Classes classes;
    private Course course;
    private User teacher;
    private User student;
    private int totalStudent;

    public Enroll(Classes classes, Course course, User teacher, int totalStudent) {
        this.classes = classes;
        this.course = course;
        this.teacher = teacher;
        this.totalStudent = totalStudent;
    }
    
    

    public Classes getClasses() {
        return classes;
    }

    public void setClasses(Classes classes) {
        this.classes = classes;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public User getTeacher() {
        return teacher;
    }

    public void setTeacher(User teacher) {
        this.teacher = teacher;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public int getTotalStudent() {
        return totalStudent;
    }

    public void setTotalStudent(int totalStudent) {
        this.totalStudent = totalStudent;
    }

    @Override
    public String toString() {
        return "Enroll{" + "classes=" + classes + ", course=" + course + ", teacher=" + teacher + ", totalStudent=" + totalStudent + '}';
    }
    
    
    
    
    
    
    
}
