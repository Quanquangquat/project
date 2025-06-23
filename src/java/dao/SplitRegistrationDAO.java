package dao;

import model.SplitRegistration;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for SplitRegistration
 * Provides CRUD operations for SplitRegistration entities
 */
public class SplitRegistrationDAO extends DBContext {
    
    /**
     * Insert a new SplitRegistration into the database
     * 
     * @param splitRegistration The SplitRegistration to insert
     * @return the generated ID if insertion was successful, -1 otherwise
     */
    public int insert(SplitRegistration splitRegistration) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int generatedId = -1;
        
        try {
            String sql = "INSERT INTO SplitRegistrations (RegistrationId, ReasonForSplit, NewAddress, PreviousAddress, MoveDate, HeadOfHousehold) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, splitRegistration.getRegistrationId());
            stmt.setString(2, splitRegistration.getReasonForSplit());
            stmt.setString(3, splitRegistration.getNewAddress());
            stmt.setString(4, splitRegistration.getPreviousAddress());
            stmt.setDate(5, splitRegistration.getMoveDate() != null ? new Date(splitRegistration.getMoveDate().getTime()) : null);
            stmt.setInt(6, splitRegistration.getHeadOfHousehold());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                    splitRegistration.setSplitRegistrationId(generatedId);
                }
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in insert: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return generatedId;
    }
    
    /**
     * Get a SplitRegistration by ID
     * 
     * @param splitRegistrationId The split registration ID
     * @return The SplitRegistration if found, null otherwise
     */
    public SplitRegistration getById(int splitRegistrationId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SplitRegistration splitRegistration = null;
        
        try {
            String sql = "SELECT * FROM SplitRegistrations WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                splitRegistration = mapResultSetToSplitRegistration(rs);
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in getById: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitRegistration;
    }
    
    /**
     * Get all SplitRegistrations for a specific household registration
     * 
     * @param registrationId The household registration ID
     * @return List of SplitRegistrations
     */
    public List<SplitRegistration> getByRegistrationId(int registrationId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitRegistration> splitRegistrations = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitRegistrations WHERE RegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, registrationId);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitRegistration splitRegistration = mapResultSetToSplitRegistration(rs);
                splitRegistrations.add(splitRegistration);
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in getByRegistrationId: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitRegistrations;
    }
    
    /**
     * Get all SplitRegistrations where a person is the head of household
     * 
     * @param memberId The member ID who is head of household
     * @return List of SplitRegistrations
     */
    public List<SplitRegistration> getByHeadOfHousehold(int memberId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitRegistration> splitRegistrations = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitRegistrations WHERE HeadOfHousehold = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, memberId);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitRegistration splitRegistration = mapResultSetToSplitRegistration(rs);
                splitRegistrations.add(splitRegistration);
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in getByHeadOfHousehold: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitRegistrations;
    }
    
    /**
     * Update an existing SplitRegistration
     * 
     * @param splitRegistration The updated SplitRegistration
     * @return true if update was successful, false otherwise
     */
    public boolean update(SplitRegistration splitRegistration) {
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            String sql = "UPDATE SplitRegistrations SET RegistrationId = ?, ReasonForSplit = ?, "
                    + "NewAddress = ?, PreviousAddress = ?, MoveDate = ?, HeadOfHousehold = ? "
                    + "WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistration.getRegistrationId());
            stmt.setString(2, splitRegistration.getReasonForSplit());
            stmt.setString(3, splitRegistration.getNewAddress());
            stmt.setString(4, splitRegistration.getPreviousAddress());
            stmt.setDate(5, splitRegistration.getMoveDate() != null ? new Date(splitRegistration.getMoveDate().getTime()) : null);
            stmt.setInt(6, splitRegistration.getHeadOfHousehold());
            stmt.setInt(7, splitRegistration.getSplitRegistrationId());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in update: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, null);
        }
        
        return success;
    }
    
    /**
     * Delete a SplitRegistration
     * 
     * @param splitRegistrationId The split registration ID
     * @return true if deletion was successful, false otherwise
     */
    public boolean delete(int splitRegistrationId) {
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            // First delete all associated split members
            SplitMemberDAO splitMemberDAO = new SplitMemberDAO();
            splitMemberDAO.deleteBySplitRegistration(splitRegistrationId);
            
            // Then delete the split registration
            String sql = "DELETE FROM SplitRegistrations WHERE SplitRegistrationId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, splitRegistrationId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in delete: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, null);
        }
        
        return success;
    }
    
    /**
     * Get all SplitRegistrations
     * 
     * @return List of all SplitRegistrations
     */
    public List<SplitRegistration> getAll() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitRegistration> splitRegistrations = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitRegistrations";
            stmt = connection.prepareStatement(sql);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitRegistration splitRegistration = mapResultSetToSplitRegistration(rs);
                splitRegistrations.add(splitRegistration);
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in getAll: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitRegistrations;
    }
    
    /**
     * Map a ResultSet to a SplitRegistration object
     * 
     * @param rs The ResultSet to map
     * @return The mapped SplitRegistration
     * @throws SQLException If a database error occurs
     */
    private SplitRegistration mapResultSetToSplitRegistration(ResultSet rs) throws SQLException {
        SplitRegistration splitRegistration = new SplitRegistration();
        splitRegistration.setSplitRegistrationId(rs.getInt("SplitRegistrationId"));
        splitRegistration.setRegistrationId(rs.getInt("RegistrationId"));
        splitRegistration.setReasonForSplit(rs.getString("ReasonForSplit"));
        splitRegistration.setNewAddress(rs.getString("NewAddress"));
        splitRegistration.setPreviousAddress(rs.getString("PreviousAddress"));
        
        Date moveDate = rs.getDate("MoveDate");
        if (moveDate != null) {
            splitRegistration.setMoveDate(new java.util.Date(moveDate.getTime()));
        }
        
        splitRegistration.setHeadOfHousehold(rs.getInt("HeadOfHousehold"));
        
        return splitRegistration;
    }
    
    /**
     * Get split registrations by date range
     * 
     * @param startDate The start date
     * @param endDate The end date
     * @return List of SplitRegistrations in the date range
     */
    public List<SplitRegistration> getByDateRange(java.util.Date startDate, java.util.Date endDate) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SplitRegistration> splitRegistrations = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM SplitRegistrations WHERE MoveDate BETWEEN ? AND ?";
            stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new Date(startDate.getTime()));
            stmt.setDate(2, new Date(endDate.getTime()));
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                SplitRegistration splitRegistration = mapResultSetToSplitRegistration(rs);
                splitRegistrations.add(splitRegistration);
            }
        } catch (SQLException e) {
            System.err.println("SplitRegistrationDAO ERROR in getByDateRange: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, rs);
        }
        
        return splitRegistrations;
    }
} 