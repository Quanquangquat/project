<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Approve/Reject Requests</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">Approve/Reject Requests</h1>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <form action="${pageContext.request.contextPath}/admin/approveRequests" method="post">
                    <div class="form-group">
                        <label for="requestId">Request ID:</label>
                        <input type="text" name="requestId" id="requestId" class="form-control" required>
                    </div>
                    <div class="form-group mt-2">
                        <label for="decision">Decision:</label>
                        <select name="decision" id="decision" class="form-control" required>
                            <option value="approve">Approve</option>
                            <option value="reject">Reject</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Process Request</button>
                </form>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>