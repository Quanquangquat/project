<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Announcements</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">Manage Announcements</h1>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <form action="${pageContext.request.contextPath}/admin/manageAnnouncements" method="post">
                    <div class="form-group">
                        <label for="action">Action:</label>
                        <select name="action" id="action" class="form-control" required>
                            <option value="create">Create</option>
                            <option value="edit">Edit</option>
                            <option value="delete">Delete</option>
                        </select>
                    </div>
                    <div class="form-group mt-2">
                        <label for="content">Content:</label>
                        <textarea name="content" id="content" class="form-control" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Perform Action</button>
                </form>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>