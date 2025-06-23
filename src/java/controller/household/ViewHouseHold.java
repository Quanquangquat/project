package controller.household;

import dao.HouseholdDAO;
import dao.HouseholdMemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Household;
import model.HouseholdMember;

@WebServlet(name = "HouseholdDetailsServlet", urlPatterns = {"/household/view"})
public class ViewHouseHold extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method. Displays the household details
     * and list of members.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the household ID from the request
        String householdIdStr = request.getParameter("householdId");

        if (householdIdStr == null || householdIdStr.isEmpty()) {
            request.setAttribute("error", "Household ID is required");
            request.getRequestDispatcher("/dashboard").forward(request, response);
            return;
        }

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

            // Get the household members
            HouseholdMemberDAO memberDao = new HouseholdMemberDAO();
            List<HouseholdMember> members = memberDao.getMembersByHouseholdId(householdId);

            // Set attributes for the JSP
            request.setAttribute("household", household);
            request.setAttribute("members", members);

            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/user/household/householdDetails.jsp").forward(request, response);

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
        return "Servlet for displaying household details";
    }
}
