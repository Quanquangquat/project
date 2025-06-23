package controller.member;

import dao.HouseholdMemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "DeleteMemberController", urlPatterns = {"/household/deleteMember"})
public class DeleteMemberController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DeleteMemberController.class.getName());

    /**
     * Handles the HTTP <code>POST</code> method. Processes the request to
     * remove a household member.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters
        String memberIdStr = request.getParameter("memberId");
        String householdIdStr = request.getParameter("householdId");

        if (memberIdStr == null || memberIdStr.isEmpty() || householdIdStr == null || householdIdStr.isEmpty()) {
            request.setAttribute("error", "Member ID and Household ID are required");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            int memberId = Integer.parseInt(memberIdStr);
            int householdId = Integer.parseInt(householdIdStr);

            // Delete the member
            HouseholdMemberDAO memberDao = new HouseholdMemberDAO();
            boolean success = memberDao.deleteMember(memberId);

            if (success) {
                // Redirect to household details with success message
                request.getSession().setAttribute("success", "Member removed successfully");
            } else {
                // Redirect to household details with error message
                request.getSession().setAttribute("error", "Failed to remove member");
            }

            response.sendRedirect(request.getContextPath() + "/household/view?householdId=" + householdId);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid ID format", e);
            request.getSession().setAttribute("error", "Invalid ID format");
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error removing household member", e);
            request.getSession().setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for removing household members";
    }
}
