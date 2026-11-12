package com.shopman.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order2 implements Serializable {
    private int id;
    private Date orderDate;
    private int total;
    private String status;
    private String address;
    private Seller2 seller;
    private Customer2 customer;
    private Payment2 payment;
    private List<OrderDetail2> items;
    private DeliveryAgent2 deliveryAgent;

    public Order2() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Seller2 getSeller() { return seller; }
    public void setSeller(Seller2 seller) { this.seller = seller; }

    public Customer2 getCustomer() { return customer; }
    public void setCustomer(Customer2 customer) { this.customer = customer; }

    public Payment2 getPayment() { return payment; }
    public void setPayment(Payment2 payment) { this.payment = payment; }

    public List<OrderDetail2> getItems() { return items; }
    public void setItems(List<OrderDetail2> items) { this.items = items; }

    public DeliveryAgent2 getDeliveryAgent() { return deliveryAgent; }
    public void setDeliveryAgent(DeliveryAgent2 deliveryAgent) { this.deliveryAgent = deliveryAgent; }
}