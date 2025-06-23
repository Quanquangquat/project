package model;

/**
 * Model class representing an area (khu phố)
 */
public class Area {
    private int areaId;
    private String provinceName;  // Foreign key to provinces table
    private String districtName;  // Foreign key to districts table
    private String wardName;      // Foreign key to wards table
    
    
    // Constructors
    public Area() {
    }
    
    public Area(int areaId, String provinceName, String districtName, String wardName) {
        this.areaId = areaId;
        this.provinceName = provinceName;
        this.districtName = districtName;
        this.wardName = wardName;
    }

    // Getters and setters
    public int getAreaId() {
        return areaId;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public String getDistrictName() {
        return districtName;
    }   

    public String getWardName() {
        return wardName;
    }       

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public void setWardName(String wardName) {
        this.wardName = wardName;
    }

    @Override
    public String toString() {
        return "Area{" +
                "areaId=" + areaId +
                ", provinceName='" + provinceName + '\'' +
                ", districtName='" + districtName + '\'' +
                ", wardName='" + wardName + '\'' +
                '}';
    }
}
