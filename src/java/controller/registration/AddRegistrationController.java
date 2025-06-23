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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import model.Registration;
import model.User;
import java.util.Date;
import model.TransferRegistration;
import model.RegistrationDocument;

/**
 *
 * @author quang
 */
@WebServlet(name = "AddRegistrationController", urlPatterns = {"/registration/add"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 20 * 1024 * 1024 // 20 MB
)
public class AddRegistrationController extends HttpServlet {

    private final int PENDING = 1;
    private final int APPROVED = 2;
    private final int REJECTED = 3;

    private RegistrationDAO registrationDao;
    private TransferRegistrationDAO transferRegistrationDaO;

    private RegistrationDocumentDAO registrationDocumentDaO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        registrationDao = new RegistrationDAO();
        transferRegistrationDaO = new TransferRegistrationDAO();
        registrationDocumentDaO = new RegistrationDocumentDAO();

        // Ensure the FileData column exists in the database
        ensureFileDataColumnExists();
    }

    /**
     * Ensures that the FileData column exists in the RegistrationDocuments
     * table
     */
    private void ensureFileDataColumnExists() {
        try {
            boolean columnExists = registrationDocumentDaO.ensureFileDataColumnExists();
            if (columnExists) {
                System.out.println("FileData column exists or was successfully created in the RegistrationDocuments table");
            } else {
                System.err.println("Failed to ensure FileData column exists in the RegistrationDocuments table");
            }
        } catch (Exception e) {
            System.err.println("Error checking FileData column: " + e.getMessage());
            e.printStackTrace();
        }
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
            out.println("<title>Servlet AddRegistrationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRegistrationController at " + request.getContextPath() + "</h1>");
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
        // Redirect to registration selection page
        response.sendRedirect(request.getContextPath() + "/registration/choose");
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
        try {
            // Get form data
            String registrationTypeIdStr = request.getParameter("registrationTypeId");

            try {
                int registrationTypeId = Integer.parseInt(registrationTypeIdStr);

                switch (registrationTypeId) {
                    case 1:
                        addTransferHousehold(request, response);
                        break;
                    case 2:
                        addSplitHousehold(request, response);
                        break;
                    case 3:
                        addRegisterIntoHousehold(request, response);
                        break;
                    default:
                        request.setAttribute("errorMessage", "Invalid registration type.");
                        request.getRequestDispatcher("/WEB-INF/views/registration/choose.jsp").forward(request, response);
                        break;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid registration type format.");
                request.getRequestDispatcher("/WEB-INF/views/registration/choose.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/registration/choose.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred.");
            request.getRequestDispatcher("/WEB-INF/views/registration/choose.jsp").forward(request, response);
        }
    }

    /**
     * Extracts file name from content-disposition header of the part
     */
    private String getFileName(Part part) {
        if (part == null) {
            return "";
        }

        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                // Return just the file name, not the whole path
                return fileName.substring(fileName.lastIndexOf('/') + 1)
                        .substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return "";
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    private void addTransferHousehold(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            String currentHouseholdId = request.getParameter("currentHouseholdId");
            String previousAddress = request.getParameter("previousAddress");

            // Get address names
            String provinceName = request.getParameter("provinceName");
            String districtName = request.getParameter("districtName");
            String wardName = request.getParameter("wardName");
            String houseNumber = request.getParameter("houseNumber");

            String moveDateStr = request.getParameter("moveDate");
            String reasonForTransfer = request.getParameter("reasonForTransfer");

            // Convert moveDate string to Date object
            Date moveDate = null;
            try {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                moveDate = sdf.parse(moveDateStr);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Invalid move date format. Please use YYYY-MM-DD format.");
                request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
                return;
            }

            // Get file information
            Part identityDocument = request.getPart("identityDocument");
            Part proofOfResidence = request.getPart("proofOfResidence");
            Part transferDocument = request.getPart("transferDocument");
            Part additionalDocument = request.getPart("additionalDocument");

            Date currentDate = new Date();
            String newAddress = houseNumber + ", " + wardName + ", " + districtName + ", " + provinceName;

            // Create and insert the registration
            Registration registration = new Registration(loggedInUser.getUserId(), Integer.parseInt(currentHouseholdId), 1, currentDate, reasonForTransfer, PENDING);
            Registration insertedRegistration = registrationDao.insertRegistration(registration);

            if (insertedRegistration == null) {
                request.setAttribute("errorMessage", "Failed to create registration. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
                return;
            }

            // Create and insert the transfer registration
            TransferRegistration transferRegistration = new TransferRegistration(
                    insertedRegistration.getRegistrationId(),
                    newAddress,
                    previousAddress,
                    reasonForTransfer,
                    moveDate);

            boolean transferSuccess = transferRegistrationDaO.insertTransferRegistration(transferRegistration);

            if (!transferSuccess) {
                request.setAttribute("errorMessage", "Failed to create transfer registration. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
                return;
            }

            // Process and save documents
            boolean documentsSuccess = processAndSaveDocuments(
                    insertedRegistration.getRegistrationId(),
                    identityDocument,
                    proofOfResidence,
                    transferDocument,
                    additionalDocument
            );

            if (!documentsSuccess) {
                request.setAttribute("errorMessage", "Failed to upload documents. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
                return;
            }

            // Success - redirect to success page or dashboard
            request.setAttribute("successMessage", "Transfer household registration submitted successfully!");
            response.sendRedirect(request.getContextPath() + "/registration/showAll");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/registration/types/transferHouseholdForm.jsp").forward(request, response);
        }
    }

    private boolean processAndSaveDocuments(int registrationId, Part identityDocument, Part proofOfResidence,
            Part transferDocument, Part additionalDocument) throws IOException {
        boolean allSuccessful = true;
        StringBuilder errorMessages = new StringBuilder();

        try {
            // Process identity document
            if (identityDocument != null && identityDocument.getSize() > 0) {
                try {
                    saveDocument(registrationId, identityDocument, "Identity Document", "User identity document");
                    System.out.println("Identity document processed successfully");
                } catch (Exception e) {
                    allSuccessful = false;
                    errorMessages.append("Error saving identity document: ").append(e.getMessage()).append("; ");
                    e.printStackTrace();
                }
            } else {
                System.err.println("Identity document is null or empty");
                allSuccessful = false;
                errorMessages.append("Identity document is missing; ");
            }

            // Process proof of residence
            if (proofOfResidence != null && proofOfResidence.getSize() > 0) {
                try {
                    saveDocument(registrationId, proofOfResidence, "Proof of Residence", "Proof of current residence");
                    System.out.println("Proof of residence document processed successfully");
                } catch (Exception e) {
                    allSuccessful = false;
                    errorMessages.append("Error saving proof of residence: ").append(e.getMessage()).append("; ");
                    e.printStackTrace();
                }
            } else {
                System.err.println("Proof of residence document is null or empty");
                allSuccessful = false;
                errorMessages.append("Proof of residence document is missing; ");
            }

            // Process transfer document
            if (transferDocument != null && transferDocument.getSize() > 0) {
                try {
                    saveDocument(registrationId, transferDocument, "Transfer Document", "Document supporting transfer reason");
                    System.out.println("Transfer document processed successfully");
                } catch (Exception e) {
                    allSuccessful = false;
                    errorMessages.append("Error saving transfer document: ").append(e.getMessage()).append("; ");
                    e.printStackTrace();
                }
            } else {
                System.err.println("Transfer document is null or empty");
                allSuccessful = false;
                errorMessages.append("Transfer document is missing; ");
            }

            // Process additional document (if provided)
            if (additionalDocument != null && additionalDocument.getSize() > 0) {
                try {
                    saveDocument(registrationId, additionalDocument, "Additional Document", "Additional supporting document");
                    System.out.println("Additional document processed successfully");
                } catch (Exception e) {
                    // Additional document is optional, so don't set allSuccessful to false
                    errorMessages.append("Error saving additional document: ").append(e.getMessage()).append("; ");
                    e.printStackTrace();
                }
            }

            if (!allSuccessful) {
                System.err.println("Document processing completed with errors: " + errorMessages.toString());
            } else {
                System.out.println("All documents processed successfully");
            }

            return allSuccessful;
        } catch (Exception e) {
            System.err.println("Unexpected error in processAndSaveDocuments: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void saveDocument(int registrationId, Part filePart, String documentType, String description) throws IOException {
        String fileName = getFileName(filePart);
        String contentType = filePart.getContentType();
        int fileSize = (int) filePart.getSize();

        System.out.println("Processing document: " + fileName + ", type: " + documentType + ", size: " + fileSize + " bytes");

        // Create a path for storing the file (you might want to customize this)
        String uploadPath = getServletContext().getRealPath("/uploads");

        // Ensure the upload directory exists
        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Created upload directory: " + uploadPath);
        }

        // Create a unique file name to avoid overwriting
        String uniqueFileName = registrationId + "_" + documentType.replaceAll("\\s+", "_") + "_" + System.currentTimeMillis() + "_" + fileName;
        String filePath = uploadPath + java.io.File.separator + uniqueFileName;

        // Read file data with proper buffer handling
        byte[] fileData = readAllBytes(filePart.getInputStream());
        System.out.println("Read " + fileData.length + " bytes from file");

        // Create the document object
        RegistrationDocument document = new RegistrationDocument(
                registrationId,
                documentType,
                filePath,
                fileName,
                fileSize,
                contentType,
                description
        );

        // Set the file data
        document.setFileData(fileData);

        // Save the file to disk
        try {
            filePart.write(filePath);
            System.out.println("File saved to disk at: " + filePath);
        } catch (Exception e) {
            System.err.println("Error saving file to disk: " + e.getMessage());
            e.printStackTrace();
            // Continue with database save even if file save fails
        }

        // Try using the addDocument method first as it's specifically designed to save file data
        boolean success = registrationDocumentDaO.addDocument(document);
        if (success) {
            System.out.println("Document saved to database using addDocument method");
        } else {
            System.err.println("Failed to save document using addDocument method, trying insertDocumentWithFileData");

            // Try using insertDocumentWithFileData as a fallback
            try (java.io.ByteArrayInputStream bais = new java.io.ByteArrayInputStream(fileData)) {
                success = registrationDocumentDaO.insertDocumentWithFileData(document, bais);
                if (success) {
                    System.out.println("Document saved to database using insertDocumentWithFileData method");
                } else {
                    System.err.println("Failed to save document using insertDocumentWithFileData method, trying insertDocument");

                    // Last resort, try the regular insertDocument method
                    RegistrationDocument savedDocument = registrationDocumentDaO.insertDocument(document);
                    if (savedDocument != null) {
                        System.out.println("Document saved to database with ID: " + savedDocument.getDocumentId());
                    } else {
                        System.err.println("Failed to save document to database using all available methods");
                    }
                }
            }
        }
    }

    /**
     * Reads all bytes from an input stream into a byte array. This method
     * handles large files efficiently.
     */
    private byte[] readAllBytes(java.io.InputStream inputStream) throws IOException {
        final int bufferSize = 8192;
        java.io.ByteArrayOutputStream outputStream = new java.io.ByteArrayOutputStream();
        byte[] buffer = new byte[bufferSize];
        int bytesRead;

        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }

        return outputStream.toByteArray();
    }

    private void addSplitHousehold(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void addRegisterIntoHousehold(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
