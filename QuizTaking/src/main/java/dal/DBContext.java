/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
        Class.forName("com.mysql.cj.jdbc.Driver"); // Sử dụng driver MySQL

        // Thay thế thông tin kết nối của bạn tại đây
        return DriverManager.getConnection(url, userID, password);
    }

    private final String serverName = "103.200.23.120";
    private final String dbName = "nguyenn_isp392";
    private final String portNumber = "3306"; // Port mặc định của MySQL
    private final String userID = "nguyenn_isp392"; // Tên người dùng của bạn
    private final String password = "Hoainam1402"; // Mật khẩu của bạn
}

class Using {

    public static void main(String[] args) {
        try {
            new DBContext().getConnection();
            System.out.println("OK");
        } catch (Exception e) {
            System.out.println("Failed " + e.getMessage());
        }
    }
}