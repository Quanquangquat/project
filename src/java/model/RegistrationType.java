/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author quang
 */
public class RegistrationType {

    private int registrationTypeId;
    private String typeName;
    private String description;

    public RegistrationType() {
    }

    public RegistrationType(int registrationTypeId, String typeName, String description) {
        this.registrationTypeId = registrationTypeId;
        this.typeName = typeName;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "RegistrationType{" +
                "registrationTypeId=" + registrationTypeId +
                ", typeName='" + typeName + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
