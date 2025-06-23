package dao;

import model.RegistrationType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationTypeDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(RegistrationTypeDAO.class.getName());

    // Get all registration types
    public List<RegistrationType> getAllRegistrationTypes() {
        List<RegistrationType> types = new ArrayList<>();
        String query = "SELECT * FROM RegistrationTypes ORDER BY RegistrationTypeID";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                RegistrationType type = new RegistrationType();
                type.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                type.setTypeName(rs.getString("TypeName"));
                type.setDescription(rs.getString("Description"));
                types.add(type);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting registration types: " + ex.getMessage(), ex);
        }
        return types;
    }
    
    // Get registration type by ID
    public RegistrationType getRegistrationTypeById(int typeId) {
        String query = "SELECT * FROM RegistrationTypes WHERE RegistrationTypeID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, typeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    RegistrationType type = new RegistrationType();
                    type.setRegistrationTypeId(rs.getInt("RegistrationTypeID"));
                    type.setTypeName(rs.getString("TypeName"));
                    type.setDescription(rs.getString("Description"));
                    return type;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting registration type " + typeId + ": " + ex.getMessage(), ex);
        }
        return null;
    }
    
    // Insert a new registration type
    public boolean insertRegistrationType(RegistrationType type) {
        String query = "INSERT INTO RegistrationTypes (TypeName, Description) VALUES (?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, type.getTypeName());
            ps.setString(2, type.getDescription());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting registration type: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    // Update an existing registration type
    public boolean updateRegistrationType(RegistrationType type) {
        String query = "UPDATE RegistrationTypes SET TypeName = ?, Description = ? WHERE RegistrationTypeID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, type.getTypeName());
            ps.setString(2, type.getDescription());
            ps.setInt(3, type.getRegistrationTypeId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating registration type: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    // Delete a registration type
    public boolean deleteRegistrationType(int typeId) {
        String query = "DELETE FROM RegistrationTypes WHERE RegistrationTypeID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, typeId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting registration type: " + ex.getMessage(), ex);
            return false;
        }
    }

    public static void main(String[] args) {
        RegistrationTypeDAO typeDAO = new RegistrationTypeDAO();
        List<RegistrationType> types = typeDAO.getAllRegistrationTypes();
        System.out.println("All Registration Types:");
        for (RegistrationType type : types) {
            System.out.println(type);
        }
    }
}
