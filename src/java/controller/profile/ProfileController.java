/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.profile;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import model.User;
import dao.UserAvatarDAO;
import model.UserAvatar;
import dao.user.UserDAO;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author quang
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/userprofile/*"})

public class ProfileController extends HttpServlet {

    private final String DEFAULT_AVATAR_URL = "https://static.vecteezy.com/system/resources/previews/021/548/095/original/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg";
    private UserAvatarDAO avatarDao;

    @Override
    public void init(ServletConfig config) throws ServletException {

        avatarDao = new UserAvatarDAO();
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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
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

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/view"; // Default action
        }

        switch (pathInfo) {
            case "/view":
                // Handle view profile
                viewProfile(request, response);
                break;

            case "/update":
                // Handle update profile action
                updateProfile(request, response);
                break;

            default:
                // Handle unknown paths
                response.sendRedirect(request.getContextPath() + "/userprofile/view");
                return;
        }

    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // Get the logged-in user
        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Check if the user has an active avatar

            String avatarPath = avatarDao.getOrSetDefaultAvatar(loggedInUser.getUserId());

            request.setAttribute("avatarPath", avatarPath);

        }

        // Forward to the view profile JSP page
        request.getRequestDispatcher("/WEB-INF/views/user/profile/viewProfile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Check if the user has an active avatar
            UserAvatarDAO avatarDAO = new UserAvatarDAO();
            UserAvatar avatar = avatarDAO.getActiveAvatarByUserId(loggedInUser.getUserId());

            // Set a flag indicating whether the user has an avatar
            request.setAttribute("hasAvatar", avatar != null);
        }
        request.getRequestDispatcher("/WEB-INF/views/user/profile/updateProfile.jsp").forward(request, response);
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
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/view"; // Default action
        }

        switch (pathInfo) {
            case "/update":
                // Handle profile update submission
                handleProfileUpdate(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/userprofile/view");
                return;
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");
        if (loggedInUser != null) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String phoneNumber = request.getParameter("phoneNumber");

            loggedInUser.setFullName(fullName);
            loggedInUser.setEmail(email);
            loggedInUser.setAddress(address);
            loggedInUser.setGender(gender);
            loggedInUser.setPhoneNumber(phoneNumber);
            if (password != null && !password.isEmpty()) {
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                loggedInUser.setPassword(hashedPassword); // Add hashing in production
            }

            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(loggedInUser);

            // Set success message
            request.getSession().setAttribute("successMessage", "Profile updated successfully.");

            // Redirect to profile view
            response.sendRedirect(request.getContextPath() + "/userprofile/view");
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
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

}
