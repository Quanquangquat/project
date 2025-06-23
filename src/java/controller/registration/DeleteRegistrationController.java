/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.registration;

import dao.RegistrationDAO;
import dao.RegistrationDocumentDAO;
import dao.TransferRegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletConfig;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Registration;
import model.User;

/**
 *
 * @author quang
 */
@WebServlet(name = "DeleteRegistrationController", urlPatterns = {"/registration/delete"})
public class DeleteRegistrationController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DeleteRegistrationController.class.getName());
    private RegistrationDAO registrationDAO;
    private RegistrationDocumentDAO documentDAO;
    private TransferRegistrationDAO transferDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        registrationDAO = new RegistrationDAO();
        documentDAO = new RegistrationDocumentDAO();
        transferDAO = new TransferRegistrationDAO();
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
            out.println("<title>Servlet DeleteRegistrationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteRegistrationController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method for deleting a registration.
     * This method is used when deleting from the admin view.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method for deleting a registration.
     * This method is used when deleting from the user's own registrations view.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Check if user is logged in
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String registrationIdParam = request.getParameter("registrationId");

        if (registrationIdParam == null || registrationIdParam.isEmpty()) {
            session.setAttribute("errorMessage", "Registration ID is required");
            response.sendRedirect(request.getContextPath() + "/registration/showAll");
            return;
        }

        try {
            int registrationId = Integer.parseInt(registrationIdParam);

            boolean success = registrationDAO.deleteRegistration(registrationId);

            if (success) {

                request.getSession().setAttribute("success", "Registration deleted succesfully");

            } else {
                request.getSession().setAttribute("error", "Registratioin delete unsuccesfully");
            }
            // Get the registration to check if it exists and belongs to the user
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/registration/showAll");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for deleting registration requests";
    }// </editor-fold>

}
