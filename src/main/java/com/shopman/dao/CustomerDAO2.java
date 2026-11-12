package com.shopman.dao;

import com.shopman.model.Customer2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class CustomerDAO2 extends DAO2 {

    public CustomerDAO2() {
        super();
    }

    public boolean checkUserNameExists(String userName) {
        String sql = "SELECT id FROM tblUser2 WHERE userName = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerCustomer(Customer2 customer) {
        String sqlUser = "INSERT INTO tblUser2 (name, dateOfBirth, phone, email, userName, password) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlCustomer = "INSERT INTO tblCustomer2 (tblUserId) VALUES (?)";
        String sqlCart = "INSERT INTO tblCart2 (customerId) VALUES (?)";

        try {
            con.setAutoCommit(false);

            PreparedStatement psUser = con.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, customer.getName());
            psUser.setTimestamp(2, customer.getDateOfBirth() != null ? new Timestamp(customer.getDateOfBirth().getTime()) : null);
            psUser.setString(3, customer.getPhone());
            psUser.setString(4, customer.getEmail());
            psUser.setString(5, customer.getUserName());
            psUser.setString(6, customer.getPassword());
            psUser.executeUpdate();

            ResultSet rs = psUser.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt(1);
            }

            PreparedStatement psCustomer = con.prepareStatement(sqlCustomer);
            psCustomer.setInt(1, userId);
            psCustomer.executeUpdate();

            PreparedStatement psCart = con.prepareStatement(sqlCart);
            psCart.setInt(1, userId);
            psCart.executeUpdate();

            con.commit();
            con.setAutoCommit(true);
            return true;
        } catch (SQLException e) {
            try {
                con.rollback();
                con.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
        return false;
    }
}