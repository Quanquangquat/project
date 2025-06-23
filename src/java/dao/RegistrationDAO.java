package dao;

import model.Registration;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Map;
import java.util.HashMap;
import model.RegistrationDocument;
import model.TransferRegistration;

public class RegistrationDAO extends DBContext {

    TransferRegistrationDAO transferRegistrationDao = new TransferRegistrationDAO();

    RegistrationDocumentDAO documentDao = new RegistrationDocumentDAO();
    private static final Logger LOGGER = Logger.getLogger(RegistrationDAO.class.getName());

    // Insert a new registration
    public Registration insertRegistration(Registration registration) {
        String query = "INSERT INTO Registrations (UserID, HouseholdID, RegistrationTypeID, SentDate, Reason, RegistrationStatusID) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, registration.getUserId());
            ps.setInt(2, registration.getHouseholdId());
            ps.setInt(3, registration.getRegistrationTypeId());
            ps.setDate(4, new java.sql.Date(registration.getSentDate().getTime()));
            ps.setString(5, registration.getReason());
            ps.setInt(6, registration.getRegistrationStatusId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    registration.setRegistrationId(rs.getInt(1));
                    return registration;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting registration: " + ex.getMessage(), ex);
        }

        return null;
    }

    // Get a registration by ID
    public Registration getRegistrationById(int registrationId) {
        Registration registration = null;
        String query = "SELECT r.* FROM Registrations r WHERE r.RegistrationID = ?";

        LOGGER.log(Level.INFO, "Executing query to get registration by ID: {0}", registrationId);

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    registration = new Registration();
                    registration.setRegistrationId(rs.getInt("RegistrationID"));
                    registration.setUserId(rs.getInt("UserID"));
                    registration.setHouseholdId(rs.getInt("HouseholdID"));
                    registration.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                    registration.setSentDate(rs.getDate("SentDate"));
                    registration.setReason(rs.getString("Reason"));
                    registration.setRegistrationStatusId(rs.getInt("RegistrationStatusID"));
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting registration by ID: " + ex.getMessage(), ex);
        }
        return registration;
    }

    // Get registrations by user ID
    public List<Registration> getRegistrationsByUserId(int userId) {
        List<Registration> registrations = new ArrayList<>();
        String query = "SELECT r.* FROM Registrations r WHERE r.UserID = ? ORDER BY r.SentDate DESC";

        LOGGER.log(Level.INFO, "Executing query to get registrations for user: {0}", userId);

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    Registration registration = new Registration();
                    registration.setRegistrationId(rs.getInt("RegistrationID"));
                    registration.setUserId(rs.getInt("UserID"));
                    registration.setHouseholdId(rs.getInt("HouseholdID"));
                    registration.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                    registration.setSentDate(rs.getDate("SentDate"));
                    registration.setReason(rs.getString("Reason"));
                    registration.setRegistrationStatusId(rs.getInt("RegistrationStatusID"));

                    registrations.add(registration);
                }
                LOGGER.log(Level.INFO, "Found {0} registrations for user {1}", new Object[]{count, userId});
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting registrations for user " + userId + ": " + ex.getMessage(), ex);
        }
        return registrations;
    }

    // Get all pending registrations (for admin)
    public List<Registration> getPendingRegistrations() {
        List<Registration> registrations = new ArrayList<>();
        String query = "SELECT r.* FROM Registrations r WHERE r.RegistrationStatusID = 1 ORDER BY r.SentDate ASC";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Registration registration = new Registration();
                registration.setRegistrationId(rs.getInt("RegistrationID"));
                registration.setUserId(rs.getInt("UserID"));
                registration.setHouseholdId(rs.getInt("HouseholdID"));
                registration.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                registration.setSentDate(rs.getDate("SentDate"));
                registration.setReason(rs.getString("Reason"));
                registration.setRegistrationStatusId(rs.getInt("RegistrationStatusID"));

                registrations.add(registration);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting pending registrations: " + ex.getMessage(), ex);
        }
        return registrations;
    }

    // Update registration status
    public boolean updateRegistrationStatus(int registrationId, int statusId, String reason) {
        String query = "UPDATE Registrations SET RegistrationStatusID = ?, Reason = ? WHERE RegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, statusId);
            ps.setString(2, reason);
            ps.setInt(3, registrationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating registration status: " + ex.getMessage(), ex);
            return false;
        }
    }

    // Check if a registration exists
    public boolean checkRegistrationExists(int registrationId) {
        String query = "SELECT COUNT(*) FROM Registrations WHERE RegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking if registration exists: " + ex.getMessage(), ex);
        }
        return false;
    }

    // Delete a registration
    public boolean deleteRegistration(int registrationId) {
        String query = "DELETE FROM Registrations WHERE RegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting registration: " + ex.getMessage(), ex);
            return false;
        }
    }

    // Get all registrations
    public List<Registration> getAllRegistrations() {
        List<Registration> registrations = new ArrayList<>();
        String query = "SELECT r.* FROM Registrations r ORDER BY r.SentDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            int count = 0;
            while (rs.next()) {
                count++;
                Registration registration = new Registration();
                registration.setRegistrationId(rs.getInt("RegistrationID"));
                registration.setUserId(rs.getInt("UserID"));
                registration.setHouseholdId(rs.getInt("HouseholdID"));
                registration.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                registration.setSentDate(rs.getDate("SentDate"));
                registration.setReason(rs.getString("Reason"));
                registration.setRegistrationStatusId(rs.getInt("RegistrationStatusID"));

                registrations.add(registration);
            }
            LOGGER.log(Level.INFO, "Found {0} total registrations", count);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting all registrations: " + ex.getMessage(), ex);
        }
        return registrations;
    }

    // Get registrations by area (province, district, ward)
}
