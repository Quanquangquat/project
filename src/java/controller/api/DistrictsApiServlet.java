package controller.api;

import com.google.gson.Gson;
import dao.AddressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.District;

/**
 * API Servlet to get districts by province code
 */
@WebServlet(name = "DistrictsApiServlet", urlPatterns = {"/api/districts"})
public class DistrictsApiServlet extends HttpServlet {

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
        response.setContentType("application/json;charset=UTF-8");
        
        String provinceCode = request.getParameter("provinceCode");
        
        if (provinceCode == null || provinceCode.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Province code is required\"}");
            return;
        }
        
        try (PrintWriter out = response.getWriter()) {
            AddressDAO addressDAO = new AddressDAO();
            List<District> districts = addressDAO.getDistrictsByProvinceCode(provinceCode);
            addressDAO.closeConnection();
            
            Gson gson = new Gson();
            String json = gson.toJson(districts);
            out.write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "API Servlet to get districts by province code";
    }
} 