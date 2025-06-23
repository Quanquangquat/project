/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dao.UserAvatarDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.user.UserDAO;
import java.util.UUID;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.http.Cookie;
import model.UserAvatar;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author quang
 */
public class LoginController extends HttpServlet {

    public static void main(String[] args) {
        String hash = BCrypt.hashpw("congan123", BCrypt.gensalt());
        System.out.println(hash);
    }
    UserDAO userDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        userDao = new UserDAO();

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Check for remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("rememberMe")) {
                    String token = cookie.getValue();
                    User user = userDao.getUserByToken(token);
                    if (user != null) {
                        // Valid token, log in the user automatically
                        session = request.getSession(true);
                        session.setAttribute("loggedInUser", user);
                        response.sendRedirect(request.getContextPath() + "/dashboard");
                        return;
                    }
                }
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        User user = userDao.getUserByEmail(email);

        try {
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Create session and set user attribute
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);

                // set avatar
                // Check if the user has an active avatar
                // Log household ID information
                if (user.getHouseholdId() != null) {
                    System.out.println("User " + user.getFullName() + " (ID: " + user.getUserId() + ") logged in with household ID: " + user.getHouseholdId());
                } else {
                    System.out.println("User " + user.getFullName() + " (ID: " + user.getUserId() + ") logged in WITHOUT a household ID");
                }

                // Handle remember me functionality
                if (rememberMe != null && rememberMe.equals("on")) {
                    // Generate a unique token
                    String token = UUID.randomUUID().toString();

                    // Save token in database
                    userDao.saveRememberMeToken(user.getUserId(), token);

                    // Create a cookie with the token
                    Cookie rememberMeCookie = new Cookie("rememberMe", token);
                    rememberMeCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                    rememberMeCookie.setPath("/");
                    response.addCookie(rememberMeCookie);
                }

                // Redirect to DashboardController to handle role-based dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
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
