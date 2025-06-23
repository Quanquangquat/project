package controller.dashboard;

import dao.AreaDAO;
import dao.HouseholdDAO;
import dao.RegistrationDAO;
import dao.UserAvatarDAO;
import dao.user.UserDAO;
import model.Area;
import model.User;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserAvatar;

@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

    private UserAvatarDAO avatarDao;

    private static final Logger LOGGER = Logger.getLogger(DashboardController.class.getName());
    private AreaDAO areaDAO;
    private HouseholdDAO householdDAO;
    private RegistrationDAO registrationDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        areaDAO = new AreaDAO();
        householdDAO = new HouseholdDAO();
        registrationDAO = new RegistrationDAO();
        userDAO = new UserDAO();
        avatarDao = new UserAvatarDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            // If user is not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the logged-in user
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String avatarPath = avatarDao.getOrSetDefaultAvatar(loggedInUser.getUserId());

        request.setAttribute("avatarPath", avatarPath);

        int roleId = loggedInUser.getRoleId();

        // Determine the appropriate dashboard based on roleId
        String dashboardPath = getDashboardPath(roleId);

        // Forward to the appropriate dashboard JSP
        request.getRequestDispatcher(dashboardPath).forward(request, response);
    }

    // Helper method to populate area leader dashboard data
    // Helper method to determine dashboard path based on roleId
    private String getDashboardPath(int roleId) {
        switch (roleId) {
            case 1: // Citizen
                return "/WEB-INF/views/user/citizen/citizenDashboard.jsp";
            case 2: // Area Leader
                return "/WEB-INF/views/user/areaLeader/areaLeaderDashboard.jsp";
            case 3: // Police
                return "/WEB-INF/views/user/police/policeDashboard.jsp";
            case 4: // Admin
                return "/WEB-INF/views/user/admin/adminDashboard.jsp";
            default:
                return "/WEB-INF/views/user/citizen/citizenDashboard.jsp"; // Default to citizen dashboard
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
        return "Redirects to the appropriate dashboard based on user role";
    }
}
