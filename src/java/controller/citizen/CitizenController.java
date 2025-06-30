package controller.citizen;

import dao.AreaDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.user.UserDAO;
import dao.HouseholdTransferDAO;
import model.Area;
import model.HouseholdTransfer;
import java.util.List;
import java.util.Date;
import dao.UserAvatarDAO;
import model.UserAvatar;

@WebServlet(name = "CitizenController", urlPatterns = {
    "/citizen/viewProfile",
    "/citizen/updateProfile",
    "/citizen/viewHouseholdInfo",
    "/citizen/registerHouseholdMember",
    "/citizen/submitRequest",
    "/citizen/viewReports",
    "/citizen/viewAnnouncements",
    "/citizen/transferHousehold"
})
public class CitizenController extends HttpServlet {

    private UserDAO userDAO;
    private AreaDAO areaDAO;
    private HouseholdTransferDAO transferDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        areaDAO = new AreaDAO();
        transferDAO = new HouseholdTransferDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser.getRoleId() != 1) { // Ensure only Citizens (RoleID 1) can access
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String path = request.getServletPath();
        switch (path) {
            case "/citizen/viewProfile":
                handleViewProfile(request, response);
                break;
            case "/citizen/updateProfile":
                handleUpdateProfile(request, response);
                break;
            case "/citizen/viewHouseholdInfo":
                handleViewHouseholdInfo(request, response);
                break;
            case "/citizen/registerHouseholdMember":
                handleRegisterHouseholdMember(request, response);
                break;
            case "/citizen/submitRequest":
                handleSubmitRequest(request, response);
                break;
            case "/citizen/viewReports":
                handleViewReports(request, response);
                break;
            case "/citizen/viewAnnouncements":
                handleViewAnnouncements(request, response);
                break;
            case "/citizen/transferHousehold":
                handleTransferHousehold(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid citizen action");
                break;
        }
    }

    private void handleViewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the logged-in user
        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Check if the user has an active avatar
            UserAvatarDAO avatarDAO = new UserAvatarDAO();
            UserAvatar avatar = avatarDAO.getActiveAvatarByUserId(loggedInUser.getUserId());

            // Set a flag indicating whether the user has an avatar
            request.setAttribute("hasAvatar", avatar != null);
        }

        request.getRequestDispatcher("/WEB-INF/views/user/profile/viewProfile.jsp").forward(request, response);
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.getRequestDispatcher("/WEB-INF/views/user/profile/updateProfile.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String phoneNumber = request.getParameter("phoneNumber");

            loggedInUser.setFullName(fullName);
            loggedInUser.setEmail(email);
            loggedInUser.setAddress(address);
            loggedInUser.setGender(gender);
            loggedInUser.setPhoneNumber(phoneNumber);
            if (password != null && !password.isEmpty()) {
                loggedInUser.setPassword(password); // Add hashing in production
            }

            userDAO.updateUser(loggedInUser);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void handleViewHouseholdInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/citizen/householdInfo.jsp").forward(request, response);
    }

    private void handleRegisterHouseholdMember(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.getRequestDispatcher("/WEB-INF/views/user/citizen/registerHouseholdMember.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String fullName = request.getParameter("fullName");
            String cccd = request.getParameter("cccd");
            String relationship = request.getParameter("relationship");

            // TODO: Save to database (e.g., HouseholdMembers table)
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void handleSubmitRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.getRequestDispatcher("/WEB-INF/views/user/citizen/submitRequest.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String requestType = request.getParameter("requestType");
            String description = request.getParameter("description");

            // TODO: Save to database (e.g., Requests table)
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void handleViewReports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/citizen/viewReports.jsp").forward(request, response);
    }

    private void handleViewAnnouncements(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/citizen/viewAnnouncements.jsp").forward(request, response);
    }

    private void handleTransferHousehold(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            // Lấy lịch sử chuyển hộ khẩu
            java.util.List<model.HouseholdTransfer> transferHistory = transferDAO.getTransferRequestsByUserId(loggedInUser.getUserId());
            request.setAttribute("transferHistory", transferHistory);
            request.getRequestDispatcher("/WEB-INF/views/user/citizen/transferHousehold.jsp").forward(request, response);
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String currentAddress = request.getParameter("currentAddress");
            String destinationAddress = request.getParameter("destinationAddress");
            String reason = request.getParameter("reason");
            model.HouseholdTransfer transfer = new model.HouseholdTransfer();
            transfer.setUserId(loggedInUser.getUserId());
            transfer.setCurrentAddress(currentAddress);
            transfer.setDestinationAddress(destinationAddress);
            transfer.setDestinationAreaId(0); // Không dùng, set mặc định
            transfer.setReason(reason);
            transfer.setStatus("Pending");
            transfer.setRequestDate(new java.util.Date());
            model.HouseholdTransfer result = transferDAO.createTransferRequest(transfer);
            if (result != null) {
                request.getSession().setAttribute("successMessage", "Transfer request submitted successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to submit transfer request. Please try again.");
            }
            response.sendRedirect(request.getContextPath() + "/citizen/transferHousehold");
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
        return "Handles all Citizen-specific actions";
    }
}
