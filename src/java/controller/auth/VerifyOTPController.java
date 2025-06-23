package controller.auth;

import dao.user.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author quang
 */
public class VerifyOTPController extends HttpServlet {

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
        // If user tries to access this page directly, redirect to forgot password
        response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
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
        String userOTP = request.getParameter("otp");
        HttpSession session = request.getSession();
        String storedOTP = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        // Check if OTP is valid
        if (storedOTP != null && userOTP != null && storedOTP.equals(userOTP)) {
            // OTP is valid, allow user to reset password
            session.setAttribute("otpVerified", true);

            // Redirect to reset password page
            request.getRequestDispatcher("/WEB-INF/views/auth/resetPassword.jsp").forward(request, response);

        } else {
            // Invalid OTP
            request.setAttribute("error", "Invalid verification code. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgotPassword.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for verifying OTP during password reset";
    }
}
