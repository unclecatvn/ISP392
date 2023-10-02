/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ADMIN
 */
public class ClassesDAO {
    public int countClass() {
        String sql = "SELECT COUNT(*) FROM Class";
        try {
            PreparedStatement stm = new DBContext().getConnection().prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    
}
