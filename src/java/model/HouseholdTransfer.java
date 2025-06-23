package model;

import java.util.Date;

/**
 * Model class representing a household transfer request
 */
public class HouseholdTransfer {
    private int transferId;
    private int userId;
    private String currentAddress;
    private String destinationAddress;
    private int destinationAreaId;
    private String reason;
    private String status; // Pending, Approved by Area Leader, Approved by Police, Completed, Rejected
    private Date requestDate;
    private Date approvalDate;
    private String areaLeaderNotes;
    private String policeNotes;
    
    // Constructors
    public HouseholdTransfer() {
    }
    
    public HouseholdTransfer(int transferId, int userId, String currentAddress, String destinationAddress, 
                            int destinationAreaId, String reason, String status, Date requestDate, 
                            Date approvalDate, String areaLeaderNotes, String policeNotes) {
        this.transferId = transferId;
        this.userId = userId;
        this.currentAddress = currentAddress;
        this.destinationAddress = destinationAddress;
        this.destinationAreaId = destinationAreaId;
        this.reason = reason;
        this.status = status;
        this.requestDate = requestDate;
        this.approvalDate = approvalDate;
        this.areaLeaderNotes = areaLeaderNotes;
        this.policeNotes = policeNotes;
    }
    
    // Getters and Setters
    public int getTransferId() {
        return transferId;
    }

    public void setTransferId(int transferId) {
        this.transferId = transferId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCurrentAddress() {
        return currentAddress;
    }

    public void setCurrentAddress(String currentAddress) {
        this.currentAddress = currentAddress;
    }

    public String getDestinationAddress() {
        return destinationAddress;
    }

    public void setDestinationAddress(String destinationAddress) {
        this.destinationAddress = destinationAddress;
    }

    public int getDestinationAreaId() {
        return destinationAreaId;
    }

    public void setDestinationAreaId(int destinationAreaId) {
        this.destinationAreaId = destinationAreaId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getAreaLeaderNotes() {
        return areaLeaderNotes;
    }

    public void setAreaLeaderNotes(String areaLeaderNotes) {
        this.areaLeaderNotes = areaLeaderNotes;
    }

    public String getPoliceNotes() {
        return policeNotes;
    }

    public void setPoliceNotes(String policeNotes) {
        this.policeNotes = policeNotes;
    }
} 