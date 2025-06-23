package controller.registration;

import dao.RegistrationDAO;
import dao.RegistrationDocumentDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Registration;
import model.RegistrationDocument;
import model.User;

/**
 * Controller for viewing documents attached to a registration
 */
@WebServlet(name = "ViewDocumentsController", urlPatterns = {"/registration/documents"})
public class ViewDocumentsController extends HttpServlet {

    private RegistrationDAO registrationDao;
    private RegistrationDocumentDAO documentDao;

    @Override
    public void init() throws ServletException {
        super.init();
        registrationDao = new RegistrationDAO();
        documentDao = new RegistrationDocumentDAO();
    }

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

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Check if user is logged in
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get registration ID from request
            String registrationIdParam = request.getParameter("id");
            if (registrationIdParam == null || registrationIdParam.isEmpty()) {
                request.setAttribute("errorMessage", "Registration ID is required");
                request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);
                return;
            }

            int registrationId = Integer.parseInt(registrationIdParam);

            // Get registration details
            Registration registration = registrationDao.getRegistrationById(registrationId);

            // Check if registration exists
            if (registration == null) {
                request.setAttribute("errorMessage", "Registration not found");
                request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);
                return;
            }

            // Check if registration belongs to logged-in user
            if (registration.getUserId() != loggedInUser.getUserId()) {
                request.setAttribute("errorMessage", "You do not have permission to view these documents");
                request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);
                return;
            }

            // Get documents for this registration
            List<RegistrationDocument> documents = documentDao.getDocumentsByRegistrationId(registrationId);

            // Set attributes for JSP
            request.setAttribute("registration", registration);
            request.setAttribute("documents", documents);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid registration ID");
            request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error retrieving documents: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/registration/viewDocuments.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method for downloading a document.
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

        try {
            // Get document ID from request
            String documentIdParam = request.getParameter("documentId");
            if (documentIdParam == null || documentIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Document ID is required");
                return;
            }

            int documentId = Integer.parseInt(documentIdParam);

            // Get document details
            RegistrationDocument document = documentDao.getDocumentById(documentId);

            // Check if document exists
            if (document == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Document not found");
                return;
            }

            // Get registration to check ownership
            Registration registration = registrationDao.getRegistrationById(document.getRegistrationId());

            // Check if registration belongs to logged-in user
            if (registration.getUserId() != loggedInUser.getUserId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to download this document");
                return;
            }

            // Set response headers for file download
            response.setContentType(document.getContentType());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + document.getFileName() + "\"");

            // Write file data to response
            if (document.getFileData() != null) {
                response.getOutputStream().write(document.getFileData());
            } else {
                // If file data is not in database, try to read from disk
                // This would need implementation based on your file storage strategy
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Document data not found");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid document ID");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error downloading document: " + e.getMessage());
        }
    }
}
