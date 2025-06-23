package controller.api;

import dao.AddressDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * API Servlet to generate full address from ward code and house number
 */
@WebServlet(name = "FullAddressApiServlet", urlPatterns = {"/api/full-address"})
public class FullAddressApiServlet extends HttpServlet {

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
        response.setContentType("text/plain;charset=UTF-8");
        
        String wardCode = request.getParameter("wardCode");
        String houseNumber = request.getParameter("houseNumber");
        
        if (wardCode == null || wardCode.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Ward code is required");
            return;
        }
        
        // House number can be empty, but not null
        if (houseNumber == null) {
            houseNumber = "";
        }
        
        try {
            AddressDAO addressDAO = new AddressDAO();
            String fullAddress = addressDAO.getFullAddress(wardCode, houseNumber);
            addressDAO.closeConnection();
            
            if (fullAddress != null) {
                response.getWriter().write(fullAddress);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Could not generate full address");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "API Servlet to generate full address from ward code and house number";
    }
} 