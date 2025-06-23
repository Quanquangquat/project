package model;

import java.util.Date;

/**
 * Model class representing a user's avatar
 */
public class UserAvatar {
    private int avatarId;
    private int userId;
    private String avatarPath;
    private Date uploadDate;
    private boolean isActive;
    
    // Constructors
    public UserAvatar() {
    }
    
    public UserAvatar(int userId, String avatarPath) {
        this.userId = userId;
        this.avatarPath = avatarPath;
        this.uploadDate = new Date();
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getAvatarId() {
        return avatarId;
    }
    
    public void setAvatarId(int avatarId) {
        this.avatarId = avatarId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getAvatarPath() {
        return avatarPath;
    }
    
    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
    
    public Date getUploadDate() {
        return uploadDate;
    }
    
    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }
    
    public boolean isIsActive() {
        return isActive;
    }
    
    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
} 