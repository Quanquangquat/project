package dao;

import model.RegistrationVerification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.HashMap;
import java.util.Map;

/**
 * Data Access Object for RegistrationVerification
 */
public class RegistrationVerificationDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(RegistrationVerificationDAO.class.getName());
    
    /**
     * Insert a new verification record
     * @param verification The verification to insert
     * @return The inserted verification with ID set, or null if insertion failed
     */
    public RegistrationVerification insertVerification(RegistrationVerification verification) {
        String query = "INSERT INTO RegistrationVerifications (RegistrationID, VerificationUserID, VerificationDate, " +
                "VerifierComments, VerificationStatusID) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, verification.getRegistrationId());
            
            if (verification.getVerificationUserId() != null) {
                ps.setInt(2, verification.getVerificationUserId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            
            if (verification.getVerificationDate() != null) {
                ps.setDate(3, new java.sql.Date(verification.getVerificationDate().getTime()));
            } else {
                ps.setDate(3, new java.sql.Date(new java.util.Date().getTime())); // Default to current date
            }
            
            ps.setString(4, verification.getVerifierComments());
            ps.setInt(5, verification.getVerificationStatusId());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        verification.setVerificationId(rs.getInt(1));
                        return verification;
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting verification: " + ex.getMessage(), ex);
        }
        return null;
    }
    
    /**
     * Get a verification by ID
     * @param verificationId The ID of the verification to retrieve
     * @return The verification, or null if not found
     */
    public RegistrationVerification getVerificationById(int verificationId) {
        String query = "SELECT v.*, u.FullName AS VerifierName, u.RoleID, r.RoleName AS VerifierRole, " +
                "s.StatusName FROM RegistrationVerifications v " +
                "LEFT JOIN Users u ON v.VerificationUserID = u.UserID " +
                "LEFT JOIN Roles r ON u.RoleID = r.RoleID " +
                "LEFT JOIN RegistrationStatuses s ON v.VerificationStatusID = s.StatusID " +
                "WHERE v.VerificationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, verificationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVerificationFromResultSet(rs);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting verification by ID: " + ex.getMessage(), ex);
        }
        return null;
    }
    
    /**
     * Get all verifications for a registration
     * @param registrationId The ID of the registration
     * @return List of verifications for the registration
     */
    public List<RegistrationVerification> getVerificationsByRegistrationId(int registrationId) {
        List<RegistrationVerification> verifications = new ArrayList<>();
        String query = "SELECT v.*, u.FullName AS VerifierName, u.RoleID, r.RoleName AS VerifierRole, " +
                "s.StatusName FROM RegistrationVerifications v " +
                "LEFT JOIN Users u ON v.VerificationUserID = u.UserID " +
                "LEFT JOIN Roles r ON u.RoleID = r.RoleID " +
                "LEFT JOIN RegistrationStatuses s ON v.VerificationStatusID = s.StatusID " +
                "WHERE v.RegistrationID = ? " +
                "ORDER BY v.VerificationDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    verifications.add(mapVerificationFromResultSet(rs));
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting verifications for registration: " + ex.getMessage(), ex);
        }
        return verifications;
    }
    
    /**
     * Get all verifications by a specific user
     * @param userId The ID of the user who performed the verifications
     * @return List of verifications by the user
     */
    public List<RegistrationVerification> getVerificationsByUserId(int userId) {
        List<RegistrationVerification> verifications = new ArrayList<>();
        String query = "SELECT v.*, u.FullName AS VerifierName, u.RoleID, r.RoleName AS VerifierRole, " +
                "s.StatusName FROM RegistrationVerifications v " +
                "LEFT JOIN Users u ON v.VerificationUserID = u.UserID " +
                "LEFT JOIN Roles r ON u.RoleID = r.RoleID " +
                "LEFT JOIN RegistrationStatuses s ON v.VerificationStatusID = s.StatusID " +
                "WHERE v.VerificationUserID = ? " +
                "ORDER BY v.VerificationDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    verifications.add(mapVerificationFromResultSet(rs));
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting verifications by user: " + ex.getMessage(), ex);
        }
        return verifications;
    }
    
    /**
     * Update a verification record
     * @param verification The verification to update
     * @return true if update was successful, false otherwise
     */
    public boolean updateVerification(RegistrationVerification verification) {
        String query = "UPDATE RegistrationVerifications SET VerificationUserID = ?, VerificationDate = ?, " +
                "VerifierComments = ?, VerificationStatusID = ? WHERE VerificationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            if (verification.getVerificationUserId() != null) {
                ps.setInt(1, verification.getVerificationUserId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            
            if (verification.getVerificationDate() != null) {
                ps.setDate(2, new java.sql.Date(verification.getVerificationDate().getTime()));
            } else {
                ps.setNull(2, java.sql.Types.DATE);
            }
            
            ps.setString(3, verification.getVerifierComments());
            ps.setInt(4, verification.getVerificationStatusId());
            ps.setInt(5, verification.getVerificationId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating verification: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    /**
     * Delete a verification record
     * @param verificationId The ID of the verification to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteVerification(int verificationId) {
        String query = "DELETE FROM RegistrationVerifications WHERE VerificationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, verificationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting verification: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    /**
     * Check if a verification exists for a registration by a specific role
     * @param registrationId The ID of the registration
     * @param roleId The ID of the role (2 for Police, 3 for Area Leader)
     * @return true if a verification exists, false otherwise
     */
    public boolean hasVerificationByRole(int registrationId, int roleId) {
        String query = "SELECT COUNT(*) FROM RegistrationVerifications v " +
                "INNER JOIN Users u ON v.VerificationUserID = u.UserID " +
                "WHERE v.RegistrationID = ? AND u.RoleID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            ps.setInt(2, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking verification by role: " + ex.getMessage(), ex);
        }
        return false;
    }
    
    /**
     * Check if a specific user has verified a specific registration
     * 
     * @param registrationId The registration ID
     * @param userId The user ID
     * @return True if the user has verified the registration, false otherwise
     */
    public boolean hasVerificationByUserAndRegistration(int registrationId, int userId) {
        boolean hasVerification = false;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT COUNT(*) AS count FROM RegistrationVerifications WHERE RegistrationID = ? AND VerificationUserID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, registrationId);
            stmt.setInt(2, userId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                hasVerification = rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking verification by user and registration: " + e.getMessage(), e);
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return hasVerification;
    }
    
    /**
     * Helper method to map a ResultSet row to a RegistrationVerification object
     * @param rs The ResultSet to map
     * @return The mapped RegistrationVerification
     * @throws SQLException If an error occurs while accessing the ResultSet
     */
    private RegistrationVerification mapVerificationFromResultSet(ResultSet rs) throws SQLException {
        RegistrationVerification verification = new RegistrationVerification();
        verification.setVerificationId(rs.getInt("VerificationID"));
        verification.setRegistrationId(rs.getInt("RegistrationID"));
        
        int verificationUserId = rs.getInt("VerificationUserID");
        if (!rs.wasNull()) {
            verification.setVerificationUserId(verificationUserId);
        }
        
        verification.setVerificationDate(rs.getDate("VerificationDate"));
        verification.setVerifierComments(rs.getString("VerifierComments"));
        verification.setVerificationStatusId(rs.getInt("VerificationStatusID"));
        
        // Additional fields for UI display
        verification.setVerifierName(rs.getString("VerifierName"));
        verification.setStatusName(rs.getString("StatusName"));
        verification.setVerifierRole(rs.getString("VerifierRole"));
        
        return verification;
    }
    
    /**
     * Get all verification statuses from the database
     * This is a debugging method to check what verification statuses exist
     * 
     * @return A list of maps containing verification status information
     */
    public List<Map<String, Object>> getAllVerificationStatuses() {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT DISTINCT rv.VerificationStatusID, COUNT(*) as Count "
                    + "FROM RegistrationVerifications rv "
                    + "GROUP BY rv.VerificationStatusID";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> status = new HashMap<>();
                status.put("statusId", rs.getInt("VerificationStatusID"));
                status.put("count", rs.getInt("Count"));
                result.add(status);
            }
            
            LOGGER.log(Level.INFO, "Found {0} distinct verification statuses", result.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting verification statuses: " + e.getMessage(), e);
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return result;
    }
} 