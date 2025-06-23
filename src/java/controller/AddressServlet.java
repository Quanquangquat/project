package controller;

import com.google.gson.Gson;
import dao.AddressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Province;
import model.District;
import model.Ward;

@WebServlet(name = "AddressServlet", urlPatterns = {"/address", "/address/*"})
public class AddressServlet extends HttpServlet {

    private final AddressDAO addressDAO = new AddressDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();

        System.out.println("AddressServlet: Request received for path: " + (pathInfo == null ? "/" : pathInfo));

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all provinces
                System.out.println("AddressServlet: Fetching all provinces");
                List<Province> provinces = addressDAO.getAllProvinces();
                System.out.println("AddressServlet: Provinces fetched: " + (provinces != null ? provinces.size() : "null"));

                if (provinces != null && !provinces.isEmpty()) {
                    String json = gson.toJson(provinces);
                    System.out.println("AddressServlet: Returning JSON with " + provinces.size() + " provinces");
                    out.println(json);
                } else {
                    System.out.println("AddressServlet: No provinces found");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.println(gson.toJson(new ErrorResponse("No provinces found. Please check your database.")));
                }
            } else if (pathInfo.startsWith("/districts/")) {
                // Get districts for a province
                String provinceCode = pathInfo.substring("/districts/".length());
                System.out.println("AddressServlet: Fetching districts for province code: " + provinceCode);

                List<District> districts = addressDAO.getDistrictsByProvinceCode(provinceCode);
                System.out.println("AddressServlet: Districts fetched: " + (districts != null ? districts.size() : "null"));

                if (districts != null && !districts.isEmpty()) {
                    String json = gson.toJson(districts);
                    System.out.println("AddressServlet: Returning JSON with " + districts.size() + " districts");
                    out.println(json);
                } else {
                    System.out.println("AddressServlet: No districts found for province code: " + provinceCode);
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.println(gson.toJson(new ErrorResponse("No districts found for province code: " + provinceCode)));
                }
            } else if (pathInfo.startsWith("/wards/")) {
                // Get wards for a district
                String districtCode = pathInfo.substring("/wards/".length());
                System.out.println("AddressServlet: Fetching wards for district code: " + districtCode);

                List<Ward> wards = addressDAO.getWardsByDistrictCode(districtCode);
                System.out.println("AddressServlet: Wards fetched: " + (wards != null ? wards.size() : "null"));

                if (wards != null && !wards.isEmpty()) {
                    String json = gson.toJson(wards);
                    System.out.println("AddressServlet: Returning JSON with " + wards.size() + " wards");
                    out.println(json);
                } else {
                    System.out.println("AddressServlet: No wards found for district code: " + districtCode);
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.println(gson.toJson(new ErrorResponse("No wards found for district code: " + districtCode)));
                }
            } else {
                System.out.println("AddressServlet: Invalid request path: " + pathInfo);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.println(gson.toJson(new ErrorResponse("Invalid request path")));
            }
        } catch (Exception e) {
            System.err.println("AddressServlet ERROR: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println(gson.toJson(new ErrorResponse("Error processing request: " + e.getMessage())));
        } finally {
            out.flush();
        }
    }

    private static class ErrorResponse {

        private final String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }
}
