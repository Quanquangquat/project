package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AddMemberRegistration;

public class AddMemberRegistrationDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(AddMemberRegistrationDAO.class.getName());
    
    public boolean insertAddMemberRegistration(AddMemberRegistration addMember) {
        String query = "INSERT INTO AddMemberRegistrations (RegistrationID, FullName, DateOfBirth, " +
                "Gender, IdNumber, PhoneNumber, Relationship, ReasonForAddition, " +
                "PreviousHouseholdID, HeadOfHouseholdConsent) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, addMember.getRegistrationId());
            ps.setString(2, addMember.getFullName());
            
            if (addMember.getDateOfBirth() != null) {
                ps.setDate(3, new java.sql.Date(addMember.getDateOfBirth().getTime()));
            } else {
                ps.setNull(3, java.sql.Types.DATE);
            }
            
            ps.setString(4, addMember.getGender());
            ps.setString(5, addMember.getIdNumber());
            ps.setString(6, addMember.getPhoneNumber());
            ps.setString(7, addMember.getRelationship());
            ps.setString(8, addMember.getReasonForAddition());
            
            if (addMember.getPreviousHouseholdId() != null) {
                ps.setInt(9, addMember.getPreviousHouseholdId());
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);
            }
            
            ps.setBoolean(10, addMember.isHeadOfHouseholdConsent());
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        addMember.setAddMemberRegistrationId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting add member registration: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    public AddMemberRegistration getAddMemberRegistrationByRegistrationId(int registrationId) {
        String query = "SELECT * FROM AddMemberRegistrations WHERE RegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    AddMemberRegistration addMember = new AddMemberRegistration();
                    addMember.setAddMemberRegistrationId(rs.getInt("AddMemberRegistrationID"));
                    addMember.setRegistrationId(rs.getInt("RegistrationID"));
                    addMember.setFullName(rs.getString("FullName"));
                    addMember.setDateOfBirth(rs.getDate("DateOfBirth"));
                    addMember.setGender(rs.getString("Gender"));
                    addMember.setIdNumber(rs.getString("IdNumber"));
                    addMember.setPhoneNumber(rs.getString("PhoneNumber"));
                    addMember.setRelationship(rs.getString("Relationship"));
                    addMember.setReasonForAddition(rs.getString("ReasonForAddition"));
                    
                    // Handle nullable PreviousHouseholdID
                    int previousHouseholdId = rs.getInt("PreviousHouseholdID");
                    if (!rs.wasNull()) {
                        addMember.setPreviousHouseholdId(previousHouseholdId);
                    }
                    
                    addMember.setHeadOfHouseholdConsent(rs.getBoolean("HeadOfHouseholdConsent"));
                    return addMember;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting add member registration: " + ex.getMessage(), ex);
        }
        return null;
    }
    
    public AddMemberRegistration getAddMemberRegistrationById(int addMemberRegistrationId) {
        String query = "SELECT * FROM AddMemberRegistrations WHERE AddMemberRegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, addMemberRegistrationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    AddMemberRegistration addMember = new AddMemberRegistration();
                    addMember.setAddMemberRegistrationId(rs.getInt("AddMemberRegistrationID"));
                    addMember.setRegistrationId(rs.getInt("RegistrationID"));
                    addMember.setFullName(rs.getString("FullName"));
                    addMember.setDateOfBirth(rs.getDate("DateOfBirth"));
                    addMember.setGender(rs.getString("Gender"));
                    addMember.setIdNumber(rs.getString("IdNumber"));
                    addMember.setPhoneNumber(rs.getString("PhoneNumber"));
                    addMember.setRelationship(rs.getString("Relationship"));
                    addMember.setReasonForAddition(rs.getString("ReasonForAddition"));
                    
                    // Handle nullable PreviousHouseholdID
                    int previousHouseholdId = rs.getInt("PreviousHouseholdID");
                    if (!rs.wasNull()) {
                        addMember.setPreviousHouseholdId(previousHouseholdId);
                    }
                    
                    addMember.setHeadOfHouseholdConsent(rs.getBoolean("HeadOfHouseholdConsent"));
                    return addMember;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting add member registration by ID: " + ex.getMessage(), ex);
        }
        return null;
    }
    
    public List<AddMemberRegistration> getAllAddMemberRegistrations() {
        List<AddMemberRegistration> addMembers = new ArrayList<>();
        String query = "SELECT * FROM AddMemberRegistrations";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                AddMemberRegistration addMember = new AddMemberRegistration();
                addMember.setAddMemberRegistrationId(rs.getInt("AddMemberRegistrationID"));
                addMember.setRegistrationId(rs.getInt("RegistrationID"));
                addMember.setFullName(rs.getString("FullName"));
                addMember.setDateOfBirth(rs.getDate("DateOfBirth"));
                addMember.setGender(rs.getString("Gender"));
                addMember.setIdNumber(rs.getString("IdNumber"));
                addMember.setPhoneNumber(rs.getString("PhoneNumber"));
                addMember.setRelationship(rs.getString("Relationship"));
                addMember.setReasonForAddition(rs.getString("ReasonForAddition"));
                
                // Handle nullable PreviousHouseholdID
                int previousHouseholdId = rs.getInt("PreviousHouseholdID");
                if (!rs.wasNull()) {
                    addMember.setPreviousHouseholdId(previousHouseholdId);
                }
                
                addMember.setHeadOfHouseholdConsent(rs.getBoolean("HeadOfHouseholdConsent"));
                addMembers.add(addMember);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting all add member registrations: " + ex.getMessage(), ex);
        }
        return addMembers;
    }
    
    public boolean updateAddMemberRegistration(AddMemberRegistration addMember) {
        String query = "UPDATE AddMemberRegistrations SET FullName = ?, DateOfBirth = ?, " +
                "Gender = ?, IdNumber = ?, PhoneNumber = ?, Relationship = ?, " +
                "ReasonForAddition = ?, PreviousHouseholdID = ?, HeadOfHouseholdConsent = ? " +
                "WHERE AddMemberRegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, addMember.getFullName());
            
            if (addMember.getDateOfBirth() != null) {
                ps.setDate(2, new java.sql.Date(addMember.getDateOfBirth().getTime()));
            } else {
                ps.setNull(2, java.sql.Types.DATE);
            }
            
            ps.setString(3, addMember.getGender());
            ps.setString(4, addMember.getIdNumber());
            ps.setString(5, addMember.getPhoneNumber());
            ps.setString(6, addMember.getRelationship());
            ps.setString(7, addMember.getReasonForAddition());
            
            if (addMember.getPreviousHouseholdId() != null) {
                ps.setInt(8, addMember.getPreviousHouseholdId());
            } else {
                ps.setNull(8, java.sql.Types.INTEGER);
            }
            
            ps.setBoolean(9, addMember.isHeadOfHouseholdConsent());
            ps.setInt(10, addMember.getAddMemberRegistrationId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating add member registration: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    public boolean deleteAddMemberRegistration(int addMemberRegistrationId) {
        String query = "DELETE FROM AddMemberRegistrations WHERE AddMemberRegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, addMemberRegistrationId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting add member registration: " + ex.getMessage(), ex);
            return false;
        }
    }
} 