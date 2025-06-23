package model;

import java.io.Serializable;

/**
 * Province model class representing the provinces table in the database.
 * Contains information about provinces/cities in Vietnam.
 */
public class Province implements Serializable {
    private String code;            // Primary key
    private String name;            // Province name in Vietnamese
    private String nameEn;          // Province name in English
    private String fullName;        // Full province name in Vietnamese
    private String fullNameEn;      // Full province name in English
    private String codeName;        // Code name of the province
    private Integer administrativeUnitId;     // ID of the administrative unit
    private Integer administrativeRegionId;   // ID of the administrative region

    // Default constructor
    public Province() {
    }

    // Constructor with all fields
    public Province(String code, String name, String nameEn, String fullName, 
            String fullNameEn, String codeName, Integer administrativeUnitId, 
            Integer administrativeRegionId) {
        this.code = code;
        this.name = name;
        this.nameEn = nameEn;
        this.fullName = fullName;
        this.fullNameEn = fullNameEn;
        this.codeName = codeName;
        this.administrativeUnitId = administrativeUnitId;
        this.administrativeRegionId = administrativeRegionId;
    }

    // Getters and Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getFullNameEn() {
        return fullNameEn;
    }

    public void setFullNameEn(String fullNameEn) {
        this.fullNameEn = fullNameEn;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public Integer getAdministrativeUnitId() {
        return administrativeUnitId;
    }

    public void setAdministrativeUnitId(Integer administrativeUnitId) {
        this.administrativeUnitId = administrativeUnitId;
    }

    public Integer getAdministrativeRegionId() {
        return administrativeRegionId;
    }

    public void setAdministrativeRegionId(Integer administrativeRegionId) {
        this.administrativeRegionId = administrativeRegionId;
    }

    @Override
    public String toString() {
        return "Province{" + 
                "code='" + code + '\'' + 
                ", name='" + name + '\'' + 
                ", nameEn='" + nameEn + '\'' + 
                ", fullName='" + fullName + '\'' + 
                ", fullNameEn='" + fullNameEn + '\'' + 
                ", codeName='" + codeName + '\'' + 
                ", administrativeUnitId=" + administrativeUnitId + 
                ", administrativeRegionId=" + administrativeRegionId + 
                '}';
    }
} 