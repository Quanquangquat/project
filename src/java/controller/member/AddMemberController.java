package controller.member;

import dao.HouseholdDAO;
import dao.HouseholdMemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Household;
import model.HouseholdMember;

@WebServlet(name = "AddMemberController", urlPatterns = {"/household/registerMember", "/household/addMember"})
public class AddMemberController extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method. Displays the form to register a
     * new household member.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Always try to get householdId from session first
        String householdIdStr = getHouseholdIdFromSession(request);

        if (householdIdStr != null) {
            try {
                int householdId = Integer.parseInt(householdIdStr);

                // Get the household details
                HouseholdDAO householdDao = new HouseholdDAO();
                Household household = householdDao.getHouseholdById(householdId);

                if (household == null) {
                    request.setAttribute("error", "Household not found");
                    request.getRequestDispatcher("/dashboard").forward(request, response);
                    return;
                }

                // Set the household in the request
                request.setAttribute("household", household);

                // Forward to the registration form
                request.getRequestDispatcher("/WEB-INF/views/user/member/addHouseholdMember.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid household ID");
                request.getRequestDispatcher("/dashboard").forward(request, response);
            }
        } else {
            // If no household ID in session, redirect to dashboard
            request.setAttribute("error", "You don't have a household assigned to your account. Please contact an administrator or create a household first.");
            request.getRequestDispatcher("/dashboard").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method. Processes the form submission
     * to register a new household member.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String householdIdStr = request.getParameter("householdId");

        // If householdId is not in the request, try to get it from the session
        if (householdIdStr == null || householdIdStr.isEmpty()) {
            householdIdStr = getHouseholdIdFromSession(request);
            if (householdIdStr != null) {
            }
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String cccd = request.getParameter("cccd");
        String relationship = request.getParameter("relationship");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        // Validate required fields
        if (householdIdStr == null || householdIdStr.isEmpty()
                || fullName == null || fullName.isEmpty()
                || relationship == null || relationship.isEmpty()) {

            StringBuilder errorMsg = new StringBuilder("Required fields missing: ");
            if (householdIdStr == null || householdIdStr.isEmpty()) {
                errorMsg.append("Household ID, ");
            }
            if (fullName == null || fullName.isEmpty()) {
                errorMsg.append("Full Name, ");
            }
            if (relationship == null || relationship.isEmpty()) {
                errorMsg.append("Relationship, ");
            }
            // Remove trailing comma and space
            String error = errorMsg.substring(0, errorMsg.length() - 2);

            request.setAttribute("error", error);
            request.getRequestDispatcher("/dashboard").forward(request, response);
            return;
        }

        try {
            int householdId = Integer.parseInt(householdIdStr);

            // Check if the household exists
            HouseholdDAO householdDao = new HouseholdDAO();
            Household household = householdDao.getHouseholdById(householdId);

            if (household == null) {
                request.setAttribute("error", "Household not found");
                request.getRequestDispatcher("/dashboard").forward(request, response);
                return;
            }

            // Check if CCCD already exists (if provided)
            if (cccd != null && !cccd.isEmpty()) {
                HouseholdMemberDAO memberDao = new HouseholdMemberDAO();
                if (memberDao.isCCCDExists(cccd)) {
                    request.setAttribute("error", "Citizen ID (CCCD) already exists");
                    request.getRequestDispatcher("/dashboard").forward(request, response);
                    return;
                }
            }

            // Parse date of birth if provided
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dateOfBirth = sdf.parse(dateOfBirthStr);
                } catch (ParseException e) {
                }
            }

            // If relationship is "Other", use the specified relationship
            if ("Other".equals(relationship)) {
                String otherRelationship = request.getParameter("otherRelationship");
                if (otherRelationship != null && !otherRelationship.isEmpty()) {
                    relationship = otherRelationship;
                }
            }

            // Create the household member object
            HouseholdMember member = new HouseholdMember();
            member.setHouseholdId(householdId);
            member.setFullName(fullName);
            member.setRelationship(relationship);
            member.setDateOfBirth(dateOfBirth);
            member.setGender(gender);
            member.setPhoneNumber(phoneNumber);
            member.setEmail(email);
            member.setCccd(cccd);
            member.setCreatedDate(new Date());

            // Register the member
            HouseholdMemberDAO memberDao = new HouseholdMemberDAO();
            HouseholdMember registeredMember = memberDao.registerMember(member);

            if (registeredMember != null) {
                // Registration successful
                request.getSession().setAttribute("success", "Household member registered successfully");
                response.sendRedirect(request.getContextPath() + "/household/view?householdId=" + householdId);
            } else {
                // Registration failed
                request.getSession().setAttribute("error", "Failed to register household member");
                request.getRequestDispatcher("/dashboard").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid household ID");
            request.getRequestDispatcher("/dashboard").forward(request, response);
        } catch (Exception e) {
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
        return "Servlet for registering household members";
    }

    /**
     * Helper method to get the household ID from the session
     *
     * @param request The HTTP request
     * @return The household ID as a string, or null if not found
     */
    private String getHouseholdIdFromSession(HttpServletRequest request) {
        // Try to get the logged-in user from the session
        Object loggedInUserObj = request.getSession().getAttribute("loggedInUser");
        if (loggedInUserObj != null && loggedInUserObj instanceof model.User) {
            model.User loggedInUser = (model.User) loggedInUserObj;
            // Check if the user has a householdId and it's not null
            Integer householdId = loggedInUser.getHouseholdId();
            if (householdId != null && householdId > 0) {
                return String.valueOf(householdId);
            }
        }
        return null;
    }
}
