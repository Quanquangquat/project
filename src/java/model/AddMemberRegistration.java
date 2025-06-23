package model;

import java.util.Date;

public class AddMemberRegistration {
    private int addMemberRegistrationId;
    private int registrationId;
    private String fullName;
    private Date dateOfBirth;
    private String gender;
    private String idNumber;
    private String phoneNumber;
    private String relationship;
    private String reasonForAddition;
    private Integer previousHouseholdId;
    private boolean headOfHouseholdConsent;
    
    public AddMemberRegistration() {
    }
    
    public AddMemberRegistration(int addMemberRegistrationId, int registrationId, String fullName, 
            Date dateOfBirth, String gender, String idNumber, String phoneNumber, 
            String relationship, String reasonForAddition, Integer previousHouseholdId, 
            boolean headOfHouseholdConsent) {
        this.addMemberRegistrationId = addMemberRegistrationId;
        this.registrationId = registrationId;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.idNumber = idNumber;
        this.phoneNumber = phoneNumber;
        this.relationship = relationship;
        this.reasonForAddition = reasonForAddition;
        this.previousHouseholdId = previousHouseholdId;
        this.headOfHouseholdConsent = headOfHouseholdConsent;
    }
    
    // Getters and setters
    public int getAddMemberRegistrationId() {
        return addMemberRegistrationId;
    }
    
    public void setAddMemberRegistrationId(int addMemberRegistrationId) {
        this.addMemberRegistrationId = addMemberRegistrationId;
    }
    
    public int getRegistrationId() {
        return registrationId;
    }
    
    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getIdNumber() {
        return idNumber;
    }
    
    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public String getRelationship() {
        return relationship;
    }
    
    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }
    
    public String getReasonForAddition() {
        return reasonForAddition;
    }
    
    public void setReasonForAddition(String reasonForAddition) {
        this.reasonForAddition = reasonForAddition;
    }
    
    public Integer getPreviousHouseholdId() {
        return previousHouseholdId;
    }
    
    public void setPreviousHouseholdId(Integer previousHouseholdId) {
        this.previousHouseholdId = previousHouseholdId;
    }
    
    public boolean isHeadOfHouseholdConsent() {
        return headOfHouseholdConsent;
    }
    
    public void setHeadOfHouseholdConsent(boolean headOfHouseholdConsent) {
        this.headOfHouseholdConsent = headOfHouseholdConsent;
    }
    
    @Override
    public String toString() {
        return "AddMemberRegistration{" +
                "addMemberRegistrationId=" + addMemberRegistrationId +
                ", registrationId=" + registrationId +
                ", fullName='" + fullName + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender='" + gender + '\'' +
                ", idNumber='" + idNumber + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", relationship='" + relationship + '\'' +
                ", reasonForAddition='" + reasonForAddition + '\'' +
                ", previousHouseholdId=" + previousHouseholdId +
                ", headOfHouseholdConsent=" + headOfHouseholdConsent +
                '}';
    }
} 