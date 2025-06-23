package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.HouseholdTransfer;

/**
 * Data Access Object for HouseholdTransfer
 */
public class HouseholdTransferDAO extends DBContext {
    
    /**
     * Create a new household transfer request
     * @param transfer The transfer request to create
     * @return The created transfer request with ID set
     */
    public HouseholdTransfer createTransferRequest(HouseholdTransfer transfer) {
        String query = "INSERT INTO HouseholdTransfers (UserID, CurrentAddress, DestinationAddress, " +
                      "DestinationAreaID, Reason, Status, RequestDate) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, transfer.getUserId());
            ps.setString(2, transfer.getCurrentAddress());
            ps.setString(3, transfer.getDestinationAddress());
            ps.setInt(4, transfer.getDestinationAreaId());
            ps.setString(5, transfer.getReason());
            ps.setString(6, transfer.getStatus());
            ps.setTimestamp(7, new Timestamp(transfer.getRequestDate().getTime()));
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    transfer.setTransferId(rs.getInt(1));
                    return transfer;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error creating transfer request: " + ex.getMessage(), ex);
        }
        
        return null;
    }
    
    /**
     * Get all transfer requests for a specific user
     * @param userId The user ID
     * @return List of transfer requests
     */
    public List<HouseholdTransfer> getTransferRequestsByUserId(int userId) {
        List<HouseholdTransfer> transfers = new ArrayList<>();
        String query = "SELECT * FROM HouseholdTransfers WHERE UserID = ? ORDER BY RequestDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HouseholdTransfer transfer = mapResultSetToTransfer(rs);
                    transfers.add(transfer);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error getting transfer requests for user " + userId + ": " + ex.getMessage(), ex);
        }
        
        return transfers;
    }
    
    /**
     * Get all transfer requests for a specific area (for area leaders)
     * @param areaId The area ID
     * @return List of transfer requests
     */
    public List<HouseholdTransfer> getTransferRequestsByAreaId(int areaId) {
        List<HouseholdTransfer> transfers = new ArrayList<>();
        String query = "SELECT ht.* FROM HouseholdTransfers ht " +
                      "JOIN Users u ON ht.UserID = u.UserID " +
                      "JOIN Households h ON u.HouseholdID = h.HouseholdID " +
                      "WHERE h.AreaID = ? ORDER BY ht.RequestDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, areaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HouseholdTransfer transfer = mapResultSetToTransfer(rs);
                    transfers.add(transfer);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error getting transfer requests for area " + areaId + ": " + ex.getMessage(), ex);
        }
        
        return transfers;
    }
    
    /**
     * Get all pending transfer requests for a specific area (for police officers)
     * @param areaId The area ID
     * @return List of pending transfer requests
     */
    public List<HouseholdTransfer> getPendingTransferRequestsByAreaId(int areaId) {
        List<HouseholdTransfer> transfers = new ArrayList<>();
        String query = "SELECT ht.* FROM HouseholdTransfers ht " +
                      "JOIN Users u ON ht.UserID = u.UserID " +
                      "JOIN Households h ON u.HouseholdID = h.HouseholdID " +
                      "WHERE h.AreaID = ? AND ht.Status = 'Approved by Area Leader' " +
                      "ORDER BY ht.RequestDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, areaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HouseholdTransfer transfer = mapResultSetToTransfer(rs);
                    transfers.add(transfer);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error getting pending transfer requests for area " + areaId + ": " + ex.getMessage(), ex);
        }
        
        return transfers;
    }
    
    /**
     * Get a transfer request by ID
     * @param transferId The transfer ID
     * @return The transfer request
     */
    public HouseholdTransfer getTransferRequestById(int transferId) {
        String query = "SELECT * FROM HouseholdTransfers WHERE TransferID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, transferId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTransfer(rs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error getting transfer request with ID " + transferId + ": " + ex.getMessage(), ex);
        }
        
        return null;
    }
    
    /**
     * Update the status of a transfer request (for area leaders)
     * @param transferId The transfer ID
     * @param status The new status
     * @param notes Notes from the area leader
     * @return true if successful, false otherwise
     */
    public boolean updateTransferRequestByAreaLeader(int transferId, String status, String notes) {
        String query = "UPDATE HouseholdTransfers SET Status = ?, AreaLeaderNotes = ? WHERE TransferID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, transferId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error updating transfer request status by area leader: " + ex.getMessage(), ex);
        }
        
        return false;
    }
    
    /**
     * Update the status of a transfer request (for police officers)
     * @param transferId The transfer ID
     * @param status The new status
     * @param notes Notes from the police officer
     * @param approvalDate The approval date
     * @return true if successful, false otherwise
     */
    public boolean updateTransferRequestByPolice(int transferId, String status, String notes, java.util.Date approvalDate) {
        String query = "UPDATE HouseholdTransfers SET Status = ?, PoliceNotes = ?, ApprovalDate = ? WHERE TransferID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setTimestamp(3, new Timestamp(approvalDate.getTime()));
            ps.setInt(4, transferId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(HouseholdTransferDAO.class.getName()).log(Level.SEVERE, 
                    "Error updating transfer request status by police: " + ex.getMessage(), ex);
        }
        
        return false;
    }
    
    /**
     * Helper method to map a ResultSet to a HouseholdTransfer object
     * @param rs The ResultSet
     * @return The HouseholdTransfer object
     * @throws SQLException If an error occurs
     */
    private HouseholdTransfer mapResultSetToTransfer(ResultSet rs) throws SQLException {
        HouseholdTransfer transfer = new HouseholdTransfer();
        transfer.setTransferId(rs.getInt("TransferID"));
        transfer.setUserId(rs.getInt("UserID"));
        transfer.setCurrentAddress(rs.getString("CurrentAddress"));
        transfer.setDestinationAddress(rs.getString("DestinationAddress"));
        transfer.setDestinationAreaId(rs.getInt("DestinationAreaID"));
        transfer.setReason(rs.getString("Reason"));
        transfer.setStatus(rs.getString("Status"));
        transfer.setRequestDate(rs.getTimestamp("RequestDate"));
        
        Timestamp approvalDate = rs.getTimestamp("ApprovalDate");
        if (approvalDate != null) {
            transfer.setApprovalDate(approvalDate);
        }
        
        transfer.setAreaLeaderNotes(rs.getString("AreaLeaderNotes"));
        transfer.setPoliceNotes(rs.getString("PoliceNotes"));
        
        return transfer;
    }
} 