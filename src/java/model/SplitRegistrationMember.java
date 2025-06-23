package model;

public class SplitRegistrationMember {
    private int memberId;
    private int splitRegistrationId;
    private int userId;
    private User user; // For convenience, to store the user details
    
    public SplitRegistrationMember() {
    }
    
    public SplitRegistrationMember(int memberId, int splitRegistrationId, int userId) {
        this.memberId = memberId;
        this.splitRegistrationId = splitRegistrationId;
        this.userId = userId;
    }
    
    // Getters and setters
    public int getMemberId() {
        return memberId;
    }
    
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
    
    public int getSplitRegistrationId() {
        return splitRegistrationId;
    }
    
    public void setSplitRegistrationId(int splitRegistrationId) {
        this.splitRegistrationId = splitRegistrationId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    @Override
    public String toString() {
        return "SplitRegistrationMember{" +
                "memberId=" + memberId +
                ", splitRegistrationId=" + splitRegistrationId +
                ", userId=" + userId +
                ", user=" + user +
                '}';
    }
} 