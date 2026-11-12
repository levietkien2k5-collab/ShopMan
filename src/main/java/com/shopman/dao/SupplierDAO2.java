package com.shopman.dao;

import com.shopman.model.Item2;
import com.shopman.model.Supplier2;
import com.shopman.model.SupplierItem2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO2 extends DAO2 {

    public SupplierDAO2() {
        super();
    }

    public List<Supplier2> getSuppliers() {
        List<Supplier2> list = new ArrayList<>();
        String sql = "SELECT * FROM tblSupplier2";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier2 s = new Supplier2();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setAddress(rs.getString("address"));
                s.setPhone(rs.getString("phone"));
                s.setEmail(rs.getString("email"));
                s.setDescription(rs.getString("description"));
                s.setItems(getSupplierItems(s.getId()));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Supplier2 getSupplierById(int id) {
        String sql = "SELECT * FROM tblSupplier2 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Supplier2 s = new Supplier2();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setAddress(rs.getString("address"));
                s.setPhone(rs.getString("phone"));
                s.setEmail(rs.getString("email"));
                s.setDescription(rs.getString("description"));
                s.setItems(getSupplierItems(s.getId()));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<SupplierItem2> getSupplierItems(int supplierId) {
        List<SupplierItem2> list = new ArrayList<>();
        String sql = "SELECT si.id AS siId, si.importPrice, si.minImportQuantity, " +
                     "i.id AS itemId, i.name, i.type, i.description, i.unit, i.quantity, i.sellingPrice, i.image " +
                     "FROM tblSupplierItem2 si " +
                     "JOIN tblItem2 i ON si.itemId = i.id " +
                     "WHERE si.supplierId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item2 item = new Item2();
                item.setId(rs.getInt("itemId"));
                item.setName(rs.getString("name"));
                item.setType(rs.getString("type"));
                item.setDescription(rs.getString("description"));
                item.setUnit(rs.getString("unit"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSellingPrice(rs.getInt("sellingPrice"));
                String img = rs.getString("image");
                item.setImage((img != null && !img.trim().isEmpty()) ? img : "default_item.jpg");

                SupplierItem2 si = new SupplierItem2();
                si.setId(rs.getInt("siId"));
                si.setImportPrice(rs.getInt("importPrice"));
                si.setMinImportQuantity(rs.getInt("minImportQuantity"));
                si.setItem(item);
                list.add(si);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addSupplier(Supplier2 s) {
        String sql = "INSERT INTO tblSupplier2(name, address, phone, email, description) VALUES(?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, s.getName());
            ps.setString(2, s.getAddress());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addSupplierItem(int supplierId, int itemId, int importPrice, int minImportQuantity) {
        String sql = "INSERT INTO tblSupplierItem2(importPrice, minImportQuantity, supplierId, itemId) VALUES(?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, importPrice);
            ps.setInt(2, minImportQuantity);
            ps.setInt(3, supplierId);
            ps.setInt(4, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
