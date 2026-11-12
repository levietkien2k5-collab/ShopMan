package com.shopman.dao;

import com.shopman.model.Payment2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class PaymentDAO2 extends DAO2 {

    public PaymentDAO2() {
        super();
    }

    public boolean processPayment(Payment2 payment) {
        String sql = "INSERT INTO tblPayment2(paymentDate, amount, paymentMethod, status) VALUES(?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, new Timestamp(payment.getPaymentDate().getTime()));
            ps.setInt(2, payment.getAmount());
            ps.setString(3, payment.getPaymentMethod());
            ps.setString(4, payment.getStatus());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    payment.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
