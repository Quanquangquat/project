package dao;

import model.Notification;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Statement;

public class NotificationDAO extends DBContext {

    // Get all notifications
    public List<Notification> getAllNotifications() {
        List<Notification> notificationList = new ArrayList<>();
        String query = "SELECT * FROM Notifications";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Notification notif = new Notification();
                notif.setNotificationId(rs.getInt("NotificationID"));

                // Handle nullable UserID
                int userId = rs.getInt("UserID");
                notif.setUserId(rs.wasNull() ? null : userId);

                notif.setMessage(rs.getString("Message"));
                notif.setSentDate(rs.getTimestamp("SentDate"));
                notif.setRead(rs.getBoolean("IsRead"));
                notificationList.add(notif);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return notificationList;
    }

    // Get notification by ID
    public Notification getNotificationById(int notificationId) {
        String query = "SELECT * FROM Notifications WHERE NotificationID = ?";
        Notification notif = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, notificationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    notif = new Notification();
                    notif.setNotificationId(rs.getInt("NotificationID"));

                    // Handle nullable UserID
                    int userId = rs.getInt("UserID");
                    notif.setUserId(rs.wasNull() ? null : userId);

                    notif.setMessage(rs.getString("Message"));
                    notif.setSentDate(rs.getTimestamp("SentDate"));
                    notif.setRead(rs.getBoolean("IsRead"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return notif;
    }

    // Insert a new notification
    public Notification insertNotification(Notification notif) {
        String query = "INSERT INTO Notifications (UserID, Message, SentDate, IsRead) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            setNullableInt(ps, 1, notif.getUserId());
            ps.setString(2, notif.getMessage());
            ps.setTimestamp(3, new java.sql.Timestamp(notif.getSentDate().getTime()));
            ps.setBoolean(4, notif.isRead());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    notif.setNotificationId(rs.getInt(1));
                    return notif;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Update an existing notification
    public boolean updateNotification(Notification notif) {
        String query = "UPDATE Notifications SET UserID = ?, Message = ?, SentDate = ?, IsRead = ? WHERE NotificationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            setNullableInt(ps, 1, notif.getUserId());
            ps.setString(2, notif.getMessage());
            ps.setTimestamp(3, new java.sql.Timestamp(notif.getSentDate().getTime()));
            ps.setBoolean(4, notif.isRead());
            ps.setInt(5, notif.getNotificationId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // Delete a notification by ID
    public boolean deleteNotification(int notificationId) {
        String query = "DELETE FROM Notifications WHERE NotificationID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, notificationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // Helper method to set nullable Integer
    private void setNullableInt(PreparedStatement ps, int parameterIndex, Integer value) throws SQLException {
        if (value != null) {
            ps.setInt(parameterIndex, value);
        } else {
            ps.setNull(parameterIndex, java.sql.Types.INTEGER);
        }
    }

    public static void main(String[] args) {
        NotificationDAO notifDAO = new NotificationDAO();
        List<Notification> notifications = notifDAO.getAllNotifications();
        System.out.println("All Notifications:");
        for (Notification notif : notifications) {
            System.out.println(notif);
        }
    }
}
