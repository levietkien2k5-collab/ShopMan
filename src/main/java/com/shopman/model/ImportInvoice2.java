package com.shopman.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ImportInvoice2 {
    private int id;
    private Date importDate;
    private int total;
    private Manager2 manager;
    private Supplier2 supplier;
    private List<ImportInvoiceDetail2> items;
    private Payment2 payment;

    public ImportInvoice2() {
        this.importDate = new Date();
        this.items = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public int getTotal() {
        int sum = 0;
        if (items != null) {
            for (ImportInvoiceDetail2 d : items) {
                sum += d.getAmount();
            }
        }
        this.total = sum;
        return this.total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public Manager2 getManager() {
        return manager;
    }

    public void setManager(Manager2 manager) {
        this.manager = manager;
    }

    public Supplier2 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier2 supplier) {
        this.supplier = supplier;
    }

    public List<ImportInvoiceDetail2> getItems() {
        return items;
    }

    public void setItems(List<ImportInvoiceDetail2> items) {
        this.items = items;
    }

    public Payment2 getPayment() {
        return payment;
    }

    public void setPayment(Payment2 payment) {
        this.payment = payment;
    }
}
