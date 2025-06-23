package model;

/**
 * Represents a document type in the system.
 */
public class DocumentType {
    private int documentTypeId;
    private String documentTypeName;
    private String description;
    
    /**
     * Default constructor
     */
    public DocumentType() {
    }
    
    /**
     * Constructor with all fields
     * 
     * @param documentTypeId The ID of the document type
     * @param documentTypeName The name of the document type
     * @param description The description of the document type
     */
    public DocumentType(int documentTypeId, String documentTypeName, String description) {
        this.documentTypeId = documentTypeId;
        this.documentTypeName = documentTypeName;
        this.description = description;
    }
    
    /**
     * Constructor with ID and name
     * 
     * @param documentTypeId The ID of the document type
     * @param documentTypeName The name of the document type
     */
    public DocumentType(int documentTypeId, String documentTypeName) {
        this.documentTypeId = documentTypeId;
        this.documentTypeName = documentTypeName;
    }

    /**
     * Get the document type ID
     * 
     * @return The document type ID
     */
    public int getDocumentTypeId() {
        return documentTypeId;
    }

    /**
     * Set the document type ID
     * 
     * @param documentTypeId The document type ID to set
     */
    public void setDocumentTypeId(int documentTypeId) {
        this.documentTypeId = documentTypeId;
    }

    /**
     * Get the document type name
     * 
     * @return The document type name
     */
    public String getDocumentTypeName() {
        return documentTypeName;
    }

    /**
     * Set the document type name
     * 
     * @param documentTypeName The document type name to set
     */
    public void setDocumentTypeName(String documentTypeName) {
        this.documentTypeName = documentTypeName;
    }

    /**
     * Get the document type description
     * 
     * @return The document type description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Set the document type description
     * 
     * @param description The document type description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "DocumentType{" +
                "documentTypeId=" + documentTypeId +
                ", documentTypeName='" + documentTypeName + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
} 