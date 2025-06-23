package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Area;
import model.District;
import model.Province;
import model.Ward;

public class AreaDAO extends DBContext {
    
    private static final Logger LOGGER = Logger.getLogger(AreaDAO.class.getName());
    
    /**
     * Get all areas from the database
     * @return List of all areas
     */
    public List<Area> getAllAreas() {
        List<Area> areas = new ArrayList<>();
        String query = "SELECT * FROM Areas";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Area area = new Area();
                area.setAreaId(rs.getInt("AreaID"));
                area.setProvinceName(rs.getString("ProvinceName"));
                area.setDistrictName(rs.getString("DistrictName"));
                area.setWardName(rs.getString("WardName"));
                
                areas.add(area);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all areas: {0}", e.getMessage());
        }
        
        return areas;
    }
    
    /**
     * Get an area by its ID
     * @param areaId The ID of the area to retrieve
     * @return The area with the specified ID, or null if not found
     */
    public Area getAreaById(int areaId) {
        String query = "SELECT * FROM Areas WHERE AreaID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, areaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Area area = new Area();
                    area.setAreaId(rs.getInt("AreaID"));
                    area.setProvinceName(rs.getString("ProvinceName"));
                    area.setDistrictName(rs.getString("DistrictName"));
                    area.setWardName(rs.getString("WardName"));
                    
                    return area;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting area by ID {0}: {1}", new Object[]{areaId, e.getMessage()});
        }
        
        return null;
    }
    
    /**
     * Get an area by user ID (either area leader or police officer)
     * @param userId The ID of the user (area leader or police officer)
     * @return The area associated with the user, or null if not found
     */
    
    /**
     * Insert a new area into the database
     * @param area The area to insert
     * @return The inserted area with its generated ID, or null if insertion failed
     */
    public Area insertArea(Area area) {
        String query = "INSERT INTO Areas (ProvinceName, DistrictName, WardName) VALUES (?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, area.getProvinceName());
            ps.setString(2, area.getDistrictName());
            ps.setString(3, area.getWardName());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        area.setAreaId(rs.getInt(1));
                        return area;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting area: {0}", e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Update an existing area in the database
     * @param area The area to update
     * @return true if the update was successful, false otherwise
     */
    public boolean updateArea(Area area) {
        String query = "UPDATE Areas SET ProvinceName = ?, DistrictName = ?, WardName = ? WHERE AreaID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, area.getProvinceName());
            ps.setString(2, area.getDistrictName());
            ps.setString(3, area.getWardName());
            ps.setInt(4, area.getAreaId());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating area {0}: {1}", new Object[]{area.getAreaId(), e.getMessage()});
            return false;
        }
    }
    
    /**
     * Get or create an area based on province, district, and ward names
     * @param provinceName The province name
     * @param districtName The district name
     * @param wardName The ward name
     * @return The existing or newly created area
     */
    public Area getOrCreateArea(String provinceName, String districtName, String wardName) {
        // First, try to find an existing area with the same names
        String query = "SELECT * FROM Areas WHERE ProvinceName = ? AND DistrictName = ? AND WardName = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, provinceName);
            ps.setString(2, districtName);
            ps.setString(3, wardName);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Area area = new Area();
                    area.setAreaId(rs.getInt("AreaID"));
                    area.setProvinceName(rs.getString("ProvinceName"));
                    area.setDistrictName(rs.getString("DistrictName"));
                    area.setWardName(rs.getString("WardName"));
                    
                    return area;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding area by names: {0}", e.getMessage());
        }
        
        // If no existing area found, create a new one
        Area newArea = new Area();
        newArea.setProvinceName(provinceName);
        newArea.setDistrictName(districtName);
        newArea.setWardName(wardName);
        
        return insertArea(newArea);
    }
    
    /**
     * Load related objects (Province, District, Ward) for an area
     * @param area The area to load related objects for
     */
   
    /**
     * Delete an area by its ID
     * @param areaId The ID of the area to delete
     * @return true if the deletion was successful, false otherwise
     */
    public boolean deleteArea(int areaId) {
        String query = "DELETE FROM Areas WHERE AreaID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, areaId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting area {0}: {1}", new Object[]{areaId, e.getMessage()});
            return false;
        }
    }
    
    /**
     * Get areas by province name
     * @param provinceName The name of the province
     * @return List of areas in the specified province
     */
    public List<Area> getAreasByProvinceName(String provinceName) {
        List<Area> areas = new ArrayList<>();
        String query = "SELECT * FROM Areas WHERE ProvinceName = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, provinceName);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Area area = new Area();
                    area.setAreaId(rs.getInt("AreaID"));
                    area.setProvinceName(rs.getString("ProvinceName"));
                    area.setDistrictName(rs.getString("DistrictName"));
                    area.setWardName(rs.getString("WardName"));
                    
                    areas.add(area);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting areas by province name {0}: {1}", 
                    new Object[]{provinceName, e.getMessage()});
        }
        
        return areas;
    }
    
    /**
     * Get areas by district name
     * @param districtName The name of the district
     * @return List of areas in the specified district
     */
    public List<Area> getAreasByDistrictName(String districtName) {
        List<Area> areas = new ArrayList<>();
        String query = "SELECT * FROM Areas WHERE DistrictName = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, districtName);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Area area = new Area();
                    area.setAreaId(rs.getInt("AreaID"));
                    area.setProvinceName(rs.getString("ProvinceName"));
                    area.setDistrictName(rs.getString("DistrictName"));
                    area.setWardName(rs.getString("WardName"));
                    
                    areas.add(area);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting areas by district name {0}: {1}", 
                    new Object[]{districtName, e.getMessage()});
        }
        
        return areas;
    }
} 