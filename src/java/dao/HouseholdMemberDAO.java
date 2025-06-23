package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.HouseholdMember;

public class HouseholdMemberDAO extends DBContext {
    
    private static final Logger LOGGER = Logger.getLogger(HouseholdMemberDAO.class.getName());
    
    /**
     * Get all members of a household
     * @param householdId The ID of the household
     * @return List of household members
     */
    public List<HouseholdMember> getMembersByHouseholdId(int householdId) {
        List<HouseholdMember> members = new ArrayList<>();
        String query = "SELECT * FROM HouseholdMembers WHERE HouseholdID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, householdId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HouseholdMember member = new HouseholdMember();
                    member.setMemberId(rs.getInt("MemberID"));
                    member.setHouseholdId(rs.getInt("HouseholdID"));
                    member.setFullName(rs.getString("FullName"));
                    member.setRelationship(rs.getString("Relationship"));
                    member.setDateOfBirth(rs.getTimestamp("DateOfBirth"));
                    member.setGender(rs.getString("Gender"));
                    member.setPhoneNumber(rs.getString("PhoneNumber"));
                    member.setEmail(rs.getString("Email"));
                    member.setCccd(rs.getString("CCCD"));
                    member.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    
                    members.add(member);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting members for household " + householdId, ex);
        }
        
        return members;
    }
    
    /**
     * Get a household member by ID
     * @param memberId The ID of the member
     * @return The household member or null if not found
     */
    public HouseholdMember getMemberById(int memberId) {
        String query = "SELECT * FROM HouseholdMembers WHERE MemberID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HouseholdMember member = new HouseholdMember();
                    member.setMemberId(rs.getInt("MemberID"));
                    member.setHouseholdId(rs.getInt("HouseholdID"));
                    member.setFullName(rs.getString("FullName"));
                    member.setRelationship(rs.getString("Relationship"));
                    member.setDateOfBirth(rs.getTimestamp("DateOfBirth"));
                    member.setGender(rs.getString("Gender"));
                    member.setPhoneNumber(rs.getString("PhoneNumber"));
                    member.setEmail(rs.getString("Email"));
                    member.setCccd(rs.getString("CCCD"));
                    member.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    
                    return member;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting member with ID " + memberId, ex);
        }
        
        return null;
    }
    
    /**
     * Insert a new household member
     * @param member The household member to insert
     * @return The inserted household member with generated ID, or null if insertion failed
     */
    public HouseholdMember insertMember(HouseholdMember member) {
        String query = "INSERT INTO HouseholdMembers (HouseholdID, FullName, Relationship, DateOfBirth, Gender, PhoneNumber, Email, CCCD, CreatedDate) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, member.getHouseholdId());
            ps.setString(2, member.getFullName());
            ps.setString(3, member.getRelationship());
            
            if (member.getDateOfBirth() != null) {
                ps.setTimestamp(4, new Timestamp(member.getDateOfBirth().getTime()));
            } else {
                ps.setNull(4, java.sql.Types.TIMESTAMP);
            }
            
            ps.setString(5, member.getGender());
            ps.setString(6, member.getPhoneNumber());
            ps.setString(7, member.getEmail());
            ps.setString(8, member.getCccd());
            
            if (member.getCreatedDate() != null) {
                ps.setTimestamp(9, new Timestamp(member.getCreatedDate().getTime()));
            } else {
                ps.setTimestamp(9, new Timestamp(new Date().getTime()));
            }
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    member.setMemberId(rs.getInt(1));
                    LOGGER.log(Level.INFO, "Successfully inserted household member with ID: " + member.getMemberId());
                    return member;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting household member", ex);
        }
        
        return null;
    }
    
    /**
     * Update an existing household member
     * @param member The household member to update
     * @return true if update was successful, false otherwise
     */
    public boolean updateMember(HouseholdMember member) {
        String query = "UPDATE HouseholdMembers SET FullName = ?, Relationship = ?, DateOfBirth = ?, " +
                       "Gender = ?, PhoneNumber = ?, Email = ?, CCCD = ? WHERE MemberID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, member.getFullName());
            ps.setString(2, member.getRelationship());
            
            if (member.getDateOfBirth() != null) {
                ps.setTimestamp(3, new Timestamp(member.getDateOfBirth().getTime()));
            } else {
                ps.setNull(3, java.sql.Types.TIMESTAMP);
            }
            
            ps.setString(4, member.getGender());
            ps.setString(5, member.getPhoneNumber());
            ps.setString(6, member.getEmail());
            ps.setString(7, member.getCccd());
            ps.setInt(8, member.getMemberId());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully updated household member with ID: " + member.getMemberId());
                return true;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating household member with ID " + member.getMemberId(), ex);
        }
        
        return false;
    }
    
    /**
     * Delete a household member
     * @param memberId The ID of the member to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteMember(int memberId) {
        String query = "DELETE FROM HouseholdMembers WHERE MemberID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, memberId);
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully deleted household member with ID: " + memberId);
                return true;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting household member with ID " + memberId, ex);
        }
        
        return false;
    }
    
    /**
     * Check if a CCCD already exists in the household members
     * @param cccd The CCCD to check
     * @return true if the CCCD exists, false otherwise
     */
    public boolean isCCCDExists(String cccd) {
        String query = "SELECT COUNT(*) FROM HouseholdMembers WHERE CCCD = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, cccd);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking if CCCD " + cccd + " exists", ex);
        }
        
        return false;
    }
    
    /**
     * Register a new household member
     * @param member The household member information
     * @return The inserted household member, or null if registration failed
     */
    public HouseholdMember registerMember(HouseholdMember member) {
        try {
            // Start transaction
            connection.setAutoCommit(false);
            
            try {
                // Check if CCCD already exists
                if (member.getCccd() != null && !member.getCccd().isEmpty() && isCCCDExists(member.getCccd())) {
                    LOGGER.log(Level.WARNING, "CCCD already exists: " + member.getCccd());
                    connection.rollback();
                    return null;
                }
                
                // Insert the household member
                HouseholdMember insertedMember = insertMember(member);
                
                if (insertedMember != null) {
                    // Commit the transaction
                    connection.commit();
                    LOGGER.log(Level.INFO, "Successfully registered new household member");
                    return insertedMember;
                } else {
                    // Rollback if member insertion failed
                    connection.rollback();
                    LOGGER.log(Level.SEVERE, "Failed to insert household member record");
                }
            } catch (SQLException ex) {
                // Rollback on any exception
                connection.rollback();
                throw ex;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error registering household member", ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error resetting auto-commit", ex);
            }
        }
        
        return null;
    }
}
