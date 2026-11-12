package com.shopman.model;

import java.io.Serializable;
import java.util.List;

public class Cart2 implements Serializable {
    private int id;
    private int total;
    private Customer2 customer;
    private List<CartDetail2> items;

    public Cart2() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public Customer2 getCustomer() { return customer; }
    public void setCustomer(Customer2 customer) { this.customer = customer; }

    public List<CartDetail2> getItems() { return items; }
    public void setItems(List<CartDetail2> items) { this.items = items; }
}