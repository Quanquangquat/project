package dao.user;

import dao.AreaDAO;
import dao.DBContext;
import dao.HouseholdDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Area;
import model.Household;
import model.User;

public class UserDAO extends DBContext {

    // Get all users
//    public List<User> getAllUsers() {
//        List<User> userList = new ArrayList<>();
//        String query = "SELECT * FROM Users";
//
//        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                User user = new User();
//                user.setUserId(rs.getInt("UserID"));
//                user.setFullName(rs.getString("FullName"));
//                user.setEmail(rs.getString("Email"));
//                user.setPassword(rs.getString("Password"));
//                user.setRoleId(rs.getInt("RoleID"));
//                user.setAddress(rs.getString("Address"));
//                user.setCccd(rs.getString("CCCD"));
//
//                // Handle nullable HouseholdID
//                int householdId = rs.getInt("HouseholdID");
//                if (!rs.wasNull()) {
//                    user.setHouseholdId(householdId);
//                }
//
//                // Handle new fields
//                user.setGender(rs.getString("Gender"));
//                user.setPhoneNumber(rs.getString("PhoneNumber"));
//
//                userList.add(user);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching all users: " + ex.getMessage(), ex);
//        }
//        return userList;
//    }
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT u.UserID, u.FullName, u.Email, u.Password, u.RoleID, r.RoleName, u.Address, u.CCCD, u.HouseholdID, u.Gender, u.PhoneNumber "
                + "FROM Users u LEFT JOIN Roles r ON u.RoleID = r.RoleID";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setRole(rs.getString("RoleName") != null ? rs.getString("RoleName") : "Unknown"); // Đặt RoleName
                user.setAddress(rs.getString("Address"));
                user.setCccd(rs.getString("CCCD"));

                // Handle nullable HouseholdID
                int householdId = rs.getInt("HouseholdID");
                if (!rs.wasNull()) {
                    user.setHouseholdId(householdId);
                }

                // Handle new fields
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));

                userList.add(user);
            }
            Logger.getLogger(UserDAO.class.getName()).log(Level.INFO, "Fetched {0} users from database", userList.size());
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching all users: " + ex.getMessage(), ex);
        }
        return userList;
    }

    // Get user by ID
    public User getUserById(int userId) {
        String query = "SELECT u.UserID, u.FullName, u.Email, u.Password, u.RoleID, r.RoleName, "
                + "u.Address, u.CCCD, u.HouseholdID, u.Gender, u.PhoneNumber "
                + "FROM Users u LEFT JOIN Roles r ON u.RoleID = r.RoleID WHERE u.UserID = ?";
        User user = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setRole(rs.getString("RoleName"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));

                    // Handle nullable HouseholdID
                    int householdId = rs.getInt("HouseholdID");
                    if (!rs.wasNull()) {
                        user.setHouseholdId(householdId);
                    }

                    // Handle new fields
                    user.setGender(rs.getString("Gender"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching user by ID " + userId + ": " + ex.getMessage(), ex);
        }
        return user;
    }

    // Get user by CCCD
    public User getUserByCccd(String cccd) {
        String query = "SELECT * FROM Users WHERE CCCD = ?";
        User user = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, cccd);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));

                    // Handle nullable HouseholdID
                    int householdId = rs.getInt("HouseholdID");
                    if (!rs.wasNull()) {
                        user.setHouseholdId(householdId);
                    }

                    // Handle new fields
                    user.setGender(rs.getString("Gender"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching user by CCCD " + cccd + ": " + ex.getMessage(), ex);
        }
        return user;
    }

    // Get user by Email
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM Users WHERE Email = ?";
        User user = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));

                    // Handle nullable HouseholdID
                    int householdId = rs.getInt("HouseholdID");
                    if (!rs.wasNull()) {
                        user.setHouseholdId(householdId);
                    }

                    // Handle new fields
                    user.setGender(rs.getString("Gender"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching user by email " + email + ": " + ex.getMessage(), ex);
        }
        return user;
    }

    // Insert a new user and return the user with generated ID
    public User insertUser(User user) {
        String query = "INSERT INTO Users (FullName, Email, Password, RoleID, Address, CCCD, HouseholdID, Gender, PhoneNumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getCccd());

            // Handle nullable HouseholdID
            if (user.getHouseholdId() != null) {
                ps.setInt(7, user.getHouseholdId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }

            // Handle new fields
            ps.setString(8, user.getGender());
            ps.setString(9, user.getPhoneNumber());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1)); // Set the generated UserID
                    Logger.getLogger(UserDAO.class.getName()).log(Level.INFO, "Successfully inserted user with ID: " + user.getUserId());
                    return user;
                } else {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Insert succeeded but no generated key was returned.");
                }
            } else {
                Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Insert failed: No rows affected.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Failed to insert user: " + ex.getMessage() + ", SQL State: " + ex.getSQLState() + ", Error Code: " + ex.getErrorCode(), ex);
        }
        return null; // Return null if insert fails
    }

    // Update an existing user
    public boolean updateUser(User user) {
        String query = "UPDATE Users SET FullName = ?, Email = ?, Password = ?, RoleID = ?, Address = ?, CCCD = ?, HouseholdID = ?, Gender = ?, PhoneNumber = ? WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getCccd());

            // Handle nullable HouseholdID
            if (user.getHouseholdId() != null) {
                ps.setInt(7, user.getHouseholdId());
                Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                        "Setting HouseholdID to " + user.getHouseholdId() + " for user " + user.getUserId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
                Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                        "Setting HouseholdID to NULL for user " + user.getUserId());
            }

            // Handle new fields
            ps.setString(8, user.getGender());
            ps.setString(9, user.getPhoneNumber());

            ps.setInt(10, user.getUserId());

            int rowsAffected = ps.executeUpdate();
            boolean success = rowsAffected > 0;

            if (success) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                        "Successfully updated user " + user.getUserId() + " with HouseholdID " + user.getHouseholdId());
            } else {
                Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING,
                        "Failed to update user " + user.getUserId() + ". No rows affected.");
            }

            return success;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error updating user with ID " + user.getUserId() + ": " + ex.getMessage()
                    + ", SQL State: " + ex.getSQLState() + ", Error Code: " + ex.getErrorCode(), ex);
            return false;
        }
    }

    // Delete a user by ID
    public boolean deleteUser(int userId) {
        try {
            // Start transaction
            connection.setAutoCommit(false);

            try {
                // First, check if this user is a head of household
                String checkHeadQuery = "SELECT HouseholdID FROM Households WHERE HeadOfHouseholdID = ?";
                try (PreparedStatement checkPs = connection.prepareStatement(checkHeadQuery)) {
                    checkPs.setInt(1, userId);
                    ResultSet rs = checkPs.executeQuery();

                    if (rs.next()) {
                        // This user is a head of household
                        int householdId = rs.getInt("HouseholdID");

                        // Update other users in this household to have no household
                        String updateUsersQuery = "UPDATE Users SET HouseholdID = NULL WHERE HouseholdID = ? AND UserID != ?";
                        try (PreparedStatement updatePs = connection.prepareStatement(updateUsersQuery)) {
                            updatePs.setInt(1, householdId);
                            updatePs.setInt(2, userId);
                            updatePs.executeUpdate();
                        }

                        // Delete the household
                        String deleteHouseholdQuery = "DELETE FROM Households WHERE HouseholdID = ?";
                        try (PreparedStatement deleteHouseholdPs = connection.prepareStatement(deleteHouseholdQuery)) {
                            deleteHouseholdPs.setInt(1, householdId);
                            deleteHouseholdPs.executeUpdate();
                        }
                    }
                }

                // Finally, delete the user
                String deleteUserQuery = "DELETE FROM Users WHERE UserID = ?";
                try (PreparedStatement deleteUserPs = connection.prepareStatement(deleteUserQuery)) {
                    deleteUserPs.setInt(1, userId);
                    int rowsAffected = deleteUserPs.executeUpdate();

                    // Commit the transaction
                    connection.commit();

                    Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                            "Successfully deleted user " + userId);

                    return rowsAffected > 0;
                }
            } catch (SQLException ex) {
                // If there's an error, rollback the transaction
                connection.rollback();
                throw ex;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error deleting user with ID " + userId + ": " + ex.getMessage(), ex);
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                        "Error resetting auto-commit: " + ex.getMessage(), ex);
            }
        }
    }

    // Test the DAO
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();

        // Test getAllUsers
        boolean isExist = userDAO.isEmailExists("admin4@gmail.com");
        System.out.println(isExist);
    }

    public List<User> searchUsers(String cccd, String fullName, String email, String address) {
        List<User> userList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (cccd != null && !cccd.trim().isEmpty()) {
            query.append(" AND CCCD LIKE ?");
            params.add("%" + cccd + "%");
        }
        if (fullName != null && !fullName.trim().isEmpty()) {
            query.append(" AND FullName LIKE ?");
            params.add("%" + fullName + "%");
        }
        if (email != null && !email.trim().isEmpty()) {
            query.append(" AND Email LIKE ?");
            params.add("%" + email + "%");
        }
        if (address != null && !address.trim().isEmpty()) {
            query.append(" AND Address LIKE ?");
            params.add("%" + address + "%");
        }

        try (PreparedStatement ps = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));
                    userList.add(user);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error searching users: " + ex.getMessage(), ex);
        }
        return userList;
    }

    /**
     * Checks if an email already exists in the database
     *
     * @param email The email to check
     * @return true if the email exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }

    /**
     * Checks if a CCCD (Citizen ID) already exists in the database
     *
     * @param cccd The CCCD to check
     * @return true if the CCCD exists, false otherwise
     */
    public boolean isCCCDExists(String cccd) {
        String sql = "SELECT COUNT(*) FROM Users WHERE cccd = ?";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, cccd);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking CCCD existence: " + e.getMessage());
        }
        return false;
    }

    // Save the remember me token associated with the user in the database
    public void saveRememberMeToken(int userId, String token) {
        String sql = "UPDATE Users SET remember_me_token = ? WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token); // Set the token
            ps.setInt(2, userId);   // Set the user ID
            ps.executeUpdate();      // Execute the update statement
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error saving remember me token for user with ID " + userId + ": " + ex.getMessage(), ex);
        }
    }

    // Retrieve the user by the remember me token
    public User getUserByToken(String token) {
        String sql = "SELECT * FROM Users WHERE remember_me_token = ?";
        User user = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token); // Set the token to search for
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setAddress(rs.getString("Address"));
                    user.setCccd(rs.getString("CCCD"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error retrieving user by token: " + ex.getMessage(), ex);
        }
        return user; // Return the user if found, otherwise return null
    }

    public boolean updatePassword(int userId, String hashedPassword) {
        String query = "UPDATE Users SET Password = ? WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.INFO, "Successfully updated password for user with ID: " + userId);
                return true;
            } else {
                Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Password update failed for user with ID: " + userId + ". No rows affected.");
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error updating password for user with ID " + userId + ": " + ex.getMessage(), ex);
            return false;
        }
    }

    /**
     * Fix users without household IDs by creating households for them and
     * updating their records
     *
     * @return The number of users fixed
     */
    public int fixUsersWithoutHouseholds() {
        int fixedCount = 0;
        HouseholdDAO householdDao = new HouseholdDAO();
        AreaDAO areaDao = new AreaDAO();

        // Get all users without household IDs
        String query = "SELECT * FROM Users WHERE HouseholdID IS NULL";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            // Get the first area as default
            List<Area> allAreas = areaDao.getAllAreas();
            Area defaultArea = null;
            if (allAreas != null && !allAreas.isEmpty()) {
                defaultArea = allAreas.get(0);
                Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                        "Using default area with ID: " + defaultArea.getAreaId());
            }

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setAddress(rs.getString("Address"));
                user.setCccd(rs.getString("CCCD"));

                // Create a household for the user
                Household household = new Household();
                household.setHeadOfHouseholdId(user.getUserId());
                household.setAddress(user.getAddress());
                household.setCreatedDate(new Date());

                // Set the area ID if a default area was found
                if (defaultArea != null) {
                    household.setAreaId(defaultArea.getAreaId());
                }

                // Insert the household
                Household insertedHousehold = householdDao.insertHousehold(household);

                if (insertedHousehold != null) {
                    // Update the user with the household ID
                    user.setHouseholdId(insertedHousehold.getHouseholdId());
                    boolean updateSuccess = updateUser(user);

                    if (updateSuccess) {
                        fixedCount++;
                        Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                                "Fixed user " + user.getUserId() + " by linking to household " + insertedHousehold.getHouseholdId());
                    } else {
                        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                                "Failed to update user " + user.getUserId() + " with household ID " + insertedHousehold.getHouseholdId());
                    }
                } else {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                            "Failed to create household for user " + user.getUserId());
                }
            }

            Logger.getLogger(UserDAO.class.getName()).log(Level.INFO,
                    "Fixed " + fixedCount + " users without households");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE,
                    "Error fixing users without households: " + ex.getMessage(), ex);
        }

        return fixedCount;
    }

}
