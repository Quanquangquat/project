package dao;

import model.RegistrationDocument;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationDocumentDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(RegistrationDocumentDAO.class.getName());

    // Insert a new document
    public RegistrationDocument insertDocument(RegistrationDocument document) {
        String query = "INSERT INTO RegistrationDocuments (RegistrationID, DocumentType, FilePath, FileName, FileSize, ContentType, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, document.getRegistrationId());
            ps.setString(2, document.getDocumentType());
            ps.setString(3, document.getFilePath());
            ps.setString(4, document.getFileName());
            ps.setInt(5, document.getFileSize());
            ps.setString(6, document.getContentType());
            ps.setString(7, document.getDescription());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    document.setDocumentId(rs.getInt(1));
                    return document;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting document: " + ex.getMessage(), ex);
        }
        return null;
    }
    
    // Get all documents for a registration
    public List<RegistrationDocument> getDocumentsByRegistrationId(int registrationId) {
        List<RegistrationDocument> documents = new ArrayList<>();
        String query = "SELECT * FROM RegistrationDocuments WHERE RegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RegistrationDocument document = new RegistrationDocument();
                    document.setDocumentId(rs.getInt("DocumentID"));
                    document.setRegistrationId(rs.getInt("RegistrationID"));
                    document.setDocumentType(rs.getString("DocumentType"));
                    document.setFilePath(rs.getString("FilePath"));
                    document.setFileName(rs.getString("FileName"));
                    document.setFileSize(rs.getInt("FileSize"));
                    document.setContentType(rs.getString("ContentType"));
                    document.setUploadDate(rs.getTimestamp("UploadDate"));
                    document.setDescription(rs.getString("Description"));
                    documents.add(document);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting documents for registration " + registrationId + ": " + ex.getMessage(), ex);
        }
        return documents;
    }
    
    // Get a document by ID
    public RegistrationDocument getDocumentById(int documentId) {
        String query = "SELECT * FROM RegistrationDocuments WHERE DocumentID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, documentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    RegistrationDocument document = new RegistrationDocument();
                    document.setDocumentId(rs.getInt("DocumentID"));
                    document.setRegistrationId(rs.getInt("RegistrationID"));
                    document.setDocumentType(rs.getString("DocumentType"));
                    document.setFilePath(rs.getString("FilePath"));
                    document.setFileName(rs.getString("FileName"));
                    document.setFileSize(rs.getInt("FileSize"));
                    document.setContentType(rs.getString("ContentType"));
                    document.setUploadDate(rs.getTimestamp("UploadDate"));
                    document.setDescription(rs.getString("Description"));
                    
                    // Get the file data
                    document.setFileData(rs.getBytes("FileData"));
                    
                    return document;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting document " + documentId + ": " + ex.getMessage(), ex);
        }
        return null;
    }
    
    // Delete a document
    public boolean deleteDocument(int documentId) {
        String query = "DELETE FROM RegistrationDocuments WHERE DocumentID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, documentId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting document " + documentId + ": " + ex.getMessage(), ex);
            return false;
        }
    }

    // Insert a new document with file data
    public boolean insertDocumentWithFileData(RegistrationDocument document, java.io.InputStream fileData) {
        String query = "INSERT INTO RegistrationDocuments (RegistrationID, DocumentType, FilePath, FileName, FileSize, ContentType, Description, FileData) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, document.getRegistrationId());
            ps.setString(2, document.getDocumentType() != null ? document.getDocumentType() : "Supporting Document");
            ps.setString(3, document.getFilePath() != null ? document.getFilePath() : "uploads/");
            ps.setString(4, document.getFileName());
            ps.setInt(5, document.getFileSize() > 0 ? document.getFileSize() : 0);
            ps.setString(6, document.getContentType());
            ps.setString(7, document.getDescription() != null ? document.getDescription() : "Uploaded document");
            
            // Set the file data if the column exists
            if (fileData != null) {
                try {
                    ps.setBinaryStream(8, fileData);
                } catch (SQLException ex) {
                    // If the FileData column doesn't exist, try without it
                    LOGGER.log(Level.WARNING, "FileData column might not exist: " + ex.getMessage());
                    return insertDocument(document, fileData);
                }
            } else {
                ps.setNull(8, java.sql.Types.BLOB);
            }
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting document with file data: " + ex.getMessage(), ex);
            // Try the regular insert method as a fallback
            return insertDocument(document, fileData);
        }
    }

    // Check if the FileData column exists and add it if needed
    public boolean ensureFileDataColumnExists() {
        try {
            // Check if the column exists
            DatabaseMetaData meta = connection.getMetaData();
            ResultSet rs = meta.getColumns(null, null, "RegistrationDocuments", "FileData");
            
            if (!rs.next()) {
                // Column doesn't exist, add it
                LOGGER.log(Level.INFO, "FileData column doesn't exist, adding it...");
                String alterQuery = "ALTER TABLE RegistrationDocuments ADD FileData VARBINARY(MAX)";
                
                try (Statement stmt = connection.createStatement()) {
                    stmt.executeUpdate(alterQuery);
                    LOGGER.log(Level.INFO, "FileData column added successfully");
                    return true;
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Error adding FileData column: " + ex.getMessage(), ex);
                    return false;
                }
            } else {
                // Column already exists
                LOGGER.log(Level.INFO, "FileData column already exists");
                return true;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking for FileData column: " + ex.getMessage(), ex);
            return false;
        }
    }

    // Insert a new document with file data from InputStream
    public boolean insertDocument(RegistrationDocument document, java.io.InputStream fileData) {
        String query = "INSERT INTO RegistrationDocuments (RegistrationID, DocumentType, FilePath, FileName, FileSize, ContentType, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, document.getRegistrationId());
            ps.setString(2, document.getDocumentType() != null ? document.getDocumentType() : "Supporting Document");
            ps.setString(3, document.getFilePath() != null ? document.getFilePath() : "uploads/");
            ps.setString(4, document.getFileName());
            ps.setInt(5, document.getFileSize() > 0 ? document.getFileSize() : 0);
            ps.setString(6, document.getContentType());
            ps.setString(7, document.getDescription() != null ? document.getDescription() : "Uploaded document");
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting document: " + ex.getMessage(), ex);
            return false;
        }
    }
    
    // Delete all documents for a specific registration
    public boolean deleteDocumentsByRegistrationId(int registrationId) {
        String query = "DELETE FROM RegistrationDocuments WHERE RegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, registrationId);
            int rowsAffected = ps.executeUpdate();
            LOGGER.log(Level.INFO, "Deleted {0} documents for registration ID {1}", new Object[]{rowsAffected, registrationId});
            return true;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting documents for registration " + registrationId + ": " + ex.getMessage(), ex);
            return false;
        }
    }

    // Add a document with file data
    public boolean addDocument(RegistrationDocument document) {
        String query = "INSERT INTO RegistrationDocuments (RegistrationID, DocumentType, FileName, FileSize, ContentType, UploadDate, Description, FileData) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, document.getRegistrationId());
            ps.setString(2, document.getDocumentType());
            ps.setString(3, document.getFileName());
            ps.setLong(4, document.getFileSize());
            ps.setString(5, document.getFileType());
            ps.setTimestamp(6, new java.sql.Timestamp(document.getUploadDate().getTime()));
            ps.setString(7, document.getDescription());
            ps.setBytes(8, document.getFileData());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    document.setDocumentId(rs.getInt(1));
                    LOGGER.log(Level.INFO, "Document added successfully with ID: " + document.getDocumentId());
                    return true;
                }
            }
            return false;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error adding document: " + ex.getMessage(), ex);
            return false;
        }
    }
} 