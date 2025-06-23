import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Java application to import Vietnamese administrative divisions into the Areas table.
 * 
 * Note: This application requires the org.json library.
 * You can download it from: https://mvnrepository.com/artifact/org.json/json
 * 
 * Compile with:
 * javac -cp .;path/to/json.jar ImportAreasFromJson.java
 * 
 * Run with:
 * java -cp .;path/to/json.jar ImportAreasFromJson
 */
public class ImportAreasFromJson {
    // Update this connection string to match your database
    private static final String CONNECTION_STRING = "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=HouseholdManagement;integratedSecurity=true;";
    private static final String JSON_URL = "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json";

    public static void main(String[] args) {
        System.out.println("Starting import of Vietnamese administrative divisions into Areas table...");

        try {
            // Download and parse the JSON data
            String jsonData = downloadJsonData();
            JSONArray citiesArray = new JSONArray(jsonData);
            
            // Insert the data into the database
            int insertedCount = insertAreasIntoDatabase(citiesArray);
            
            System.out.println("Successfully inserted " + insertedCount + " records into the Areas table.");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("Cause: " + e.getCause().getMessage());
            }
            e.printStackTrace();
        }

        System.out.println("Press Enter to exit...");
        try {
            System.in.read();
        } catch (Exception e) {
            // Ignore
        }
    }

    private static String downloadJsonData() throws Exception {
        System.out.println("Downloading JSON data...");
        URL url = new URL(JSON_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        
        StringBuilder response = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }
        
        return response.toString();
    }

    private static int insertAreasIntoDatabase(JSONArray citiesArray) throws Exception {
        int totalInserted = 0;

        // Load the JDBC driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        try (Connection connection = DriverManager.getConnection(CONNECTION_STRING)) {
            // Disable auto-commit for transaction
            connection.setAutoCommit(false);
            
            try {
                // Check if Areas table exists
                boolean tableExists = checkTableExists(connection);
                if (!tableExists) {
                    System.out.println("Areas table does not exist. Creating it...");
                    createAreasTable(connection);
                }
                
                // Prepare the insert statement
                String insertSql = "INSERT INTO [dbo].[Areas] ([AreaName], [District], [City]) VALUES (?, ?, ?)";
                try (PreparedStatement pstmt = connection.prepareStatement(insertSql)) {
                    
                    // Process each city/province
                    for (int i = 0; i < citiesArray.length(); i++) {
                        JSONObject city = citiesArray.getJSONObject(i);
                        String cityName = city.getString("Name");
                        System.out.println("Processing " + cityName + "...");
                        
                        // Process each district in the city/province
                        JSONArray districts = city.getJSONArray("Districts");
                        for (int j = 0; j < districts.length(); j++) {
                            JSONObject district = districts.getJSONObject(j);
                            String districtName = district.getString("Name");
                            
                            // Process each ward in the district
                            JSONArray wards = district.getJSONArray("Wards");
                            for (int k = 0; k < wards.length(); k++) {
                                JSONObject ward = wards.getJSONObject(k);
                                String wardName = ward.getString("Name");
                                
                                // Set parameter values
                                pstmt.setString(1, wardName);
                                pstmt.setString(2, districtName);
                                pstmt.setString(3, cityName);
                                
                                // Execute the insert
                                pstmt.executeUpdate();
                                totalInserted++;
                                
                                // Show progress every 1000 records
                                if (totalInserted % 1000 == 0) {
                                    System.out.println("Inserted " + totalInserted + " records so far...");
                                }
                            }
                        }
                    }
                }
                
                // Commit the transaction
                connection.commit();
            } catch (Exception e) {
                // Rollback the transaction if an error occurs
                connection.rollback();
                throw e;
            }
        }
        
        return totalInserted;
    }
    
    private static boolean checkTableExists(Connection connection) throws Exception {
        String sql = "SELECT CASE WHEN EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Areas]') AND type in (N'U')) THEN 1 ELSE 0 END";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1) == 1;
            }
            return false;
        }
    }
    
    private static void createAreasTable(Connection connection) throws Exception {
        String sql = "CREATE TABLE [dbo].[Areas] (\n" +
                     "    [AreaID] INT IDENTITY(1,1) PRIMARY KEY,\n" +
                     "    [AreaName] NVARCHAR(100) NOT NULL,\n" +
                     "    [District] NVARCHAR(100) NOT NULL,\n" +
                     "    [City] NVARCHAR(100) NOT NULL,\n" +
                     "    [AreaLeaderID] INT NULL,\n" +
                     "    [PoliceOfficerID] INT NULL\n" +
                     ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }
} 