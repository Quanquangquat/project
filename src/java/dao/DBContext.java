package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author FPT University - PRJ30X
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        //@Students: You are allowed to edit user, pass, url variables to fit
        //your system configuration
        //You can also add more methods for Database Interaction tasks.
        //But we recommend you to do it in another class
        // For example : StudentDBContext extends DBContext ,
        //where StudentDBContext is located in dal package,
        try {
            // Load the JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Database credentials
            String url = "jdbc:sqlserver://localhost:1433;databaseName=HouseholdManagement;encrypt=true;trustServerCertificate=true";
            String username = "sa";
            String password = "123";
            
            // Establish connection
            this.connection = DriverManager.getConnection(url, username, password);
            System.out.println("DBContext: Database connection established successfully");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("DBContext ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Get the current database connection
     * @return The database connection
     */
    public Connection getConnection() {
        try {
            // If connection is closed or null, create a new one
            if (connection == null || connection.isClosed()) {
                System.out.println("DBContext: Connection is null or closed, creating new connection");
                // Database credentials
                String url = "jdbc:sqlserver://localhost:1433;databaseName=HouseholdManagement";
                String username = "sa";
                String password = "123";
                
                // Establish connection
                this.connection = DriverManager.getConnection(url, username, password);
                System.out.println("DBContext: Database connection re-established successfully");
            }
        } catch (SQLException e) {
            System.err.println("DBContext ERROR in getConnection: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
    
    /**
     * Close the database connection
     */
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("DBContext: Database connection closed successfully");
            }
        } catch (SQLException e) {
            System.err.println("DBContext ERROR in closeConnection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Helper method to close database resources
     * 
     * @param conn The database connection to close
     * @param stmt The prepared statement to close
     * @param rs The result set to close
     */
    protected void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("DBContext ERROR in closeResources (ResultSet): " + e.getMessage());
            e.printStackTrace();
        }
        
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            System.err.println("DBContext ERROR in closeResources (PreparedStatement): " + e.getMessage());
            e.printStackTrace();
        }
        
        // Only close the connection if it's not the main connection from DBContext
        try {
            if (conn != null && conn != connection) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("DBContext ERROR in closeResources (Connection): " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
    }
}
