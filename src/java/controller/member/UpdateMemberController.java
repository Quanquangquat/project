package controller.member;

import dao.HouseholdMemberDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.HouseholdMember;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UpdateMemberController", urlPatterns = {"/household/updateMember"})
public class UpdateMemberController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateMemberController.class.getName());
    private HouseholdMemberDAO memberDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        memberDAO = new HouseholdMemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String memberIdStr = request.getParameter("memberId");

        if (memberIdStr == null || memberIdStr.isEmpty()) {
            request.setAttribute("error", "Member ID is required");
            request.getRequestDispatcher("/dashboard").forward(request, response);
            return;
        }

        try {
            int memberId = Integer.parseInt(memberIdStr);
            HouseholdMember member = memberDAO.getMemberById(memberId);

            if (member == null) {
                request.setAttribute("error", "Member not found");
                request.getRequestDispatcher("/dashboard").forward(request, response);
                return;
            }

            request.setAttribute("member", member);
            request.getRequestDispatcher("/WEB-INF/views/user/member/updateHouseHoldMember.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid member ID format", e);
            request.setAttribute("error", "Invalid member ID format");
            request.getRequestDispatcher("/dashboard").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String memberIdStr = request.getParameter("memberId");
        String householdIdStr = request.getParameter("householdId");
        String fullName = request.getParameter("fullName");
        String relationship = request.getParameter("relationship");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String cccd = request.getParameter("cccd");

        // Validate required fields
        if (memberIdStr == null || memberIdStr.isEmpty()
                || householdIdStr == null || householdIdStr.isEmpty()
                || fullName == null || fullName.isEmpty()
                || relationship == null || relationship.isEmpty()) {

            request.setAttribute("error", "Required fields missing");
            request.getRequestDispatcher("/WEB-INF/views/user/member/updateHouseHoldMember.jsp").forward(request, response);
            return;
        }

        try {
            int memberId = Integer.parseInt(memberIdStr);
            int householdId = Integer.parseInt(householdIdStr);

            // Get the existing member to check if it exists
            HouseholdMember existingMember = memberDAO.getMemberById(memberId);
            if (existingMember == null) {
                request.setAttribute("error", "Member not found");
                request.getRequestDispatcher("/dashboard").forward(request, response);
                return;
            }

            // If relationship is "Other", use the specified relationship
            if ("Other".equals(relationship)) {
                String otherRelationship = request.getParameter("otherRelationship");
                if (otherRelationship != null && !otherRelationship.isEmpty()) {
                    relationship = otherRelationship;
                }
            }

            // Parse date of birth if provided
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dateOfBirth = sdf.parse(dateOfBirthStr);
                } catch (ParseException e) {
                    LOGGER.log(Level.WARNING, "Invalid date format", e);
                }
            }

            // Create the updated member object
            HouseholdMember updatedMember = new HouseholdMember();
            updatedMember.setMemberId(memberId);
            updatedMember.setHouseholdId(householdId);
            updatedMember.setFullName(fullName);
            updatedMember.setRelationship(relationship);
            updatedMember.setDateOfBirth(dateOfBirth);
            updatedMember.setGender(gender);
            updatedMember.setPhoneNumber(phoneNumber);
            updatedMember.setEmail(email);
            updatedMember.setCccd(cccd);
            updatedMember.setCreatedDate(existingMember.getCreatedDate()); // Preserve the original creation date

            // Update the member
            boolean updated = memberDAO.updateMember(updatedMember);

            if (updated) {
                // Update successful
                request.getSession().setAttribute("success", "Household member updated successfully");
                response.sendRedirect(request.getContextPath() + "/household/view?householdId=" + householdId);

            } else {
                // Update failed
                request.getSession().setAttribute("error", "Failed to update household member");
                request.setAttribute("member", updatedMember);
                request.getRequestDispatcher("/WEB-INF/views/user/member/updateHouseHoldMember.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid ID format", e);
            request.setAttribute("error", "Invalid ID format");
            request.getRequestDispatcher("/WEB-INF/views/user/member/updateHouseHoldMember.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating household member", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/member/updateHouseHoldMember.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating household members";
    }
}
