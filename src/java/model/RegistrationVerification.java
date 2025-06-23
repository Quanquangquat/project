package model;

import java.util.Date;

/**
 * Model class for RegistrationVerification
 */
public class RegistrationVerification {
    private int verificationId;
    private int registrationId;
    private Integer verificationUserId;
    private Date verificationDate;
    private String verifierComments;
    private int verificationStatusId;
    
    // Additional fields for UI display
    private String verifierName;
    private String statusName;
    private String verifierRole;
    
    public RegistrationVerification() {
    }
    
    public RegistrationVerification(int verificationId, int registrationId, Integer verificationUserId, 
            Date verificationDate, String verifierComments, int verificationStatusId) {
        this.verificationId = verificationId;
        this.registrationId = registrationId;
        this.verificationUserId = verificationUserId;
        this.verificationDate = verificationDate;
        this.verifierComments = verifierComments;
        this.verificationStatusId = verificationStatusId;
    }
    
    // Getters and setters
    public int getVerificationId() {
        return verificationId;
    }
    
    public void setVerificationId(int verificationId) {
        this.verificationId = verificationId;
    }
    
    public int getRegistrationId() {
        return registrationId;
    }
    
    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }
    
    public Integer getVerificationUserId() {
        return verificationUserId;
    }
    
    public void setVerificationUserId(Integer verificationUserId) {
        this.verificationUserId = verificationUserId;
    }
    
    public Date getVerificationDate() {
        return verificationDate;
    }
    
    public void setVerificationDate(Date verificationDate) {
        this.verificationDate = verificationDate;
    }
    
    public String getVerifierComments() {
        return verifierComments;
    }
    
    public void setVerifierComments(String verifierComments) {
        this.verifierComments = verifierComments;
    }
    
    public int getVerificationStatusId() {
        return verificationStatusId;
    }
    
    public void setVerificationStatusId(int verificationStatusId) {
        this.verificationStatusId = verificationStatusId;
    }
    
    public String getVerifierName() {
        return verifierName;
    }
    
    public void setVerifierName(String verifierName) {
        this.verifierName = verifierName;
    }
    
    public String getStatusName() {
        return statusName;
    }
    
    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
    public String getVerifierRole() {
        return verifierRole;
    }
    
    public void setVerifierRole(String verifierRole) {
        this.verifierRole = verifierRole;
    }
    
    @Override
    public String toString() {
        return "RegistrationVerification{" +
                "verificationId=" + verificationId +
                ", registrationId=" + registrationId +
                ", verificationUserId=" + verificationUserId +
                ", verificationDate=" + verificationDate +
                ", verifierComments='" + verifierComments + '\'' +
                ", verificationStatusId=" + verificationStatusId +
                '}';
    }
} 