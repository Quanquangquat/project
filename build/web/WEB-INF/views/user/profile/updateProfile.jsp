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
            <c:if test="${not empty sessionScope.loggedInUser}">
                <form action="${pageContext.request.contextPath}/userprofile/update" method="post">
                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" name="fullName" id="fullName" class="form-control" value="${sessionScope.loggedInUser.fullName}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" class="form-control" value="${sessionScope.loggedInUser.email}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="password">Password:</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Enter new password">
                    </div>
                    <div class="form-group mt-2">
                        <label for="address">Address:</label>
                        <input type="text" name="address" id="address" class="form-control" value="${sessionScope.loggedInUser.address}" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="gender">Gender:</label>
                        <select name="gender" id="gender" class="form-control">
                            <option value="">-- Select Gender --</option>
                            <option value="Male" ${sessionScope.loggedInUser.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${sessionScope.loggedInUser.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${sessionScope.loggedInUser.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="form-group mt-2">
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="tel" name="phoneNumber" id="phoneNumber" class="form-control" value="${sessionScope.loggedInUser.phoneNumber}" placeholder="Enter phone number">
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Update</button>
                </form>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>