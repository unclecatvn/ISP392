/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author HoaiNam
 */
public class User {

    private int userId;
    private String userName;
    private String email;
    private boolean gender;
    private String password;
    private String phone;
    private boolean status;
    private int roleId;
    private String rollNumber;

    public User() {
    }

    public User(int userId, String userName, String email, boolean gender, String password, String phone, boolean status, int roleId, String rollNumber) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.gender = gender;
        this.password = password;
        this.phone = phone;
        this.status = status;
        this.roleId = roleId;
        this.rollNumber = rollNumber;
    }

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public User(int userId, String userName) {
        this.userId = userId;
        this.userName = userName;
    }

    public User(int userId, String userName, String email, boolean gender, String rollNumber) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.gender = gender;
        this.rollNumber = rollNumber;
    }

    public User(int userId, String userName, String email) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
    }
    
    
    
    

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isGender() {
        return gender;
    }

    public String getGender() {
        return gender ? "Male" : "Female";
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isStatus() {
        return status;
    }

    public String getStatus() {
        return status ? "Active" : "Deactive";
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRole(int roleId) {
        switch (roleId) {
            case 1:
                return "Admin";
            case 2:
                return "Teacher";
            case 3:
                return "Student";
            default:
                throw new AssertionError();
        }
    }

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", userName=" + userName + ", email=" + email + ", gender=" + gender + ", password=" + password + ", phone=" + phone + ", status=" + status + ", roleId=" + roleId + ", rollNumber=" + rollNumber + '}';
    }
    
    
}
