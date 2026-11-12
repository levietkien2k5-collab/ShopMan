package com.shopman.model;

import java.util.Date;

public class Customer2 extends User2 {
    public Customer2() { super(); }

    public Customer2(int id, String userName, String password, String name, Date dateOfBirth, String phone, String email) {
        super(id, userName, password, name, dateOfBirth, phone, email);
    }
}