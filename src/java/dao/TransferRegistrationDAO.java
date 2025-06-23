// src/java/dao/TransferRegistrationDAO.java
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.TransferRegistration;

public class TransferRegistrationDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(TransferRegistrationDAO.class.getName());

    public boolean insertTransferRegistration(TransferRegistration transfer) {
        String query = "INSERT INTO TransferRegistrations (RegistrationID, NewAddress, PreviousAddress, "
                + "ReasonForTransfer, MoveDate) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, transfer.getRegistrationId());
            ps.setString(2, transfer.getNewAddress());
            ps.setString(3, transfer.getPreviousAddress());
            ps.setString(4, transfer.getReasonForTransfer());
            ps.setDate(5, new java.sql.Date(transfer.getMoveDate().getTime()));

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        transfer.setTransferRegistrationId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting transfer registration: " + ex.getMessage(), ex);
            return false;
        }
    }

    public TransferRegistration getTransferRegistrationByRegistrationId(int registrationId) {
        String query = "SELECT * FROM TransferRegistrations WHERE RegistrationID = ?  ";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TransferRegistration transfer = new TransferRegistration();
                    transfer.setTransferRegistrationId(rs.getInt("TransferRegistrationID"));
                    transfer.setRegistrationId(rs.getInt("RegistrationID"));
                    transfer.setNewAddress(rs.getString("NewAddress"));
                    transfer.setPreviousAddress(rs.getString("PreviousAddress"));
                    transfer.setReasonForTransfer(rs.getString("ReasonForTransfer"));
                    transfer.setMoveDate(rs.getDate("MoveDate"));
                    return transfer;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting transfer registration: " + ex.getMessage(), ex);
        }
        return null;
    }

    public TransferRegistration getTransferRegistrationById(int transferRegistrationId) {
        String query = "SELECT * FROM TransferRegistrations WHERE TransferRegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, transferRegistrationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TransferRegistration transfer = new TransferRegistration();
                    transfer.setTransferRegistrationId(rs.getInt("TransferRegistrationID"));
                    transfer.setRegistrationId(rs.getInt("RegistrationID"));
                    transfer.setNewAddress(rs.getString("NewAddress"));
                    transfer.setPreviousAddress(rs.getString("PreviousAddress"));
                    transfer.setReasonForTransfer(rs.getString("ReasonForTransfer"));
                    transfer.setMoveDate(rs.getDate("MoveDate"));
                    return transfer;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting transfer registration by ID: " + ex.getMessage(), ex);
        }
        return null;
    }

    public List<TransferRegistration> getAllTransferRegistrations() {
        List<TransferRegistration> transfers = new ArrayList<>();
        String query = "SELECT * FROM TransferRegistrations";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TransferRegistration transfer = new TransferRegistration();
                transfer.setTransferRegistrationId(rs.getInt("TransferRegistrationID"));
                transfer.setRegistrationId(rs.getInt("RegistrationID"));
                transfer.setNewAddress(rs.getString("NewAddress"));
                transfer.setPreviousAddress(rs.getString("PreviousAddress"));
                transfer.setReasonForTransfer(rs.getString("ReasonForTransfer"));
                transfer.setMoveDate(rs.getDate("MoveDate"));
                transfers.add(transfer);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting all transfer registrations: " + ex.getMessage(), ex);
        }
        return transfers;
    }

    public boolean updateTransferRegistration(TransferRegistration transfer) {
        String query = "UPDATE TransferRegistrations SET NewAddress = ?, PreviousAddress = ?, "
                + "ReasonForTransfer = ?, MoveDate = ? WHERE TransferRegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, transfer.getNewAddress());
            ps.setString(2, transfer.getPreviousAddress());
            ps.setString(3, transfer.getReasonForTransfer());
            ps.setDate(4, new java.sql.Date(transfer.getMoveDate().getTime()));
            ps.setInt(5, transfer.getTransferRegistrationId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating transfer registration: " + ex.getMessage(), ex);
            return false;
        }
    }

    public boolean deleteTransferRegistration(int transferRegistrationId) {
        String query = "DELETE FROM TransferRegistrations WHERE TransferRegistrationID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, transferRegistrationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting transfer registration: " + ex.getMessage(), ex);
            return false;
        }
    }
}
