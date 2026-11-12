package com.shopman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO2 {
    protected static Connection con;

    public DAO2() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/shopman?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh&useUnicode=true&characterEncoding=UTF-8";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            
            String username = "root";
            String password = "123456789"; // <--- Thay password MySQL của bạn vào đây

            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, username, password);
                System.out.println("Kết nối CSDL shopman thành công!");
            } catch (ClassNotFoundException e) {
                System.err.println("Chưa thêm thư viện MySQL JDBC Driver!");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Lỗi kết nối CSDL shopman! Kiểm tra lại username/password hoặc port MySQL.");
                e.printStackTrace();
            }
        }
    }
}