package controller.admin;

import model.User;
import model.Household;
import model.Role;
import dao.user.UserDAO;
import dao.RoleDAO;
import dao.HouseholdDAO;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//import java.lang.System.Logger;
//import java.lang.System.Logger.Level;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AdminController", urlPatterns = {
    "/admin/viewAllUsers",
    "/admin/manageUsers",
    "/admin/viewAllHouseholds",
    "/admin/manageHouseholds",
    "/admin/viewAllRequests",
    "/admin/approveRequests",
    "/admin/generateReports",
    "/admin/manageAnnouncements",
    "/admin/viewProfile",
    "/admin/updateProfile"
})
public class AdminController extends HttpServlet {

    private UserDAO userDAO;
    private RoleDAO roleDAO;
    private HouseholdDAO householdDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
        householdDAO = new HouseholdDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser.getRoleId() != 4) { // Ensure only Admins (RoleID 4) can access
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String path = request.getServletPath();
        switch (path) {
            case "/admin/viewAllUsers":
                handleViewAllUsers(request, response);
                break;
            case "/admin/manageUsers":
                handleManageUsers(request, response);
                break;
            case "/admin/viewAllHouseholds":
                handleViewAllHouseholds(request, response);
                break;
            case "/admin/manageHouseholds":
                handleManageHouseholds(request, response);
                break;
            case "/admin/viewAllRequests":
                handleViewAllRequests(request, response);
                break;
            case "/admin/approveRequests":
                handleApproveRequests(request, response);
                break;
            case "/admin/generateReports":
                handleGenerateReports(request, response);
                break;
            case "/admin/manageAnnouncements":
                handleManageAnnouncements(request, response);
                break;
            case "/admin/viewProfile":
                handleViewProfile(request, response);
                break;
            case "/admin/updateProfile":
                handleUpdateProfile(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid admin action");
                break;
        }
    }

    private void handleViewAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        for (User user : users) {
            Role role = roleDAO.getRoleById(user.getRoleId());
            if (role != null) {
                user.setRoleId(role.getRoleId());
            } else {
//                user.setRoleName("Unknown"); //
            }
        }
        request.setAttribute("usersList", users);
        request.getRequestDispatcher("/WEB-INF/views/user/admin/viewAllUsers.jsp").forward(request, response);
    }

    private void handleViewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/user/admin/viewProfile.jsp").forward(request, response);
            } else {
                Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "User not found with ID: {0}", userId);
                request.setAttribute("message", "User not found.");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } catch (NumberFormatException e) {
            Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "Invalid user ID format: {0}", e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            try {
                int userId = Integer.parseInt(request.getParameter("id"));
                User user = userDAO.getUserById(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/user/admin/updateProfile.jsp").forward(request, response);
                } else {
                    Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "User not found with ID: {0}", userId);
                    request.setAttribute("message", "User not found.");
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                }
            } catch (NumberFormatException e) {
                Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "Invalid user ID format: {0}", e.getMessage());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = userDAO.getUserById(userId);
                if (user != null) {
                    user.setFullName(request.getParameter("fullName"));
                    user.setEmail(request.getParameter("email"));
                    user.setAddress(request.getParameter("address"));
                    user.setCccd(request.getParameter("cccd"));
                    user.setGender(request.getParameter("gender"));
                    user.setPhoneNumber(request.getParameter("phoneNumber"));

                    // Validate input
                    if (user.getFullName() == null || user.getFullName().trim().isEmpty()
                            || user.getEmail() == null || user.getEmail().trim().isEmpty()
                            || user.getAddress() == null || user.getAddress().trim().isEmpty()
                            || user.getCccd() == null || user.getCccd().trim().isEmpty()) {
                        throw new IllegalArgumentException("All required fields must be filled.");
                    }
                    if (!user.getEmail().matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                        throw new IllegalArgumentException("Invalid email format.");
                    }
                    if (!user.getCccd().matches("\\d{12}")) {
                        throw new IllegalArgumentException("CCCD must be a 12-digit number.");
                    }
                    if (user.getGender() != null && !user.getGender().isEmpty()
                            && !user.getGender().equals("Male") && !user.getGender().equals("Female") && !user.getGender().equals("Other")) {
                        throw new IllegalArgumentException("Gender must be Male, Female, or Other.");
                    }

                    boolean updated = userDAO.updateUser(user);
                    if (updated) {
                        request.setAttribute("message", "User updated successfully.");
                    } else {
                        request.setAttribute("message", "Failed to update user.");
                    }
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/user/admin/updateProfile.jsp").forward(request, response);
                } else {
                    Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "User not found with ID: {0}", userId);
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                }
            } catch (NumberFormatException e) {
                Logger.getLogger(AdminController.class.getName()).log(Level.WARNING, "Invalid user ID format: {0}", e.getMessage());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            } catch (IllegalArgumentException e) {
                request.setAttribute("message", e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/user/admin/updateProfile.jsp").forward(request, response);
            }
        }
    }

    private void handleManageUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            List<User> users = userDAO.getAllUsers();
            List<Role> roles = roleDAO.getAllRoles();
            for (User user : users) {
                Role role = roleDAO.getRoleById(user.getRoleId());
                if (role != null) {
                    user.setRoleId(role.getRoleId());
                } else {
//                    user.setRoleName("Unknown"); //
                }
            }
            request.setAttribute("usersList", users);
            request.setAttribute("rolesList", roles);
            request.getRequestDispatcher("/WEB-INF/views/user/admin/manageUsers.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String action = request.getParameter("action");
            String message;
            User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");
            try {
                switch (action) {
                    case "add":
                        String fullName = request.getParameter("fullName");
                        String email = request.getParameter("email");
                        String password = request.getParameter("password");
                        String roleIdStr = request.getParameter("role");
                        String address = request.getParameter("address");
                        String cccd = request.getParameter("cccd");
                        String gender = request.getParameter("gender");
                        String phoneNumber = request.getParameter("phoneNumber");

                        if (fullName == null || fullName.trim().isEmpty()
                                || email == null || email.trim().isEmpty()
                                || password == null || password.trim().isEmpty()
                                || roleIdStr == null || roleIdStr.trim().isEmpty()
                                || address == null || address.trim().isEmpty()
                                || cccd == null || cccd.trim().isEmpty()) {
                            throw new IllegalArgumentException("All fields are required.");
                        }

                        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                            throw new IllegalArgumentException("Invalid email format.");
                        }

                        if (!cccd.matches("\\d{12}")) {
                            throw new IllegalArgumentException("CCCD must be a 12-digit number.");
                        }

                        int roleId = Integer.parseInt(roleIdStr);
                        if (roleDAO.getRoleById(roleId) == null) {
                            throw new IllegalArgumentException("Invalid Role ID: " + roleId);
                        }

                        if (userDAO.getUserByEmail(email) != null) {
                            throw new IllegalArgumentException("Email already exists.");
                        }
                        if (userDAO.getUserByCccd(cccd) != null) {
                            throw new IllegalArgumentException("CCCD already exists.");
                        }

                        // Validate gender if provided
                        if (gender != null && !gender.isEmpty()
                                && !gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {
                            throw new IllegalArgumentException("Gender must be Male, Female, or Other.");
                        }

                        User newUser = new User();
                        newUser.setFullName(fullName);
                        newUser.setEmail(email);
                        newUser.setPassword(password);
                        newUser.setRoleId(roleId);
                        newUser.setAddress(address);
                        newUser.setCccd(cccd);
                        newUser.setGender(gender);
                        newUser.setPhoneNumber(phoneNumber);

                        User addedUser = userDAO.insertUser(newUser);
                        if (addedUser != null) {
                            message = "User added successfully with ID: " + addedUser.getUserId();
                        } else {
                            message = "Failed to add user. Please check database constraints or connectivity.";
                        }
                        break;

//                    case "update":
//                        int userId = Integer.parseInt(request.getParameter("userId"));
//                        User existingUser = userDAO.getUserById(userId);
//                        if (existingUser != null) {
//                            existingUser.setFullName(request.getParameter("fullName"));
//                            existingUser.setEmail(request.getParameter("email"));
//                            String newPassword = request.getParameter("password");
//                            if (newPassword != null && !newPassword.isEmpty()) {
//                                existingUser.setPassword(newPassword);
//                            }
//                            existingUser.setRoleId(Integer.parseInt(request.getParameter("role")));
//                            existingUser.setAddress(request.getParameter("address"));
//                            existingUser.setCccd(request.getParameter("cccd"));
//                            existingUser.setGender(request.getParameter("gender"));
//                            existingUser.setPhoneNumber(request.getParameter("phoneNumber"));
//
//                            boolean updated = userDAO.updateUser(existingUser);
//                            if (updated) {
//                                message = "User updated successfully.";
//                            } else {
//                                message = "Failed to update user.";
//                            }
//                        } else {
//                            message = "User with ID " + userId + " not found.";
//                        }
//                        break;

                    case "delete":
                        String deleteUserIdStr = request.getParameter("deleteuser");
                    if (deleteUserIdStr == null || deleteUserIdStr.trim().isEmpty()) {
                        throw new IllegalArgumentException("User ID is required for deletion.");
                    }
                    int userId = Integer.parseInt(deleteUserIdStr);
                    if (userId == loggedInUser.getUserId()) {
                        throw new IllegalArgumentException("Cannot delete your own account.");
                    }
                    boolean deleted = userDAO.deleteUser(userId);
                    if (deleted) {
                        message = "User deleted successfully.";
                    } else {
                        message = "Failed to delete user with ID " + userId + ".";
                    }
                    break;

                    case "search":
                        String searchCccd = request.getParameter("searchCccd");
                        String searchFullName = request.getParameter("searchFullName");
                        String searchEmail = request.getParameter("searchEmail");
                        String searchAddress = request.getParameter("searchAddress");

                        List<User> searchResults = userDAO.searchUsers(searchCccd, searchFullName, searchEmail, searchAddress);
                        List<Role> roles = roleDAO.getAllRoles();
                        for (User user : searchResults) {
                            Role role = roleDAO.getRoleById(user.getRoleId());
                            if (role != null) {
                                user.setRoleId(role.getRoleId());
                            } else {
//                                user.setRoleName("Unknown"); //
                            }
                        }
                        request.setAttribute("usersList", searchResults);
                        request.setAttribute("rolesList", roles);
                        request.setAttribute("message", "Search results for: CCCD=" + searchCccd + ", Name=" + searchFullName + ", Email=" + searchEmail + ", Address=" + searchAddress);
                        request.getRequestDispatcher("/WEB-INF/views/user/admin/manageUsers.jsp").forward(request, response);
                        return; // Exit after search to avoid further processing

                    default:
                        message = "Invalid action specified.";
                        break;
                }
            } catch (NumberFormatException e) {
                message = "Invalid user ID or role format: " + e.getMessage();
            } catch (IllegalArgumentException e) {
                message = e.getMessage();
            } catch (Exception e) {
                message = "An error occurred: " + e.getMessage();
            }

            List<User> users = userDAO.getAllUsers();
            List<Role> roles = roleDAO.getAllRoles();
            for (User user : users) {
                Role role = roleDAO.getRoleById(user.getRoleId());
                if (role != null) {
                    user.setRoleId(role.getRoleId());
                } else {
//                    user.setRoleName("Unknown");
                }
            }
            request.setAttribute("usersList", users);
            request.setAttribute("rolesList", roles);
            request.setAttribute("message", message);
            request.getRequestDispatcher("/WEB-INF/views/user/admin/manageUsers.jsp").forward(request, response);
        }
    }

    private void handleViewAllHouseholds(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Household> households = householdDAO.getAllHouseholds();
        request.setAttribute("householdsList", households);
        request.getRequestDispatcher("/WEB-INF/views/user/admin/viewAllHouseholds.jsp").forward(request, response);
    }

    private void handleManageHouseholds(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            List<Household> households = householdDAO.getAllHouseholds();
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("householdsList", households);
            request.setAttribute("usersList", users);
            request.getRequestDispatcher("/WEB-INF/views/user/admin/manageHouseholds.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String action = request.getParameter("action");
            String message;

            try {
                switch (action) {
                    case "add":
                        String address = request.getParameter("address");
                        String headOfHouseholdIdStr = request.getParameter("headOfHouseholdId");

                        if (address == null || address.trim().isEmpty()) {
                            throw new IllegalArgumentException("Address is required.");
                        }

                        Integer headOfHouseholdId = null;
                        if (headOfHouseholdIdStr != null && !headOfHouseholdIdStr.isEmpty() && !headOfHouseholdIdStr.equals("none")) {
                            headOfHouseholdId = Integer.parseInt(headOfHouseholdIdStr);
                            if (userDAO.getUserById(headOfHouseholdId) == null) {
                                throw new IllegalArgumentException("Invalid Head of Household ID: " + headOfHouseholdId);
                            }
                        }

                        Household newHousehold = new Household();
                        newHousehold.setHeadOfHouseholdId(headOfHouseholdId);
                        newHousehold.setAddress(address);
                        newHousehold.setCreatedDate(new Date());

                        Household addedHousehold = householdDAO.insertHousehold(newHousehold);
                        if (addedHousehold != null) {
                            message = "Household added successfully with ID: " + addedHousehold.getHouseholdId();
                        } else {
                            message = "Failed to add household. Please check database constraints or connectivity.";
                        }
                        break;

                    case "update":
                        int householdId = Integer.parseInt(request.getParameter("householdId"));
                        Household existingHousehold = householdDAO.getHouseholdById(householdId);
                        if (existingHousehold != null) {
                            headOfHouseholdIdStr = request.getParameter("headOfHouseholdId");
                            headOfHouseholdId = null;
                            if (headOfHouseholdIdStr != null && !headOfHouseholdIdStr.isEmpty() && !headOfHouseholdIdStr.equals("none")) {
                                headOfHouseholdId = Integer.parseInt(headOfHouseholdIdStr);
                                if (userDAO.getUserById(headOfHouseholdId) == null) {
                                    throw new IllegalArgumentException("Invalid Head of Household ID: " + headOfHouseholdId);
                                }
                            }
                            existingHousehold.setHeadOfHouseholdId(headOfHouseholdId);
                            existingHousehold.setAddress(request.getParameter("address"));
                            boolean updated = householdDAO.updateHousehold(existingHousehold);
                            if (updated) {
                                message = "Household updated successfully.";
                            } else {
                                message = "Failed to update household.";
                            }
                        } else {
                            message = "Household with ID " + householdId + " not found.";
                        }
                        break;

                    case "delete":
                        householdId = Integer.parseInt(request.getParameter("householdId"));
                        boolean deleted = householdDAO.deleteHousehold(householdId);
                        if (deleted) {
                            message = "Household deleted successfully.";
                        } else {
                            message = "Failed to delete household with ID " + householdId + ".";
                        }
                        break;

                    default:
                        message = "Invalid action specified.";
                        break;
                }
            } catch (NumberFormatException e) {
                message = "Invalid household ID or head of household ID format: " + e.getMessage();
            } catch (IllegalArgumentException e) {
                message = e.getMessage();
            } catch (Exception e) {
                message = "An error occurred: " + e.getMessage();
            }

            List<Household> households = householdDAO.getAllHouseholds();
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("householdsList", households);
            request.setAttribute("usersList", users);
            request.setAttribute("message", message);
            request.getRequestDispatcher("/WEB-INF/views/user/admin/manageHouseholds.jsp").forward(request, response);
        }
    }

    private void handleViewAllRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/admin/viewAllRequests.jsp").forward(request, response);
    }

    private void handleApproveRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.getRequestDispatcher("/WEB-INF/views/user/admin/approveRequests.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String requestId = request.getParameter("requestId");
            String decision = request.getParameter("decision");
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void handleGenerateReports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/admin/generateReports.jsp").forward(request, response);
    }

    private void handleManageAnnouncements(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.getRequestDispatcher("/WEB-INF/views/user/admin/manageAnnouncements.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String action = request.getParameter("action");
            String content = request.getParameter("content");
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles all Admin-specific actions";
    }
}
