/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.registration;

import dao.RegistrationDAO;
import dao.TransferRegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletConfig;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Registration;
import model.TransferRegistration;
import model.User;

/**
 *
 * @author quang
 */
@WebServlet(name = "ShowAllRegistrationController", urlPatterns = {"/registration/showAll",})
public class ShowAllRegistrationController extends HttpServlet {

    private RegistrationDAO registrationDao;
    private TransferRegistrationDAO transferRegistrationDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        registrationDao = new RegistrationDAO();
        transferRegistrationDao = new TransferRegistrationDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShowRegistrationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowRegistrationController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        try {
            // Get the logged-in user from the session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("loggedInUser") == null) {
                // Redirect to login page if not logged in
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            User loggedInUser = (User) session.getAttribute("loggedInUser");

            // Get all registrations for the logged-in user
            List<Registration> userRegistrations = registrationDao.getRegistrationsByUserId(loggedInUser.getUserId());

            // Get transfer details for each registration
            List<TransferRegistration> transferDetails = new ArrayList<>();
            for (Registration reg : userRegistrations) {
                if (reg.getRegistrationTypeId() == 1) { // Transfer registration type
                    TransferRegistration transfer = transferRegistrationDao.getTransferRegistrationByRegistrationId(reg.getRegistrationId());
                    if (transfer != null) {
                        transferDetails.add(transfer);
                    }
                }
            }

            // Set attributes for the JSP
            request.setAttribute("registrations", userRegistrations);
            request.setAttribute("transferDetails", transferDetails);
            request.setAttribute("statusMap", getStatusMap());

            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/registration/showAllRegistrations.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving registrations: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/registration/showRegistrations.jsp").forward(request, response);
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
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteRegistration(request, response);
        } else {
            processRequest(request, response);
        }
    }

    private void deleteRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String registrationIdStr = request.getParameter("registrationId");
            if (registrationIdStr != null && !registrationIdStr.isEmpty()) {
                int registrationId = Integer.parseInt(registrationIdStr);

                // Check if the registration belongs to the logged-in user
                HttpSession session = request.getSession(false);
                User loggedInUser = (User) session.getAttribute("loggedInUser");

                Registration registration = registrationDao.getRegistrationById(registrationId);
                if (registration != null && registration.getUserId() == loggedInUser.getUserId()) {
                    boolean deleted = registrationDao.deleteRegistration(registrationId);
                    if (deleted) {
                        request.setAttribute("successMessage", "Registration deleted successfully.");
                    } else {
                        request.setAttribute("errorMessage", "Failed to delete registration.");
                    }
                } else {
                    request.setAttribute("errorMessage", "You do not have permission to delete this registration.");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid registration ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while deleting the registration: " + e.getMessage());
        }

        // Redirect back to the show registrations page
        response.sendRedirect(request.getContextPath() + "/registration/show");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private java.util.Map<Integer, String> getStatusMap() {
        java.util.Map<Integer, String> statusMap = new java.util.HashMap<>();
        statusMap.put(1, "Pending");
        statusMap.put(2, "Approved");
        statusMap.put(3, "Rejected");
        return statusMap;
    }
}
