package dao;

import model.Household;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import model.User;
import model.HouseholdMember;

public class HouseholdDAO extends DBContext {
   

    private static final Logger LOGGER = Logger.getLogger(HouseholdDAO.class.getName());

    public List<Household> getAllHouseholds() {
        List<Household> householdList = new ArrayList<>();
        String query = "SELECT h.HouseholdID, h.HeadOfHouseholdID, h.Address, h.CreatedDate, h.AreaID, u.FullName AS HeadName "
                + "FROM Households h LEFT JOIN Users u ON h.HeadOfHouseholdID = u.UserID";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Household household = new Household();
                household.setHouseholdId(rs.getInt("HouseholdID"));

                int headOfHouseholdId = rs.getInt("HeadOfHouseholdID");
                if (rs.wasNull()) {
                    household.setHeadOfHouseholdId(null);
                } else {
                    household.setHeadOfHouseholdId(headOfHouseholdId);
                }

                household.setAddress(rs.getString("Address"));
                household.setCreatedDate(rs.getTimestamp("CreatedDate"));
                household.setHeadName(rs.getString("HeadName"));

                int areaId = rs.getInt("AreaID");
                if (rs.wasNull()) {
                    household.setAreaId(null);
                } else {
                    household.setAreaId(areaId);
                }

                householdList.add(household);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching all households: " + ex.getMessage(), ex);
        }
        return householdList;
    }

    public Household getHouseholdById(int householdId) {
        String query = "SELECT h.HouseholdID, h.HeadOfHouseholdID, h.Address, h.CreatedDate, h.AreaID, u.FullName AS HeadName "
                + "FROM Households h LEFT JOIN Users u ON h.HeadOfHouseholdID = u.UserID "
                + "WHERE h.HouseholdID = ?";
        Household household = null;
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, householdId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    household = new Household();
                    household.setHouseholdId(rs.getInt("HouseholdID"));

                    int headOfHouseholdId = rs.getInt("HeadOfHouseholdID");
                    if (rs.wasNull()) {
                        household.setHeadOfHouseholdId(null);
                    } else {
                        household.setHeadOfHouseholdId(headOfHouseholdId);
                    }

                    household.setAddress(rs.getString("Address"));
                    household.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    household.setHeadName(rs.getString("HeadName"));

                    int areaId = rs.getInt("AreaID");
                    if (rs.wasNull()) {
                        household.setAreaId(null);
                    } else {
                        household.setAreaId(areaId);
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching household with ID " + householdId + ": " + ex.getMessage(), ex);
        }
        return household;
    }

    public Household insertHousehold(Household household) {
        String query = "INSERT INTO Households (HeadOfHouseholdID, Address, CreatedDate, AreaID) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            if (household.getHeadOfHouseholdId() != null) {
                ps.setInt(1, household.getHeadOfHouseholdId());
                LOGGER.log(Level.INFO,
                        "Setting HeadOfHouseholdID to " + household.getHeadOfHouseholdId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
                LOGGER.log(Level.INFO,
                        "Setting HeadOfHouseholdID to NULL");
            }
            ps.setString(2, household.getAddress());
            ps.setTimestamp(3, new Timestamp(household.getCreatedDate().getTime()));

            if (household.getAreaId() != null) {
                ps.setInt(4, household.getAreaId());
                LOGGER.log(Level.INFO,
                        "Setting AreaID to " + household.getAreaId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
                LOGGER.log(Level.INFO,
                        "Setting AreaID to NULL");
            }

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int generatedId = rs.getInt(1);
                    household.setHouseholdId(generatedId);
                    LOGGER.log(Level.INFO,
                            "Successfully inserted household with ID: " + generatedId);
                    return household;
                } else {
                    LOGGER.log(Level.WARNING,
                            "Insert succeeded but no generated key was returned.");
                }
            } else {
                LOGGER.log(Level.WARNING,
                        "Insert failed: No rows affected.");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE,
                    "Failed to insert household: " + ex.getMessage()
                    + ", SQL State: " + ex.getSQLState() + ", Error Code: " + ex.getErrorCode(), ex);
        }
        return null;
    }

    public boolean updateHousehold(Household household) {
        String query = "UPDATE Households SET HeadOfHouseholdID = ?, Address = ?, CreatedDate = ?, AreaID = ? WHERE HouseholdID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            if (household.getHeadOfHouseholdId() != null) {
                ps.setInt(1, household.getHeadOfHouseholdId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, household.getAddress());
            ps.setTimestamp(3, new Timestamp(household.getCreatedDate().getTime()));

            if (household.getAreaId() != null) {
                ps.setInt(4, household.getAreaId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }

            ps.setInt(5, household.getHouseholdId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating household with ID " + household.getHouseholdId() + ": " + ex.getMessage(), ex);
            return false;
        }
    }

    public boolean deleteHousehold(int householdId) {
        // First, get all users in this household
        String getUsersQuery = "SELECT UserID FROM Users WHERE HouseholdID = ?";
        // Then, update these users to set their HouseholdID to NULL
        String updateUsersQuery = "UPDATE Users SET HouseholdID = NULL WHERE HouseholdID = ?";
        // Finally, delete the household
        String deleteHouseholdQuery = "DELETE FROM Households WHERE HouseholdID = ?";

        try {
            // Start transaction
            connection.setAutoCommit(false);

            try {
                // First update all users in this household
                try (PreparedStatement updatePs = connection.prepareStatement(updateUsersQuery)) {
                    updatePs.setInt(1, householdId);
                    updatePs.executeUpdate();
                    LOGGER.log(Level.INFO,
                            "Updated users for household " + householdId);
                }

                // Then delete the household
                try (PreparedStatement deletePs = connection.prepareStatement(deleteHouseholdQuery)) {
                    deletePs.setInt(1, householdId);
                    int rowsAffected = deletePs.executeUpdate();

                    // Commit the transaction
                    connection.commit();

                    LOGGER.log(Level.INFO,
                            "Successfully deleted household " + householdId);

                    return rowsAffected > 0;
                }
            } catch (SQLException ex) {
                // If there's an error, rollback the transaction
                connection.rollback();
                throw ex;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE,
                    "Error deleting household with ID " + householdId + ": " + ex.getMessage(), ex);
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE,
                        "Error resetting auto-commit: " + ex.getMessage(), ex);
            }
        }
    }

    public List<User> getHouseholdMembers(Integer householdId) {
        List<User> members = new ArrayList<>();
        String sql = "SELECT u.* FROM Users u "
                + "JOIN HouseholdMembers hm ON u.UserID = hm.UserID "
                + "WHERE hm.HouseholdID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, householdId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setGender(rs.getString("Gender"));
                    user.setHouseholdId(rs.getInt("HouseholdID"));
                    user.setRoleId(1);
                    members.add(user);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE,
                    "Error fetching members for household " + householdId + ": " + ex.getMessage(), ex);
        }

        return members;
    }

    public List<HouseholdMember> getHouseholdMembersAsMembers(Integer householdId) {
        List<HouseholdMember> members = new ArrayList<>();
        String sql = "SELECT hm.* FROM HouseholdMembers hm WHERE hm.HouseholdID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, householdId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    HouseholdMember member = new HouseholdMember();
                    member.setMemberId(rs.getInt("MemberID"));
                    member.setHouseholdId(rs.getInt("HouseholdID"));
                    member.setFullName(rs.getString("FullName"));
                    member.setRelationship(rs.getString("Relationship"));
                    member.setDateOfBirth(rs.getDate("DateOfBirth"));
                    member.setGender(rs.getString("Gender"));
                    member.setPhoneNumber(rs.getString("PhoneNumber"));
                    member.setEmail(rs.getString("Email"));
                    member.setCccd(rs.getString("CCCD"));
                    member.setCreatedDate(rs.getDate("CreatedDate"));
                    members.add(member);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE,
                    "Error fetching household members for household " + householdId + ": " + ex.getMessage(), ex);
        }

        return members;
    }

    /**
     * Get the total number of households in the system
     * 
     * @return The total number of households
     */
    public int getTotalHouseholds() {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT COUNT(*) AS count FROM Households";
            stmt = conn.prepareStatement(sql);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting total households: " + e.getMessage(), e);
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return count;
    }
    
    /**
     * Get the count of households in a specific area
     * 
     * @param areaId The ID of the area to count households for
     * @return The count of households in the specified area
     */
    public int getHouseholdCountByAreaId(int areaId) {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT COUNT(*) AS count FROM Households WHERE AreaID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, areaId);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
            
            LOGGER.log(Level.INFO, "Found {0} households in area {1}", new Object[]{count, areaId});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting household count by area ID: " + e.getMessage(), e);
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return count;
    }

    /**
     * Get households by area ID
     * 
     * @param areaId The area ID to filter by
     * @return List of households in the specified area
     */
    public List<Household> getHouseholdsByAreaId(int areaId) {
        List<Household> households = new ArrayList<>();
        String query = "SELECT h.HouseholdID, h.HeadOfHouseholdID, h.Address, h.CreatedDate, h.AreaID, u.FullName AS HeadName "
                + "FROM Households h LEFT JOIN Users u ON h.HeadOfHouseholdID = u.UserID "
                + "WHERE h.AreaID = ?";
        
        LOGGER.log(Level.INFO, "Executing query to get households for area: {0}", areaId);
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, areaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    Household household = new Household();
                    household.setHouseholdId(rs.getInt("HouseholdID"));
                    
                    int headOfHouseholdId = rs.getInt("HeadOfHouseholdID");
                    if (rs.wasNull()) {
                        household.setHeadOfHouseholdId(null);
                    } else {
                        household.setHeadOfHouseholdId(headOfHouseholdId);
                    }
                    
                    household.setAddress(rs.getString("Address"));
                    household.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    household.setHeadName(rs.getString("HeadName"));
                    
                    int areaIdFromDb = rs.getInt("AreaID");
                    if (rs.wasNull()) {
                        household.setAreaId(null);
                    } else {
                        household.setAreaId(areaIdFromDb);
                    }
                    
                    households.add(household);
                }
                LOGGER.log(Level.INFO, "Found {0} households for area {1}", new Object[]{count, areaId});
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting households for area " + areaId + ": " + ex.getMessage(), ex);
        }
        return households;
    }
}
