package controller.user;

import dao.AreaDAO;
import dao.HouseholdDAO;
import dao.RegistrationDAO;
import dao.RegistrationStatusDAO;
import dao.RegistrationTypeDAO;
import dao.RegistrationVerificationDAO;
import dao.user.UserDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import model.Area;
import model.Registration;
import model.RegistrationStatus;
import model.RegistrationType;
import model.User;

@WebServlet(name = "PoliceController", urlPatterns = {
    "/police/dashboard",
    "/police/households",
    "/police/incidents",
    "/police/citizens",
    "/police/reports",
    "/police/calendar"
})
public class PoliceController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PoliceController.class.getName());

    private RegistrationDAO registrationDAO;
    private RegistrationVerificationDAO verificationDAO;
    private RegistrationTypeDAO registrationTypeDAO;
    private RegistrationStatusDAO statusDAO;
    private HouseholdDAO householdDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        registrationDAO = new RegistrationDAO();
        verificationDAO = new RegistrationVerificationDAO();
        registrationTypeDAO = new RegistrationTypeDAO();
        statusDAO = new RegistrationStatusDAO();
        householdDAO = new HouseholdDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Check if user has police role
        if (loggedInUser.getRoleId() != 3) { // 3 = Police role
            request.setAttribute("error", "You do not have permission to access this page");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }

        String path = request.getServletPath();

        switch (path) {

            case "/police/households":
                showHouseholds(request, response, loggedInUser);
                break;

            case "/police/reports":
                showReports(request, response, loggedInUser);
                break;
            case "/police/calendar":
                showCalendar(request, response, loggedInUser);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    /**
     * Show the police dashboard
     *
     * @param request The HTTP request
     * @param response The HTTP response
     * @param loggedInUser The logged-in user
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException If an I/O error occurs
     */
    /**
     * Get recent incidents (placeholder method)
     *
     * @return List of incident data
     */
    private List<Map<String, Object>> getRecentIncidents() {
        List<Map<String, Object>> incidents = new ArrayList<>();

        // Placeholder data - in a real implementation, this would come from a database
        Map<String, Object> incident1 = new HashMap<>();
        incident1.put("id", 1);
        incident1.put("title", "Noise complaint");
        incident1.put("location", "123 Main St");
        incident1.put("date", new Date());
        incident1.put("status", "Resolved");
        incident1.put("description", "Neighbors reported loud music after 11 PM");
        incidents.add(incident1);

        Map<String, Object> incident2 = new HashMap<>();
        incident2.put("id", 2);
        incident2.put("title", "Suspicious activity");
        incident2.put("location", "456 Oak Ave");
        incident2.put("date", new Date());
        incident2.put("status", "Under investigation");
        incident2.put("description", "Unknown individuals seen around vacant property");
        incidents.add(incident2);

        return incidents;
    }

    /**
     * Get upcoming events (placeholder method)
     *
     * @return List of event data
     */
    private List<Map<String, Object>> getUpcomingEvents() {
        List<Map<String, Object>> events = new ArrayList<>();

        // Placeholder data - in a real implementation, this would come from a database
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 2);

        Map<String, Object> event1 = new HashMap<>();
        event1.put("id", 1);
        event1.put("title", "Community Meeting");
        event1.put("date", cal.getTime());
        event1.put("location", "Town Hall");
        event1.put("description", "Monthly community safety discussion");
        events.add(event1);

        cal.add(Calendar.DAY_OF_MONTH, 5);
        Map<String, Object> event2 = new HashMap<>();
        event2.put("id", 2);
        event2.put("title", "Safety Workshop");
        event2.put("date", cal.getTime());
        event2.put("location", "Community Center");
        event2.put("description", "Workshop on household safety measures");
        events.add(event2);

        return events;
    }

    // Placeholder methods for other pages
    private void showHouseholds(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/police/households.jsp").forward(request, response);
    }

    private void showIncidents(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/police/incidents.jsp").forward(request, response);
    }

    private void showCitizens(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/police/citizens.jsp").forward(request, response);
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/police/reports.jsp").forward(request, response);
    }

    private void showCalendar(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/police/calendar.jsp").forward(request, response);
    }
}
