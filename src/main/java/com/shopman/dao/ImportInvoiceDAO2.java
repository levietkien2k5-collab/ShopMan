package com.shopman.dao;

import com.shopman.model.ImportInvoice2;
import com.shopman.model.ImportInvoiceDetail2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class ImportInvoiceDAO2 extends DAO2 {

    public ImportInvoiceDAO2() {
        super();
    }

    public boolean saveImportInvoice(ImportInvoice2 invoice) {
        String sqlInvoice = "INSERT INTO tblImportInvoice2(importDate, managerId, supplierId, paymentId) VALUES(?, ?, ?, ?)";
        String sqlDetail  = "INSERT INTO tblImportInvoiceDetail2(importQuantity, importInvoiceId, itemId) VALUES(?, ?, ?)";

        try {
            con.setAutoCommit(false);

            PreparedStatement psInv = con.prepareStatement(sqlInvoice, Statement.RETURN_GENERATED_KEYS);
            psInv.setTimestamp(1, new Timestamp(invoice.getImportDate().getTime()));
            psInv.setInt(2, invoice.getManager().getId());
            psInv.setInt(3, invoice.getSupplier().getId());
            if (invoice.getPayment() != null && invoice.getPayment().getId() > 0) {
                psInv.setInt(4, invoice.getPayment().getId());
            } else {
                psInv.setNull(4, java.sql.Types.INTEGER);
            }
            psInv.executeUpdate();

            ResultSet rsKey = psInv.getGeneratedKeys();
            int invoiceId = 0;
            if (rsKey.next()) {
                invoiceId = rsKey.getInt(1);
                invoice.setId(invoiceId);
            }

            PreparedStatement psDetail = con.prepareStatement(sqlDetail);
            for (ImportInvoiceDetail2 detail : invoice.getItems()) {
                psDetail.setInt(1, detail.getImportQuantity());
                psDetail.setInt(2, invoiceId);
                psDetail.setInt(3, detail.getItem().getId());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            con.commit();
            return true;
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
