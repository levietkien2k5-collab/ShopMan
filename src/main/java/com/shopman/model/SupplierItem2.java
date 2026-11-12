package com.shopman.model;

public class SupplierItem2 {
    private int id;
    private int importPrice;
    private int minImportQuantity;
    private Item2 item;

    public SupplierItem2() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(int importPrice) {
        this.importPrice = importPrice;
    }

    public int getMinImportQuantity() {
        return minImportQuantity;
    }

    public void setMinImportQuantity(int minImportQuantity) {
        this.minImportQuantity = minImportQuantity;
    }

    public Item2 getItem() {
        return item;
    }

    public void setItem(Item2 item) {
        this.item = item;
    }
}
