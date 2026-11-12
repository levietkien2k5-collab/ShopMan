package com.shopman.model;

import java.io.Serializable;
import java.util.Date;

public class User2 implements Serializable {
    private int id;
    private String userName;
    private String password;
    private String name;
    private Date dateOfBirth;
    private String phone;
    private String email;

    public User2() {}

    public User2(int id, String userName, String password, String name, Date dateOfBirth, String phone, String email) {
        this.id = id;
        this.userName = userName;
        this.password = password;
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.phone = phone;
        this.email = email;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}