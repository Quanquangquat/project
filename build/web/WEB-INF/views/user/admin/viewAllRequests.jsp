<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View All Requests</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">View All Requests</h1>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <p>[Placeholder - List all requests here]</p>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary mt-3">Back to Dashboard</a>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>