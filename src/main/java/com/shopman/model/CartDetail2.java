package com.shopman.model;

import java.io.Serializable;

public class CartDetail2 implements Serializable {
    private int id;
    private int orderQuantity;
    private int amount;
    private Item2 item;

    public CartDetail2() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderQuantity() { return orderQuantity; }
    public void setOrderQuantity(int orderQuantity) { this.orderQuantity = orderQuantity; }

    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }

    public Item2 getItem() { return item; }
    public void setItem(Item2 item) { this.item = item; }
}