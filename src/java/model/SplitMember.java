package model;

/**
 * Represents a member who will be included in a household split
 * Maps to the SplitMembers table in the database
 */
public class SplitMember {
    private int splitRegistrationId;
    private int memberId;
   
    
    public SplitMember() {
    }
    
    public SplitMember(int splitRegistrationId, int memberId) {
        this.splitRegistrationId = splitRegistrationId;
        this.memberId = memberId;
    }
    
   
    // Getters and setters
    public int getSplitRegistrationId() {
        return splitRegistrationId;
    }
    
    public void setSplitRegistrationId(int splitRegistrationId) {
        this.splitRegistrationId = splitRegistrationId;
    }
    
    public int getMemberId() {
        return memberId;
    }
    
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
    
   
    
    @Override
    public String toString() {
        return "SplitMember{" +
                "splitRegistrationId=" + splitRegistrationId +
                ", memberId=" + memberId +
                '}';
    }
} 