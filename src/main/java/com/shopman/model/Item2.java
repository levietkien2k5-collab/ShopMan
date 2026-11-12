package com.shopman.model;

import java.io.Serializable;

public class Item2 implements Serializable {
    private int id;
    private String name;
    private String type;
    private String description;
    private String unit;
    private int quantity;
    private int sellingPrice;
    private String image;

    public Item2() {}

    public Item2(int id, String name, String type, String description, String unit, int quantity, int sellingPrice) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.description = description;
        this.unit = unit;
        this.quantity = quantity;
        this.sellingPrice = sellingPrice;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getSellingPrice() { return sellingPrice; }
    public void setSellingPrice(int sellingPrice) { this.sellingPrice = sellingPrice; }
    
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}