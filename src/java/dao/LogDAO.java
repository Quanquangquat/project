package dao;

import model.Log;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Statement;

public class LogDAO extends DBContext {

    // Get all logs
    public List<Log> getAllLogs() {
        List<Log> logList = new ArrayList<>();
        String query = "SELECT * FROM Logs";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Log log = new Log();
                log.setLogId(rs.getInt("LogID"));

                int userId = rs.getInt("UserID");
                log.setUserId(rs.wasNull() ? null : userId);

                log.setAction(rs.getString("Action"));
                log.setTimestamp(rs.getTimestamp("Timestamp"));
                logList.add(log);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return logList;
    }

    // Get log by ID
    public Log getLogById(int logId) {
        String query = "SELECT * FROM Logs WHERE LogID = ?";
        Log log = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, logId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    log = new Log();
                    log.setLogId(rs.getInt("LogID"));

                    int userId = rs.getInt("UserID");
                    log.setUserId(rs.wasNull() ? null : userId);

                    log.setAction(rs.getString("Action"));
                    log.setTimestamp(rs.getTimestamp("Timestamp"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return log;
    }

    // Insert a new log
    public Log insertLog(Log log) {
        String query = "INSERT INTO Logs (UserID, Action, Timestamp) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            setNullableInt(ps, 1, log.getUserId());
            ps.setString(2, log.getAction());
            ps.setTimestamp(3, new java.sql.Timestamp(log.getTimestamp().getTime()));

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    log.setLogId(rs.getInt(1));
                    return log;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Update an existing log
    public boolean updateLog(Log log) {
        String query = "UPDATE Logs SET UserID = ?, Action = ?, Timestamp = ? WHERE LogID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            setNullableInt(ps, 1, log.getUserId());
            ps.setString(2, log.getAction());
            ps.setTimestamp(3, new java.sql.Timestamp(log.getTimestamp().getTime()));
            ps.setInt(4, log.getLogId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(LogDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // Delete a log by ID
    public boolean deleteLog(int logId) {
        String query = "DELETE FROM Logs WHERE LogID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, logId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(LogDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        LogDAO logDAO = new LogDAO();
        List<Log> logs = logDAO.getAllLogs();
        System.out.println("All Logs:");
        for (Log log : logs) {
            System.out.println(log);
        }
    }
}
