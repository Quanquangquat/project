package model;

import java.io.Serializable;

/**
 * Ward model class representing the wards table in the database.
 * Contains information about wards/communes in Vietnam.
 */
public class Ward implements Serializable {
    private String code;            // Primary key
    private String name;            // Ward name in Vietnamese
    private String nameEn;          // Ward name in English
    private String fullName;        // Full ward name in Vietnamese
    private String fullNameEn;      // Full ward name in English
    private String codeName;        // Code name of the ward
    private String districtCode;    // Foreign key to districts table
    private Integer administrativeUnitId;     // ID of the administrative unit
    
    // Reference to District object
    private District district;

    // Default constructor
    public Ward() {
    }

    // Constructor with all fields
    public Ward(String code, String name, String nameEn, String fullName, 
            String fullNameEn, String codeName, String districtCode, 
            Integer administrativeUnitId) {
        this.code = code;
        this.name = name;
        this.nameEn = nameEn;
        this.fullName = fullName;
        this.fullNameEn = fullNameEn;
        this.codeName = codeName;
        this.districtCode = districtCode;
        this.administrativeUnitId = administrativeUnitId;
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

    public String getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(String districtCode) {
        this.districtCode = districtCode;
    }

    public Integer getAdministrativeUnitId() {
        return administrativeUnitId;
    }

    public void setAdministrativeUnitId(Integer administrativeUnitId) {
        this.administrativeUnitId = administrativeUnitId;
    }
    
    public District getDistrict() {
        return district;
    }
    
    public void setDistrict(District district) {
        this.district = district;
        if (district != null) {
            this.districtCode = district.getCode();
        }
    }

    @Override
    public String toString() {
        return "Ward{" + 
                "code='" + code + '\'' + 
                ", name='" + name + '\'' + 
                ", nameEn='" + nameEn + '\'' + 
                ", fullName='" + fullName + '\'' + 
                ", fullNameEn='" + fullNameEn + '\'' + 
                ", codeName='" + codeName + '\'' + 
                ", districtCode='" + districtCode + '\'' + 
                ", administrativeUnitId=" + administrativeUnitId + 
                '}';
    }
} 