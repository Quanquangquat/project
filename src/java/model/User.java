package model;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String password;
    private int roleId;
    private String role;
    private String address;
    private String cccd;

    private Integer householdId; // Nullable, references Households table
    private String gender; // Male, Female, Other
    private String phoneNumber;

    public User() {
    }

    public User(int userId, String fullName, String email, String password, int roleId, String address, String cccd) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.address = address;
        this.cccd = cccd;
    }

    public User(int userId, String fullName, String email, String password, int roleId, String role, String address, String cccd) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.role = role;
        this.address = address;
        this.cccd = cccd;
    }

    public User(int userId, String fullName, String email, String password, int roleId, String address, String cccd, Integer householdId) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.address = address;
        this.cccd = cccd;
        this.householdId = householdId;
    }

    public User(int userId, String fullName, String email, String password, int roleId, String address, String cccd, Integer householdId, String gender, String phoneNumber) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.address = address;
        this.cccd = cccd;
        this.householdId = householdId;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public Integer getHouseholdId() {
        return householdId;
    }

    public void setHouseholdId(Integer householdId) {
        this.householdId = householdId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Users{"
                + "userId=" + userId
                + ", fullName='" + fullName + '\''
                + ", email='" + email + '\''
                + ", password='" + password + '\''
                + ", roleId=" + roleId 
                + ", role=" + role + '\''
                + ", address='" + address + '\''
                + ", cccd='" + cccd + '\''
                + ", householdId=" + householdId
                + ", gender='" + gender + '\''
                + ", phoneNumber='" + phoneNumber + '\''
                + '}';
    }
}
