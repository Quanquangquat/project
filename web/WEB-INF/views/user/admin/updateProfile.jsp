<%-- 
    Document   : updateProfile
    Created on : Jun 22, 2025, 4:43:55 PM
    Author     : admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Profile</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">Update Profile</h1>
            <%--<c:if test="${not empty sessionScope.loggedInUser}">--%>
            <c:if test="${not empty sessionScope.loggedInUser && not empty user}">
                <form action="${pageContext.request.contextPath}/admin/updateProfile" method="post">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" name="fullName" id="fullName" class="form-control" value="${user.fullName}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" class="form-control" value="${user.email}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="password">Password:</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Enter new password">
                    </div>
                    <div class="form-group mt-2">
                        <label for="address">Address:</label>
                        <input type="text" name="address" id="address" class="form-control" value="${user.address}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="cccd">CCCD (Citizen ID):</label>
                        <input type="text" name="cccd" id="cccd" class="form-control" value="${user.cccd}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="gender">Gender:</label>
                        <select name="gender" id="gender" class="form-control">
                            <option value="">-- Select Gender --</option>
                            <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="form-group mt-2">
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="tel" name="phoneNumber" id="phoneNumber" class="form-control" value="${user.phoneNumber}" placeholder="Enter phone number">
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Update</button>
                    <a href="${pageContext.request.contextPath}/admin/viewAllUsers" class="btn btn-secondary mt-3">Back to Dashboard</a>
                </form>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
