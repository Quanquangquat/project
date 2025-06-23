/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dao.user.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author quang
 */
public class ResetPasswordController extends HttpServlet {

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDAO();
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
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");

        // Only allow access if OTP has been verified
        if (otpVerified != null && otpVerified) {
            request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);
        } else {
            // Redirect to forgot password page if OTP not verified
            response.sendRedirect(request.getContextPath() + "/forgot-password");
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
        HttpSession session = request.getSession();
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        String email = (String) session.getAttribute("email");

        // Only proceed if OTP has been verified
        if (otpVerified != null && otpVerified && email != null) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate passwords
            if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);
                return;
            }

            // Validate password strength
            if (!isPasswordStrong(newPassword)) {
                request.setAttribute("error", "Password must be at least 8 characters long and contain uppercase, lowercase, and numbers.");
                request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);
                return;
            }

            // Get user by email
            User user = userDao.getUserByEmail(email);
            if (user != null) {
                // Hash the new password
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                // Update password in database
                boolean updated = userDao.updatePassword(user.getUserId(), hashedPassword);

                if (updated) {
                    // Clear session attributes
                    session.removeAttribute("otp");
                    session.removeAttribute("email");
                    session.removeAttribute("otpVerified");

                    // Set success message and redirect to login
                    request.setAttribute("message", "Password has been reset successfully. You can now login with your new password.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to update password. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "User not found. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);
            }
        } else {
            // Redirect to forgot password page if OTP not verified
            response.sendRedirect(request.getContextPath() + "/forgot-password");
        }
    }

    /**
     * Validates password strength
     *
     * @param password The password to validate
     * @return true if password meets requirements, false otherwise
     */
    private boolean isPasswordStrong(String password) {
        // Password must be at least 8 characters long
        if (password.length() < 8) {
            return false;
        }

        // Password must contain at least one uppercase letter
        if (!password.matches(".*[A-Z].*")) {
            return false;
        }

        // Password must contain at least one lowercase letter
        if (!password.matches(".*[a-z].*")) {
            return false;
        }

        // Password must contain at least one number
        if (!password.matches(".*[0-9].*")) {
            return false;
        }

        return true;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for handling password reset";
    }
}
