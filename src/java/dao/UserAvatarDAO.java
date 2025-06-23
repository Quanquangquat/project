package dao;

import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserAvatar;

/**
 * Data Access Object for user avatars
 */
public class UserAvatarDAO extends DBContext {

    private final String DEFAULT_AVATAR_URL = "https://static.vecteezy.com/system/resources/previews/021/548/095/original/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg";

    private static final Logger LOGGER = Logger.getLogger(UserAvatarDAO.class.getName());

    /**
     * Get the active avatar for a user
     *
     * @param userId The user ID
     * @return The active avatar, or null if none exists
     */
    public UserAvatar getActiveAvatarByUserId(int userId) {
        String query = "SELECT * FROM UserAvatars WHERE UserID = ? AND IsActive = 1";
        UserAvatar avatar = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            System.out.println("Executing query: " + query + " with userId: " + userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    avatar = mapResultSetToAvatar(rs);
                    System.out.println("Found avatar: " + avatar.getAvatarPath() + " for user ID: " + userId);
                } else {
                    System.out.println("No avatar found for user ID: " + userId);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching active avatar for user ID " + userId, ex);
            System.out.println("SQL Exception: " + ex.getMessage());
        }

        return avatar;
    }

    /**
     * Save a new avatar for a user
     *
     * @param avatar The avatar to save
     * @return The saved avatar with ID, or null if save failed
     */
    public UserAvatar saveAvatar(UserAvatar avatar) {
        // First, deactivate any existing active avatars for this user
        deactivateUserAvatars(avatar.getUserId());

        // Then insert the new avatar
        String query = "INSERT INTO UserAvatars (UserID, AvatarPath, UploadDate, IsActive) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, avatar.getUserId());
            ps.setString(2, avatar.getAvatarPath());
            ps.setTimestamp(3, new java.sql.Timestamp(avatar.getUploadDate().getTime()));
            ps.setBoolean(4, avatar.isIsActive());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    avatar.setAvatarId(rs.getInt(1));
                    LOGGER.log(Level.INFO, "Successfully inserted avatar with ID: " + avatar.getAvatarId());
                    return avatar;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error saving avatar for user ID " + avatar.getUserId(), ex);
        }

        return null;
    }

    /**
     * Deactivate all avatars for a user
     *
     * @param userId The user ID
     * @return True if successful, false otherwise
     */
    public boolean deactivateUserAvatars(int userId) {
        String query = "UPDATE UserAvatars SET IsActive = 0 WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            LOGGER.log(Level.INFO, "Deactivated " + rowsAffected + " avatars for user ID " + userId);
            return true;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deactivating avatars for user ID " + userId, ex);
            return false;
        }
    }

    /**
     * Delete an avatar by ID
     *
     * @param avatarId The avatar ID
     * @return True if successful, false otherwise
     */
    public boolean deleteAvatar(int avatarId) {
        String query = "DELETE FROM UserAvatars WHERE AvatarID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, avatarId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting avatar with ID " + avatarId, ex);
            return false;
        }
    }

    /**
     * Delete all avatars for a user
     *
     * @param userId The user ID
     * @return True if successful, false otherwise
     */
    public boolean deleteInActiveAvatarByUserId(int userId) {
        // First get the active avatar to potentially delete the file later
        UserAvatar activeAvatar = getActiveAvatarByUserId(userId);

        // Then delete all avatars for this user from the database
        String query = "DELETE FROM UserAvatars WHERE UserID = ? and IsActive = 0 ";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            LOGGER.log(Level.INFO, "Deleted " + rowsAffected + " avatars for user ID " + userId);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting avatars for user ID " + userId, ex);
            return false;
        }
    }

    private UserAvatar mapResultSetToAvatar(ResultSet rs) throws SQLException {
        UserAvatar avatar = new UserAvatar();
        avatar.setAvatarId(rs.getInt("AvatarID"));
        avatar.setUserId(rs.getInt("UserID"));
        avatar.setAvatarPath(rs.getString("AvatarPath"));
        avatar.setUploadDate(rs.getTimestamp("UploadDate"));
        avatar.setIsActive(rs.getBoolean("IsActive"));
        return avatar;
    }

    public static void main(String[] args) {
        UserAvatarDAO dao = new UserAvatarDAO();

        UserAvatar avatar = dao.getActiveAvatarByUserId(35);

        System.out.println(avatar);
    }

    public boolean deleteAvatarByUserId(int userId) {
        // First get the active avatar to potentially delete the file later
        UserAvatar activeAvatar = getActiveAvatarByUserId(userId);

        // Then delete all avatars for this user from the database
        String query = "DELETE FROM UserAvatars WHERE UserID = ? ";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            LOGGER.log(Level.INFO, "Deleted " + rowsAffected + " avatars for user ID " + userId);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting avatars for user ID " + userId, ex);
            return false;
        }
    }

    public String getOrSetDefaultAvatar(int userId) {

        UserAvatar avatar = getActiveAvatarByUserId(userId);

        // Set a flag indicating whether the user has an avatar
        boolean hasAvatar = avatar != null;

        String avatarPath = DEFAULT_AVATAR_URL;
        if (hasAvatar) {
            avatarPath = avatar.getAvatarPath();
        }

        return avatarPath;
    }

}
