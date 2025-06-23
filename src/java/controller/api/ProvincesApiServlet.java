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
import model.Province;

/**
 * API Servlet to get all provinces
 */
@WebServlet(name = "ProvincesApiServlet", urlPatterns = {"/api/provinces"})
public class ProvincesApiServlet extends HttpServlet {

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
        System.out.println("ProvincesApiServlet: doGet method called");
        response.setContentType("application/json;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            System.out.println("ProvincesApiServlet: Creating AddressDAO");
            AddressDAO addressDAO = new AddressDAO();
            System.out.println("ProvincesApiServlet: Calling getAllProvinces");
            List<Province> provinces = addressDAO.getAllProvinces();
            System.out.println("ProvincesApiServlet: Got " + provinces.size() + " provinces");
            addressDAO.closeConnection();
            
            System.out.println("ProvincesApiServlet: Converting to JSON");
            Gson gson = new Gson();
            String json = gson.toJson(provinces);
            System.out.println("ProvincesApiServlet: JSON length: " + json.length());
            out.write(json);
            System.out.println("ProvincesApiServlet: Response sent successfully");
        } catch (Exception e) {
            System.err.println("ProvincesApiServlet ERROR: " + e.getMessage());
            e.printStackTrace();
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
        return "API Servlet to get all provinces";
    }
} 