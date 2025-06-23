<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Submit Request</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">Submit Request</h1>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <form action="${pageContext.request.contextPath}/citizen/submitRequest" method="post">
                    <div class="form-group">
                        <label for="requestType">Request Type:</label>
                        <select name="requestType" id="requestType" class="form-control" required>
                            <option value="new_cccd">New CCCD</option>
                            <option value="household_change">Household Change</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group mt-2">
                        <label for="description">Description:</label>
                        <textarea name="description" id="description" class="form-control" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Submit Request</button>
                </form>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>