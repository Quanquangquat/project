package controller.auth;

import dao.AreaDAO;
import dao.HouseholdDAO;
import dao.user.UserDAO;
import dao.AddressDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Area;
import model.Household;
import model.User;
import model.Province;
import model.District;
import model.Ward;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegisterController extends HttpServlet {

    UserDAO userDao;
    HouseholdDAO householdDao;
    AreaDAO areaDao;
    AddressDAO addressDao;
    String defaultRole; // Store default role here
    private static final Logger LOGGER = Logger.getLogger(RegisterController.class.getName());

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        userDao = new UserDAO();
        householdDao = new HouseholdDAO();
        areaDao = new AreaDAO();
        addressDao = new AddressDAO();

        // Retrieve the default role from the init parameters
        this.defaultRole = config.getInitParameter("defaultRole");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");  // Password entered by the user
        String houseNumber = request.getParameter("houseNumber");
        String cccd = request.getParameter("cccd");

        // Get the new fields
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        // Get area information from the address
        String provinceCode = request.getParameter("provinceCode");
        String districtCode = request.getParameter("districtCode");
        String wardCode = request.getParameter("wardCode");

        // Get the names directly from the form
        String provinceName = request.getParameter("provinceName");
        String districtName = request.getParameter("districtName");
        String wardName = request.getParameter("wardName");

        // Log the received names
        LOGGER.info("Received province name: " + provinceName);
        LOGGER.info("Received district name: " + districtName);
        LOGGER.info("Received ward name: " + wardName);

        // Construct the full address using names
        String fullAddress = houseNumber + ", " + wardName + ", " + districtName + ", " + provinceName;

        // Log the full address
        LOGGER.info("Constructed full address with names: " + fullAddress);

        // Hash the password using bcrypt before saving it
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try {
            // First, create a user without a household
            User newUser = new User(0, fullName, email, hashedPassword, Integer.parseInt(defaultRole), fullAddress, cccd);

            // Set the new fields
            newUser.setGender(gender);
            newUser.setPhoneNumber(phoneNumber);

            User insertedUser = userDao.insertUser(newUser);

            if (insertedUser != null) {
                LOGGER.info("User created successfully with ID: " + insertedUser.getUserId());

                // Get or create an area based on the selected location codes
                Area area = null;

                if (provinceCode != null && districtCode != null) {
                    // Use the getOrCreateArea method to handle duplicates
                    if (wardName == null || wardName.isEmpty()) {
                        wardName = "";
                    }
                    area = areaDao.getOrCreateArea(provinceName, districtName, wardName);

                }

                // If area is still null, log the error but continue with registration
                if (area == null) {
                    LOGGER.warning("Failed to get or create area. Creating household without area.");
                }

                // Create a household for the user
                Household household = new Household();
                household.setHeadOfHouseholdId(insertedUser.getUserId());
                household.setAddress(fullAddress);
                household.setCreatedDate(new Date());

                // Set the area ID if an area was found
                if (area != null) {
                    household.setAreaId(area.getAreaId());
                    LOGGER.info("Setting household area ID to: " + area.getAreaId());
                }

                // Insert the household
                Household insertedHousehold = householdDao.insertHousehold(household);

                if (insertedHousehold != null) {
                    LOGGER.info("Household created successfully with ID: " + insertedHousehold.getHouseholdId());

                    // Update the user with the household ID
                    insertedUser.setHouseholdId(insertedHousehold.getHouseholdId());
                    boolean updateSuccess = userDao.updateUser(insertedUser);

                    if (updateSuccess) {
                        LOGGER.info("User updated successfully with household ID: " + insertedHousehold.getHouseholdId());
                    } else {
                        LOGGER.severe("Failed to update user with household ID. User ID: " + insertedUser.getUserId() + ", Household ID: " + insertedHousehold.getHouseholdId());
                        // Try one more time
                        updateSuccess = userDao.updateUser(insertedUser);
                        if (updateSuccess) {
                            LOGGER.info("User updated successfully on second attempt with household ID: " + insertedHousehold.getHouseholdId());
                        } else {
                            LOGGER.severe("Failed to update user with household ID on second attempt");
                        }
                    }

                    // Set the session
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedInUser", insertedUser);

                    // Redirect to DashboardController to handle role-based dashboard
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else {
                    LOGGER.severe("Failed to create household for user ID: " + insertedUser.getUserId());

                    // If household creation fails, still allow the user to log in
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedInUser", insertedUser);
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
            } else {
                LOGGER.warning("Failed to create user. Email or CCCD may already exist.");
                request.setAttribute("error", "Registration failed. Email or CCCD may already exist.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Registration failed with exception: " + e.getMessage(), e);
            e.printStackTrace();
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
