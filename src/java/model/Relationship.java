/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author quang
 */
public class Relationship {

    private int relationshipId;
    private String relationshipName;
    private String description;

    public Relationship() {
    }

    public Relationship(int relationshipId, String relationshipName, String description) {
        this.relationshipId = relationshipId;
        this.relationshipName = relationshipName;
        this.description = description;
    }

    public int getRelationshipId() {
        return relationshipId;
    }

    public void setRelationshipId(int relationshipId) {
        this.relationshipId = relationshipId;
    }

    public String getRelationshipName() {
        return relationshipName;
    }

    public void setRelationshipName(String relationshipName) {
        this.relationshipName = relationshipName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Relationships{"
                + "relationshipId=" + relationshipId
                + ", relationshipName='" + relationshipName + '\''
                + ", description='" + description + '\''
                + '}';
    }
}
