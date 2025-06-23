package model;

import java.util.Date;

public class RegistrationDocument {
    private int documentId;
    private int registrationId;
    private String documentType;
    private String filePath;
    private String fileName;
    private int fileSize;
    private String contentType;
    private Date uploadDate;
    private String description;
    private byte[] fileData;
    
    // Constructors
    public RegistrationDocument() {
    }
    
    public RegistrationDocument(int registrationId, String documentType, String filePath, 
                               String fileName, int fileSize, String contentType, String description) {
        this.registrationId = registrationId;
        this.documentType = documentType;
        this.filePath = filePath;
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.contentType = contentType;
        this.description = description;
        this.uploadDate = new Date();
    }
    
    // Getters and setters
    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getFileData() {
        return fileData;
    }

    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }

    public String getFileType() {
        return contentType;
    }

    public void setFileType(String fileType) {
        this.contentType = fileType;
    }
}