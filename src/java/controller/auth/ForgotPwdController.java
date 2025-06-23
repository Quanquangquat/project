/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dao.user.UserDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;
import model.User;

/**
 *
 * @author quang
 */
public class ForgotPwdController extends HttpServlet {

    UserDAO userDao;
    private static final int OTP_LENGTH = 6;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void init(ServletConfig config)
            throws ServletException {
        userDao = new UserDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPwdController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPwdController at " + request.getContextPath() + "</h1>");
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
        // Check if the request is for changing email
        String changeEmail = request.getParameter("changeEmail");
        if (changeEmail != null && changeEmail.equals("true")) {
            // Clear OTP and email from session to allow user to enter a new email
            HttpSession session = request.getSession();
            session.removeAttribute("otp");
            session.removeAttribute("email");
            session.removeAttribute("otpVerified");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/auth/forgotPassword.jsp").forward(request, response);
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

        String email = request.getParameter("email");
        User user = userDao.getUserByEmail(email);

        if (user != null) {
            // Generate OTP
            String otp = generateOTP();

            // Save OTP and email in the session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Send OTP to the user's email
            sendOTPEmail(email, otp);

            // Inform the user that OTP has been sent
            request.setAttribute("message", "An OTP has been sent to your email.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgotPassword.jsp").forward(request, response);
        } else {
            // User not found
            request.setAttribute("error", "Email not found.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgotPassword.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(random.nextInt(10));  // Generate a random digit between 0 and 9
        }
        return otp.toString();
    }

    private void sendOTPEmail(String email, String otp) throws ServletException {
        String subject = "Password Reset OTP";
        String body = "Your OTP for password reset is: " + otp;

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.debug", "true"); // Add this

        Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("quangkhoa5112@gmail.com", "cfqs zdsb brph jcaf");
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("quangkhoa5112@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            System.out.println("OTP email sent successfully!");
        } catch (MessagingException e) {
            throw new ServletException("Failed to send OTP email: " + e.getMessage(), e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
