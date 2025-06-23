package controller.household;

import dao.AreaDAO;
import dao.HouseholdDAO;
import dao.user.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Area;
import model.Household;
import model.User;

@WebServlet(name = "CreateHouseholdServlet", urlPatterns = {"/household/create"})
public class CreateHouseholdServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreateHouseholdServlet.class.getName());
    
    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the form to create a new household.
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
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the logged-in user
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Check if user already has a household
        if (loggedInUser.getHouseholdId() != null) {
            request.setAttribute("error", "You already have a household assigned to your account.");
            request.getRequestDispatcher("/dashboard").forward(request, response);
            return;
        }
        
        // Get all areas for the dropdown
        AreaDAO areaDao = new AreaDAO();
        List<Area> areas = areaDao.getAllAreas();
        request.setAttribute("areas", areas);
        
        // Forward to the create household form
        request.getRequestDispatcher("/WEB-INF/views/user/citizen/createHousehold.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes the form submission to create a new household.
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the logged-in user
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        // Check if user already has a household
        if (loggedInUser.getHouseholdId() != null) {
            request.setAttribute("error", "You already have a household assigned to your account.");
            request.getRequestDispatcher("/dashboard").forward(request, response);
            return;
        }
        
        // Get form parameters
        String address = request.getParameter("address");
        String areaIdStr = request.getParameter("areaId");
        
        // Validate required fields
        if (address == null || address.isEmpty() || areaIdStr == null || areaIdStr.isEmpty()) {
            request.setAttribute("error", "Address and Area are required fields.");
            
            // Get all areas for the dropdown
            AreaDAO areaDao = new AreaDAO();
            List<Area> areas = areaDao.getAllAreas();
            request.setAttribute("areas", areas);
            
            request.getRequestDispatcher("/WEB-INF/views/user/citizen/createHousehold.jsp").forward(request, response);
            return;
        }
        
        try {
            int areaId = Integer.parseInt(areaIdStr);
            
            // Create the household object
            Household household = new Household();
            household.setHeadOfHouseholdId(loggedInUser.getUserId());
            household.setAddress(address);
            household.setAreaId(areaId);
            household.setCreatedDate(new Date());
            
            // Insert the household
            HouseholdDAO householdDao = new HouseholdDAO();
            Household insertedHousehold = householdDao.insertHousehold(household);
            
            if (insertedHousehold != null) {
                // Update the user with the household ID
                loggedInUser.setHouseholdId(insertedHousehold.getHouseholdId());
                UserDAO userDao = new UserDAO();
                boolean updateSuccess = userDao.updateUser(loggedInUser);
                
                if (updateSuccess) {
                    // Update the session with the updated user
                    session.setAttribute("loggedInUser", loggedInUser);
                    
                    // Redirect to the household details page
                    response.sendRedirect(request.getContextPath() + "/household/details?id=" + insertedHousehold.getHouseholdId());
                } else {
                    request.setAttribute("error", "Failed to update user with household ID.");
                    request.getRequestDispatcher("/dashboard").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Failed to create household.");
                request.getRequestDispatcher("/dashboard").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid area ID.");
            request.getRequestDispatcher("/dashboard").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error creating household", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/dashboard").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for creating a new household";
    }
} 