package com.shopman.dao;

import com.shopman.model.User2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO2 extends DAO2 {

    public UserDAO2() {
        super();
    }

    // Kiểm tra thông tin đăng nhập trong CSDL
    public User2 checkLogin(String userName, String password) {
        String sql = "SELECT * FROM tblUser2 WHERE userName = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User2 user = new User2();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setDateOfBirth(rs.getTimestamp("dateOfBirth"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setUserName(userName);
                user.setPassword(password);
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy vai trò người dùng (Manager / Seller / Customer)
    public String getUserRole(int userId) {
        String sql = "SELECT role FROM tblStaff2 WHERE tblUserId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role"); // Trả về "Manager" hoặc "Seller"
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Customer"; // Mặc định là Customer nếu không có trong tblStaff2
    }
}