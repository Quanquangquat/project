package model;

import java.util.Date;

public class Household {

    private int householdId;
    private Integer headOfHouseholdId; // Nullable
    private String address;
    private Date createdDate;
    private String headName; // Added to store the head's name
    private Integer areaId; // Nullable, references Areas table

    public Household() {
    }

    public Household(int householdId, Integer headOfHouseholdId, String address, Date createdDate) {
        this.householdId = householdId;
        this.headOfHouseholdId = headOfHouseholdId;
        this.address = address;
        this.createdDate = createdDate;
    }

    public Household(int householdId, Integer headOfHouseholdId, String address, Date createdDate, Integer areaId) {
        this.householdId = householdId;
        this.headOfHouseholdId = headOfHouseholdId;
        this.address = address;
        this.createdDate = createdDate;
        this.areaId = areaId;
    }

    public int getHouseholdId() {
        return householdId;
    }

    public void setHouseholdId(int householdId) {
        this.householdId = householdId;
    }

    public Integer getHeadOfHouseholdId() {
        return headOfHouseholdId;
    }

    public void setHeadOfHouseholdId(Integer headOfHouseholdId) {
        this.headOfHouseholdId = headOfHouseholdId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getHeadName() {
        return headName;
    }

    public void setHeadName(String headName) {
        this.headName = headName;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    @Override
    public String toString() {
        return "Households{"
                + "householdId=" + householdId
                + ", headOfHouseholdId=" + headOfHouseholdId
                + ", address='" + address + '\''
                + ", createdDate=" + createdDate
                + ", headName='" + headName + '\''
                + ", areaId=" + areaId
                + '}';
    }
}
