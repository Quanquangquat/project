/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author quang
 */
import java.util.Date;

public class Registration {

    private int registrationId;
    private int userId;
    private int householdId;
    private int registrationTypeId;
    private Date sentDate;
    private String reason;
    private int registrationStatusId;

    public Registration() {

    }

    public Registration(int registrationId, int userId, int householdId, int registrationTypeId,
            Date sentDate, String reason, int registrationStatusId) {
        this.registrationId = registrationId;
        this.userId = userId;
        this.householdId = householdId;
        this.registrationTypeId = registrationTypeId;
        this.sentDate = sentDate;
        this.reason = reason;
        this.registrationStatusId = registrationStatusId;
    }

    public Registration(int userId, int householdId, int registrationTypeId,
            Date sentDate, String reason, int registrationStatusId) {

        this.userId = userId;
        this.householdId = householdId;
        this.registrationTypeId = registrationTypeId;
        this.sentDate = sentDate;
        this.reason = reason;
        this.registrationStatusId = registrationStatusId;
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

    @Override
    public String toString() {
        return "Registration{"
                + "registrationId=" + registrationId
                + ", userId=" + userId
                + ", householdId=" + householdId
                + ", registrationTypeId=" + registrationTypeId
                + ", sentDate=" + sentDate
                + ", reason='" + reason + '\''
                + ", registrationStatusId=" + registrationStatusId
                + '}';
    }
}
