/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.avatar;

import dao.UserAvatarDAO;
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
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.UUID;
import model.User;
import model.UserAvatar;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author quang
 */
@WebServlet(name = "AvatarController", urlPatterns = {"/avatar/update", "/avatar/delete", "/avatar/add", "/avatar/get"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 10 * 1024 * 1024, // 10 MB
        maxRequestSize = 50 * 1024 * 1024 // 50 MB
)
public class AvatarController extends HttpServlet {

    private final String DEFAULT_AVATAR_URL = "https://static.vecteezy.com/system/resources/previews/021/548/095/original/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg";

    private UserAvatarDAO avatarDao;

    private static final Logger LOGGER = Logger.getLogger(AvatarController.class.getName());

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
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/update"; // Default action
        }

        switch (pathInfo) {
            case "/update":
                updateAvatar(request, response);
                break;

            case "/get":
                getAvatar(request, response);
                break;

            case "/delete":
                deleteAvatar(request, response);
                break;

            default:
                // Handle unknown paths
                response.sendRedirect(request.getContextPath() + "/userprofile/view");
                return;
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
        processRequest(request, response);
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
        processRequest(request, response);
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

    private void updateAvatar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        System.out.println("Updating avatar for user ID: " + loggedInUser.getUserId());

        try {
            // Get the avatar URL from the form
            String avatarUrl = request.getParameter("avatarUrl");
            System.out.println("Received avatar URL: " + avatarUrl);

            // Remove any @ symbol at the beginning if present
            if (avatarUrl == null || avatarUrl.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Avatar URL cannot be empty.");
                response.sendRedirect(request.getContextPath() + "/userprofile/view");
                return;
            }

            // Basic URL validation
            if (!isValidImageUrl(avatarUrl)) {
                request.getSession().setAttribute("errorMessage", "Invalid image URL. Please provide a valid URL starting with http:// or https://");
                response.sendRedirect(request.getContextPath() + "/userprofile/view");
                return;
            }

            // Try to load the image to verify it's a valid image URL
            // Save the avatar information to the database
            UserAvatar avatar = new UserAvatar(loggedInUser.getUserId(), avatarUrl);
            System.out.println("Saving avatar URL to database: " + avatarUrl);

            UserAvatarDAO avatarDAO = new UserAvatarDAO();
            UserAvatar savedAvatar = avatarDAO.saveAvatar(avatar);

            if (savedAvatar != null) {
                // Set success message
                System.out.println("Avatar saved to database with ID: " + savedAvatar.getAvatarId());
                request.getSession().setAttribute("successMessage", "Avatar set successfully!");

                // delete old avatars
                avatarDAO.deleteInActiveAvatarByUserId(loggedInUser.getUserId());
            } else {
                // Set error message
                System.out.println("Failed to save avatar to database");
                request.getSession().setAttribute("errorMessage", "Failed to save avatar information.");
            }

            // Redirect back to profile page
            response.sendRedirect(request.getContextPath() + "/userprofile/view");

        } catch (Exception e) {
            System.out.println("Error setting avatar: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred while setting the avatar: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/userprofile/view");
        }
    }

    private boolean isValidImageUrl(String url) {
        // More flexible URL validation
        if (url == null || url.trim().isEmpty()) {
            return false;
        }

        // Check if it's a valid URL format
        try {
            new java.net.URL(url);
            return true;
        } catch (Exception e) {
            System.out.println("Invalid URL format: " + e.getMessage());
            return false;
        }
    }

    private String getAvatar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        UserAvatar avatar = avatarDao.getActiveAvatarByUserId(loggedInUser.getUserId());

        if (avatar != null) {
            request.setAttribute("hasAvatar", true);
        } else {
            request.setAttribute("hasAvatar", false);

        }

        String avatarPath = avatar.getAvatarPath();

        return avatarPath;

    }

    private void deleteAvatar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        avatarDao.deleteAvatarByUserId(loggedInUser.getUserId());

        response.sendRedirect(request.getContextPath() + "/userprofile/view");
    }

}
