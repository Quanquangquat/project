package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Province;
import model.District;
import model.Ward;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddressDAO extends DBContext {

    // Get all provinces
    public List<Province> getAllProvinces() {
        List<Province> provinces = new ArrayList<>();
        String sql = "SELECT * FROM provinces ORDER BY name";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch provinces");
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return provinces;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            System.out.println("AddressDAO: Executing SQL: " + sql);
            ResultSet rs = st.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                count++;
                Province province = new Province();
                province.setCode(rs.getString("code"));
                province.setName(rs.getString("name"));
                province.setNameEn(rs.getString("name_en"));
                province.setFullName(rs.getString("full_name"));
                province.setFullNameEn(rs.getString("full_name_en"));
                province.setCodeName(rs.getString("code_name"));
                province.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));
                province.setAdministrativeRegionId(rs.getInt("administrative_region_id"));
                provinces.add(province);
            }
            System.out.println("AddressDAO: Found " + count + " provinces");

            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getAllProvinces: " + e.getMessage());
            e.printStackTrace();
        }

        return provinces;
    }

    // Get districts by province code
    public List<District> getDistrictsByProvinceCode(String provinceCode) {
        List<District> districts = new ArrayList<>();
        String sql = "SELECT * FROM districts WHERE province_code = ? ORDER BY name";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch districts for province: " + provinceCode);
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return districts;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, provinceCode);
            System.out.println("AddressDAO: Executing SQL: " + sql + " with provinceCode=" + provinceCode);
            ResultSet rs = st.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                count++;
                District district = new District();
                district.setCode(rs.getString("code"));
                district.setName(rs.getString("name"));
                district.setNameEn(rs.getString("name_en"));
                district.setFullName(rs.getString("full_name"));
                district.setFullNameEn(rs.getString("full_name_en"));
                district.setCodeName(rs.getString("code_name"));
                district.setProvinceCode(rs.getString("province_code"));
                district.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));
                districts.add(district);
            }
            System.out.println("AddressDAO: Found " + count + " districts for province: " + provinceCode);

            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getDistrictsByProvinceCode: " + e.getMessage());
            e.printStackTrace();
        }

        return districts;
    }

    // Get wards by district code
    public List<Ward> getWardsByDistrictCode(String districtCode) {
        List<Ward> wards = new ArrayList<>();
        String sql = "SELECT * FROM wards WHERE district_code = ? ORDER BY name";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch wards for district: " + districtCode);
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return wards;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, districtCode);
            System.out.println("AddressDAO: Executing SQL: " + sql + " with districtCode=" + districtCode);
            ResultSet rs = st.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                count++;
                Ward ward = new Ward();
                ward.setCode(rs.getString("code"));
                ward.setName(rs.getString("name"));
                ward.setNameEn(rs.getString("name_en"));
                ward.setFullName(rs.getString("full_name"));
                ward.setFullNameEn(rs.getString("full_name_en"));
                ward.setCodeName(rs.getString("code_name"));
                ward.setDistrictCode(rs.getString("district_code"));
                ward.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));
                wards.add(ward);
            }
            System.out.println("AddressDAO: Found " + count + " wards for district: " + districtCode);

            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getWardsByDistrictCode: " + e.getMessage());
            e.printStackTrace();
        }

        return wards;
    }

    // Get province by code
    public Province getProvinceByCode(String code) {
        String sql = "SELECT * FROM provinces WHERE code = ?";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch province with code: " + code);
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return null;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            System.out.println("AddressDAO: Executing SQL: " + sql + " with code=" + code);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Province province = new Province();
                province.setCode(rs.getString("code"));
                province.setName(rs.getString("name"));
                province.setNameEn(rs.getString("name_en"));
                province.setFullName(rs.getString("full_name"));
                province.setFullNameEn(rs.getString("full_name_en"));
                province.setCodeName(rs.getString("code_name"));
                province.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));
                province.setAdministrativeRegionId(rs.getInt("administrative_region_id"));

                rs.close();
                st.close();
                System.out.println("AddressDAO: Found province with code: " + code);
                return province;
            } else {
                System.out.println("AddressDAO: No province found with code: " + code);
            }
            
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getProvinceByCode: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get district by code
    public District getDistrictByCode(String code) {
        String sql = "SELECT * FROM districts WHERE code = ?";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch district with code: " + code);
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return null;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            System.out.println("AddressDAO: Executing SQL: " + sql + " with code=" + code);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                District district = new District();
                district.setCode(rs.getString("code"));
                district.setName(rs.getString("name"));
                district.setNameEn(rs.getString("name_en"));
                district.setFullName(rs.getString("full_name"));
                district.setFullNameEn(rs.getString("full_name_en"));
                district.setCodeName(rs.getString("code_name"));
                district.setProvinceCode(rs.getString("province_code"));
                district.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));

                // Set the province reference
                district.setProvince(getProvinceByCode(district.getProvinceCode()));

                rs.close();
                st.close();
                System.out.println("AddressDAO: Found district with code: " + code);
                return district;
            } else {
                System.out.println("AddressDAO: No district found with code: " + code);
            }
            
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getDistrictByCode: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get ward by code
    public Ward getWardByCode(String code) {
        String sql = "SELECT * FROM wards WHERE code = ?";

        try {
            System.out.println("AddressDAO: Connecting to database to fetch ward with code: " + code);
            if (connection == null || connection.isClosed()) {
                System.out.println("AddressDAO: Connection is null or closed, creating new connection");
                // Re-establish connection if needed
                super.connection = getConnection();
                if (connection == null) {
                    System.err.println("AddressDAO: Failed to establish database connection");
                    return null;
                }
            }
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            System.out.println("AddressDAO: Executing SQL: " + sql + " with code=" + code);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Ward ward = new Ward();
                ward.setCode(rs.getString("code"));
                ward.setName(rs.getString("name"));
                ward.setNameEn(rs.getString("name_en"));
                ward.setFullName(rs.getString("full_name"));
                ward.setFullNameEn(rs.getString("full_name_en"));
                ward.setCodeName(rs.getString("code_name"));
                ward.setDistrictCode(rs.getString("district_code"));
                ward.setAdministrativeUnitId(rs.getInt("administrative_unit_id"));

                // Set the district reference
                ward.setDistrict(getDistrictByCode(ward.getDistrictCode()));

                rs.close();
                st.close();
                System.out.println("AddressDAO: Found ward with code: " + code);
                return ward;
            } else {
                System.out.println("AddressDAO: No ward found with code: " + code);
            }
            
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("AddressDAO ERROR in getWardByCode: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get full address string
    public String getFullAddress(String wardCode, String houseNumber) {
        Ward ward = getWardByCode(wardCode);
        if (ward != null && ward.getDistrict() != null && ward.getDistrict().getProvince() != null) {
            return String.format("%s, %s, %s, %s",
                    houseNumber,
                    ward.getName(),
                    ward.getDistrict().getName(),
                    ward.getDistrict().getProvince().getName());
        }
        return null;
    }

    // Get province name by code
    public String getProvinceNameByCode(String provinceCode) {
        String query = "SELECT name FROM provinces WHERE code = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, provinceCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, 
                "Error getting province name for code " + provinceCode + ": " + ex.getMessage(), ex);
        }
        return provinceCode; // Return code if name not found
    }

    // Get district name by code
    public String getDistrictNameByCode(String districtCode) {
        String query = "SELECT name FROM districts WHERE code = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, districtCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, 
                "Error getting district name for code " + districtCode + ": " + ex.getMessage(), ex);
        }
        return districtCode; // Return code if name not found
    }

    // Get ward name by code
    public String getWardNameByCode(String wardCode) {
        String query = "SELECT name FROM wards WHERE code = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, wardCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, 
                "Error getting ward name for code " + wardCode + ": " + ex.getMessage(), ex);
        }
        return wardCode; // Return code if name not found
    }

}
