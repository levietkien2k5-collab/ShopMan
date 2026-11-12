package com.shopman.model;

import java.util.Date;

public class Staff2 extends User2 {
    private String role;

    public Staff2() {
        super();
    }

    public Staff2(int id, String userName, String password, String name, Date dateOfBirth, String phone, String email, String role) {
        super();
        this.setId(id);
        this.setUserName(userName);
        this.setPassword(password);
        this.setName(name);
        this.setDateOfBirth(dateOfBirth);
        this.setPhone(phone);
        this.setEmail(email);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}