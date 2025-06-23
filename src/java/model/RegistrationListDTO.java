package model;

import java.util.Date;

/**
 * Data Transfer Object for Registration list display
 * Contains all the necessary properties for displaying registrations in the list view
 */
public class RegistrationListDTO {
    private int registrationId;
    private int userId;
    private String userName;
    private int householdId;
    private int registrationTypeId;
    private String typeName;
    private Date sentDate;
    private String reason;
    private int registrationStatusId;
    private boolean policeVerified;
    private boolean areaLeaderVerified;
    
    public RegistrationListDTO() {
    }
    
    public RegistrationListDTO(int registrationId, int userId, String userName, int householdId, 
            int registrationTypeId, String typeName, Date sentDate, String reason, 
            int registrationStatusId, boolean policeVerified, boolean areaLeaderVerified) {
        this.registrationId = registrationId;
        this.userId = userId;
        this.userName = userName;
        this.householdId = householdId;
        this.registrationTypeId = registrationTypeId;
        this.typeName = typeName;
        this.sentDate = sentDate;
        this.reason = reason;
        this.registrationStatusId = registrationStatusId;
        this.policeVerified = policeVerified;
        this.areaLeaderVerified = areaLeaderVerified;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getHouseholdId() {
        return householdId;
    }

    public void setHouseholdId(int householdId) {
        this.householdId = householdId;
    }

    public int getRegistrationTypeId() {
        return registrationTypeId;
    }

    public void setRegistrationTypeId(int registrationTypeId) {
        this.registrationTypeId = registrationTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Date getSentDate() {
        return sentDate;
    }

    public void setSentDate(Date sentDate) {
        this.sentDate = sentDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getRegistrationStatusId() {
        return registrationStatusId;
    }

    public void setRegistrationStatusId(int registrationStatusId) {
        this.registrationStatusId = registrationStatusId;
    }

    public boolean isPoliceVerified() {
        return policeVerified;
    }

    public void setPoliceVerified(boolean policeVerified) {
        this.policeVerified = policeVerified;
    }

    public boolean isAreaLeaderVerified() {
        return areaLeaderVerified;
    }

    public void setAreaLeaderVerified(boolean areaLeaderVerified) {
        this.areaLeaderVerified = areaLeaderVerified;
    }

    @Override
    public String toString() {
        return "RegistrationListDTO{" + 
                "registrationId=" + registrationId + 
                ", userId=" + userId + 
                ", userName='" + userName + '\'' + 
                ", householdId=" + householdId + 
                ", registrationTypeId=" + registrationTypeId + 
                ", typeName='" + typeName + '\'' + 
                ", sentDate=" + sentDate + 
                ", reason='" + reason + '\'' + 
                ", registrationStatusId=" + registrationStatusId + 
                ", policeVerified=" + policeVerified + 
                ", areaLeaderVerified=" + areaLeaderVerified + 
                '}';
    }
} 