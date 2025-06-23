package model;

import java.io.Serializable;

/**
 * District model class representing the districts table in the database.
 * Contains information about districts in Vietnam.
 */
public class District implements Serializable {
    private String code;            // Primary key
    private String name;            // District name in Vietnamese
    private String nameEn;          // District name in English
    private String fullName;        // Full district name in Vietnamese
    private String fullNameEn;      // Full district name in English
    private String codeName;        // Code name of the district
    private String provinceCode;    // Foreign key to provinces table
    private Integer administrativeUnitId;     // ID of the administrative unit
    
    // Reference to Province object
    private Province province;

    // Default constructor
    public District() {
    }

    // Constructor with all fields
    public District(String code, String name, String nameEn, String fullName, 
            String fullNameEn, String codeName, String provinceCode, 
            Integer administrativeUnitId) {
        this.code = code;
        this.name = name;
        this.nameEn = nameEn;
        this.fullName = fullName;
        this.fullNameEn = fullNameEn;
        this.codeName = codeName;
        this.provinceCode = provinceCode;
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

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public Integer getAdministrativeUnitId() {
        return administrativeUnitId;
    }

    public void setAdministrativeUnitId(Integer administrativeUnitId) {
        this.administrativeUnitId = administrativeUnitId;
    }
    
    public Province getProvince() {
        return province;
    }
    
    public void setProvince(Province province) {
        this.province = province;
        if (province != null) {
            this.provinceCode = province.getCode();
        }
    }

    @Override
    public String toString() {
        return "District{" + 
                "code='" + code + '\'' + 
                ", name='" + name + '\'' + 
                ", nameEn='" + nameEn + '\'' + 
                ", fullName='" + fullName + '\'' + 
                ", fullNameEn='" + fullNameEn + '\'' + 
                ", codeName='" + codeName + '\'' + 
                ", provinceCode='" + provinceCode + '\'' + 
                ", administrativeUnitId=" + administrativeUnitId + 
                '}';
    }
} 