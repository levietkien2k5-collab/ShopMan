package com.shopman.dao;

import com.shopman.model.Item2;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO2 extends DAO2 {

    public ItemDAO2() {
        super();
    }

    public List<Item2> getItems() {
        return getItemsByName("");
    }

    public List<Item2> getItemsByName(String name) {
        List<Item2> list = new ArrayList<>();
        if (name == null) {
            name = "";
        }
        String sql = "SELECT * FROM tblItem2 WHERE name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name.trim() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item2 item = new Item2();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setType(rs.getString("type"));
                item.setDescription(rs.getString("description"));
                item.setUnit(rs.getString("unit"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSellingPrice(rs.getInt("sellingPrice"));
                try {
                    String img = rs.getString("image");
                    item.setImage((img != null && !img.trim().isEmpty()) ? img : "default_item.jpg");
                } catch (Exception e) {
                    item.setImage("default_item.jpg");
                }
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStockQuantity(int itemId, int addedQuantity) {
        String sql = "UPDATE tblItem2 SET quantity = quantity + ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, addedQuantity);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
