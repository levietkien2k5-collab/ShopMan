package com.shopman.model;

import java.io.Serializable;

public class Address2 implements Serializable {
    private int id;
    private String houseNumber;
    private String building;
    private String street;
    private String ward;
    private String district;
    private String city;

    public Address2() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getHouseNumber() { return houseNumber; }
    public void setHouseNumber(String houseNumber) { this.houseNumber = houseNumber; }

    public String getBuilding() { return building; }
    public void setBuilding(String building) { this.building = building; }

    public String getStreet() { return street; }
    public void setStreet(String street) { this.street = street; }

    public String getWard() { return ward; }
    public void setWard(String ward) { this.ward = ward; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
}