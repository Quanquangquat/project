package dao;

import model.RegistrationStatus;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationStatusDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(RegistrationStatusDAO.class.getName());

    // Get a registration status by ID
    public RegistrationStatus getStatusById(int statusId) {
        RegistrationStatus status = null;
        String query = "SELECT * FROM RegistrationStatuses WHERE StatusID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, statusId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    status = new RegistrationStatus();
                    status.setStatusId(rs.getInt("StatusID"));
                    status.setStatusName(rs.getString("StatusName"));
                    status.setDescription(rs.getString("Description"));
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting registration status by ID: " + ex.getMessage(), ex);
        }
        return status;
    }
    
    // Get all registration statuses
    public List<RegistrationStatus> getAllStatuses() {
        List<RegistrationStatus> statuses = new ArrayList<>();
        String query = "SELECT * FROM RegistrationStatuses";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                RegistrationStatus status = new RegistrationStatus();
                status.setStatusId(rs.getInt("StatusID"));
                status.setStatusName(rs.getString("StatusName"));
                status.setDescription(rs.getString("Description"));
                
                statuses.add(status);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting all registration statuses: " + ex.getMessage(), ex);
        }
        return statuses;
    }

    // Insert a new registration status
    public RegistrationStatus insertRegistrationStatus(RegistrationStatus status) {
        String query = "INSERT INTO RegistrationStatuses (StatusName, Description) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, status.getStatusName());
            ps.setString(2, status.getDescription());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    status.setStatusId(rs.getInt(1));
                    return status;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting registration status: " + ex.getMessage(), ex);
        }
        return null;
    }

    // Update an existing registration status
    public boolean updateRegistrationStatus(RegistrationStatus status) {
        String query = "UPDATE RegistrationStatuses SET StatusName = ?, Description = ? WHERE StatusID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status.getStatusName());
            ps.setString(2, status.getDescription());
            ps.setInt(3, status.getStatusId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating registration status: " + ex.getMessage(), ex);
            return false;
        }
    }

    // Delete a registration status by ID
    public boolean deleteRegistrationStatus(int statusId) {
        String query = "DELETE FROM RegistrationStatuses WHERE StatusID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, statusId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting registration status: " + ex.getMessage(), ex);
            return false;
        }
    }

    public static void main(String[] args) {
        RegistrationStatusDAO statusDAO = new RegistrationStatusDAO();
        List<RegistrationStatus> statuses = statusDAO.getAllStatuses();
        System.out.println("All Registration Statuses:");
        for (RegistrationStatus status : statuses) {
            System.out.println(status);
        }
    }
}
