package model;

import java.util.Date;
import java.util.List;

public class SplitRegistration {
    private int splitRegistrationId;
    private int registrationId;
    private String reasonForSplit;
    private String newAddress;
    private String previousAddress;
    private Date moveDate;
    private int headOfHousehold; // MemberID of the person who will be head of the new household
    
    // Additional fields for form handling
    
    
    public SplitRegistration() {
    }

    public SplitRegistration(int splitRegistrationId, int registrationId, String reasonForSplit, String newAddress, String previousAddress, Date moveDate, int headOfHousehold) {
        this.splitRegistrationId = splitRegistrationId;
        this.registrationId = registrationId;
        this.reasonForSplit = reasonForSplit;
        this.newAddress = newAddress;
        this.previousAddress = previousAddress;
        this.moveDate = moveDate;
        this.headOfHousehold = headOfHousehold;
    }

    public int getSplitRegistrationId() {
        return splitRegistrationId;
    }

    public void setSplitRegistrationId(int splitRegistrationId) {
        this.splitRegistrationId = splitRegistrationId;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public String getReasonForSplit() {
        return reasonForSplit;
    }

    public void setReasonForSplit(String reasonForSplit) {
        this.reasonForSplit = reasonForSplit;
    }   

    public String getNewAddress() {
        return newAddress;
    }

    public void setNewAddress(String newAddress) {
        this.newAddress = newAddress;
    }

    public String getPreviousAddress() {
        return previousAddress;
    }

    public void setPreviousAddress(String previousAddress) {
        this.previousAddress = previousAddress;
    }


    public Date getMoveDate() {
        return moveDate;
    }

    public void setMoveDate(Date moveDate) {
        this.moveDate = moveDate;
    }

    public int getHeadOfHousehold() {
        return headOfHousehold;
    }

    public void setHeadOfHousehold(int headOfHousehold) {
        this.headOfHousehold = headOfHousehold;
    }


    @Override
    public String toString() {
        return "SplitRegistration{" +
                "splitRegistrationId=" + splitRegistrationId +
                ", registrationId=" + registrationId +
                ", reasonForSplit='" + reasonForSplit + '\'' +
                ", newAddress='" + newAddress + '\'' +
                ", previousAddress='" + previousAddress + '\'' +
                ", moveDate=" + moveDate +
                ", headOfHousehold=" + headOfHousehold +
                '}';
    }
    

   

    
    
    
} 