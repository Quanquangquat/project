package controller.registration;

import dao.RegistrationTypeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.RegistrationType;
import model.User;
import dao.HouseholdDAO;
import model.Household;

/**
 *
 * @author quang
 */
@WebServlet(name = "ChooseRegistrationsController", urlPatterns = {"/registration/choose"})
public class ChooseRegistrationsController extends HttpServlet {

    private RegistrationTypeDAO registrationTypeDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        registrationTypeDAO = new RegistrationTypeDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get all registration types from the database
            List<RegistrationType> registrationTypes = registrationTypeDAO.getAllRegistrationTypes();

            // Set registration types as a request attribute
            request.setAttribute("registrationTypes", registrationTypes);

            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/views/registration/chooseRegistrations.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            System.err.println("Error retrieving registration types: " + e.getMessage());
            e.printStackTrace();

            // Set error message
            request.setAttribute("errorMessage", "An error occurred while retrieving registration types. Please try again later.");

            // Forward to error page or back to dashboard
            request.getRequestDispatcher("/dashboard").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String registrationTypeIdStr = request.getParameter("registrationTypeId");

        try {
            int registrationTypeId = Integer.parseInt(registrationTypeIdStr);

            // Get the selected registration type from the database
            RegistrationType selectedRegistrationType = registrationTypeDAO.getRegistrationTypeById(registrationTypeId);

            if (selectedRegistrationType == null) {
                request.setAttribute("errorMessage", "Invalid registration type selected.");
                request.getRequestDispatcher("/WEB-INF/views/registration/chooseRegistrations.jsp").forward(request, response);
                return;
            }

            // Set the selected registration type as a request attribute
            request.setAttribute("selectedRegistrationType", selectedRegistrationType);

            // Forward to the appropriate form based on registration type
            switch (registrationTypeId) {
                case 1: // Transfer Household

                    // Get the user's current household
                    HouseholdDAO householdDAO = new HouseholdDAO();
                    Household currentHousehold = householdDAO.getHouseholdById(loggedInUser.getHouseholdId());

                    if (currentHousehold != null) {
                        request.setAttribute("currentHousehold", currentHousehold);
                    }

                    request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
                    break;

                case 2: // Split Household
                    // Check if user has a household

                    request.getRequestDispatcher("/WEB-INF/views/registration/types/splitHouseholdForm.jsp").forward(request, response);
                    break;

                case 3: // Register Into Household
                    request.getRequestDispatcher("/WEB-INF/views/registration/types/registerIntoHouseholdForm.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("errorMessage", "Invalid registration type selected.");
                    request.getRequestDispatcher("/WEB-INF/views/registration/chooseRegistrations.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for choosing registration types";
    }
}
