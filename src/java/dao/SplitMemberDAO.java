package dao;

import model.SplitMember;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for SplitMember
 * Provides CRUD operations for SplitMember entities
 */
public class SplitMemberDAO extends DBContext {
    
    /**
     * Insert a new SplitMember into the database
     * 
     * @param splitMember The SplitMember to insert
     * @return true if insertion was successful, false otherwise
     */
    public boolean insert(SplitMember splitMember) {
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            String sql = "INSERT INTO SplitMembers (SplitRegistrationId, MemberId) VALUES (?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitMember.getSplitRegistrationId());
            stmt.setInt(2, splitMember.getMemberId());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in insert: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, null);
        }
        
        return success;
    }
    
    /**
     * Get a SplitMember by splitRegistrationId and memberId
     * 
     * @param splitRegistrationId The split registration ID
     * @param memberId The member ID
     * @return The SplitMember if found, null otherwise
     */
    public SplitMember get(int splitRegistrationId, int memberId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SplitMember splitMember = null;
        
        try {
            String sql = "SELECT * FROM SplitMembers WHERE SplitRegistrationId = ? AND MemberId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            stmt.setInt(2, memberId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                splitMember = new SplitMember(
                    rs.getInt("SplitRegistrationId"),
                    rs.getInt("MemberId")
                );
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in get: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitMember;
    }
    
    /**
     * Get all SplitMembers associated with a specific split registration
     * 
     * @param splitRegistrationId The split registration ID
     * @return List of SplitMembers
     */
    public List<SplitMember> getBySplitRegistration(int splitRegistrationId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitMember> splitMembers = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitMembers WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitMember splitMember = new SplitMember(
                    rs.getInt("SplitRegistrationId"),
                    rs.getInt("MemberId")
                );
                splitMembers.add(splitMember);
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in getBySplitRegistration: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitMembers;
    }
    
    /**
     * Get all SplitMembers associated with a specific member
     * 
     * @param memberId The member ID
     * @return List of SplitMembers
     */
    public List<SplitMember> getByMember(int memberId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitMember> splitMembers = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitMembers WHERE MemberId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, memberId);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitMember splitMember = new SplitMember(
                    rs.getInt("SplitRegistrationId"),
                    rs.getInt("MemberId")
                );
                splitMembers.add(splitMember);
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in getByMember: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitMembers;
    }
    
    /**
     * Delete a SplitMember
     * 
     * @param splitRegistrationId The split registration ID
     * @param memberId The member ID
     * @return true if deletion was successful, false otherwise
     */
    public boolean delete(int splitRegistrationId, int memberId) {
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            String sql = "DELETE FROM SplitMembers WHERE SplitRegistrationId = ? AND MemberId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            stmt.setInt(2, memberId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in delete: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, null);
        }
        
        return success;
    }
    
    /**
     * Delete all SplitMembers associated with a specific split registration
     * 
     * @param splitRegistrationId The split registration ID
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteBySplitRegistration(int splitRegistrationId) {
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            String sql = "DELETE FROM SplitMembers WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in deleteBySplitRegistration: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, null);
        }
        
        return success;
    }
    
    /**
     * Get all SplitMembers
     * 
     * @return List of all SplitMembers
     */
    public List<SplitMember> getAll() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitMember> splitMembers = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitMembers";
            stmt = connection.prepareStatement(sql);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitMember splitMember = new SplitMember(
                    rs.getInt("SplitRegistrationId"),
                    rs.getInt("MemberId")
                );
                splitMembers.add(splitMember);
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in getAll: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitMembers;
    }
    
    /**
     * Check if a member is included in any split registration
     * 
     * @param memberId The member ID
     * @return true if the member is in any split registration, false otherwise
     */
    public boolean isMemberInAnySplit(int memberId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean isInSplit = false;
        
        try {
            String sql = "SELECT COUNT(*) FROM SplitMembers WHERE MemberId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, memberId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                isInSplit = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in isMemberInAnySplit: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return isInSplit;
    }
    
    /**
     * Count the number of members in a split registration
     * 
     * @param splitRegistrationId The split registration ID
     * @return The number of members
     */
    public int countMembersInSplit(int splitRegistrationId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            String sql = "SELECT COUNT(*) FROM SplitMembers WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("SplitMemberDAO ERROR in countMembersInSplit: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return count;
    }
} 