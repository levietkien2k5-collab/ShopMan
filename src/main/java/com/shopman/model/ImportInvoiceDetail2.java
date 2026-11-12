package com.shopman.model;

public class ImportInvoiceDetail2 {
    private int id;
    private int importQuantity;
    private int amount;
    private Item2 item;

    public ImportInvoiceDetail2() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getImportQuantity() {
        return importQuantity;
    }

    public void setImportQuantity(int importQuantity) {
        this.importQuantity = importQuantity;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Item2 getItem() {
        return item;
    }

    public void setItem(Item2 item) {
        this.item = item;
    }
}
