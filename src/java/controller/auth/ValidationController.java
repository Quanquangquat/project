package controller.auth;

import dao.user.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet for handling validation requests like email and CCCD duplication
 * checks
 */
@WebServlet(name = "ValidationController", urlPatterns = { "/validate/email", "/validate/cccd" })
public class ValidationController extends HttpServlet {

  private UserDAO userDAO;

  @Override
  public void init() throws ServletException {
    userDAO = new UserDAO();
  }

  /**
   * Handles GET requests for validation
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String path = request.getServletPath();

    // Set response type to JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    PrintWriter out = response.getWriter();

    try {
      switch (path) {
        case "/validate/email":
          validateEmail(request, response, out);
          break;
        case "/validate/cccd":
          validateCCCD(request, response, out);
          break;
        default:
          response.setStatus(HttpServletResponse.SC_NOT_FOUND);
          out.print("{\"error\": \"Invalid validation endpoint\"}");
      }
    } catch (Exception e) {
      e.printStackTrace(); // Log the exception to server logs
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      out.print("{\"error\": \"" + e.getMessage() + "\"}");
    } finally {
      out.flush();
    }
  }

  /**
   * Validates if an email already exists
   */
  private void validateEmail(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
    String email = request.getParameter("email");

    if (email == null || email.trim().isEmpty()) {
      response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
      out.print("{\"error\": \"Email parameter is required\"}");
      return;
    }

    boolean isDuplicate = userDAO.isEmailExists(email);
    out.print("{\"isDuplicate\": " + isDuplicate + "}");
  }

  /**
   * Validates if a CCCD already exists
   */
  private void validateCCCD(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
    String cccd = request.getParameter("cccd");

    if (cccd == null || cccd.trim().isEmpty()) {
      response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
      out.print("{\"error\": \"CCCD parameter is required\"}");
      return;
    }

    boolean isDuplicate = userDAO.isCCCDExists(cccd);
    out.print("{\"isDuplicate\": " + isDuplicate + "}");
  }
}