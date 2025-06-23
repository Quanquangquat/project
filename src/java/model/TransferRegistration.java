// src/java/model/TransferRegistration.java
package model;

import java.util.Date;

public class TransferRegistration {

    private int transferRegistrationId;
    private int registrationId;
    private String newAddress;

    private String previousAddress;
    private String reasonForTransfer;

    private Date moveDate;

    public TransferRegistration() {
    }

    // Constructor with parameters
    public TransferRegistration(int transferRegistrationId, int registrationId, String newAddress,
            String previousAddress, String reasonForTransfer, Date moveDate) {
        this.transferRegistrationId = transferRegistrationId;
        this.registrationId = registrationId;
        this.newAddress = newAddress;
        this.previousAddress = previousAddress;
        this.reasonForTransfer = reasonForTransfer;
        this.moveDate = moveDate;
    }

    public TransferRegistration(int registrationId, String newAddress,
            String previousAddress, String reasonForTransfer, Date moveDate) {

        this.registrationId = registrationId;
        this.newAddress = newAddress;
        this.previousAddress = previousAddress;
        this.reasonForTransfer = reasonForTransfer;
        this.moveDate = moveDate;
    }

    // Getters
    public int getTransferRegistrationId() {
        return transferRegistrationId;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public String getNewAddress() {
        return newAddress;
    }

    public String getPreviousAddress() {
        return previousAddress;
    }

    public String getReasonForTransfer() {
        return reasonForTransfer;
    }

    public Date getMoveDate() {
        return moveDate;
    }

    // Setters
    public void setTransferRegistrationId(int transferRegistrationId) {
        this.transferRegistrationId = transferRegistrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public void setNewAddress(String newAddress) {
        this.newAddress = newAddress;
    }

    public void setPreviousAddress(String previousAddress) {
        this.previousAddress = previousAddress;
    }

    public void setReasonForTransfer(String reasonForTransfer) {
        this.reasonForTransfer = reasonForTransfer;
    }

    public void setMoveDate(Date moveDate) {
        this.moveDate = moveDate;
    }

    @Override
    public String toString() {
        return "TransferRegistration{"
                + "transferRegistrationId=" + transferRegistrationId
                + ", registrationId=" + registrationId
                + ", newAddress='" + newAddress + '\''
                + ", previousAddress='" + previousAddress + '\''
                + ", reasonForTransfer='" + reasonForTransfer + '\''
                + ", moveDate=" + moveDate
                + '}';
    }
}
