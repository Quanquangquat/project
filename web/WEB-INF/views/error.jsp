<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Household Management</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .error-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }
        .error-code {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 30px;
        }
        .error-details {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .error-actions {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container error-container text-center">
        <div class="error-icon">
            <i class="bi bi-exclamation-triangle-fill"></i>
        </div>
        
        <h1 class="error-code">
            <c:choose>
                <c:when test="${not empty pageContext.errorData.statusCode}">
                    Error ${pageContext.errorData.statusCode}
                </c:when>
                <c:otherwise>
                    Error
                </c:otherwise>
            </c:choose>
        </h1>
        
        <div class="error-message">
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:when test="${not empty pageContext.exception.message}">
                    ${pageContext.exception.message}
                </c:when>
                <c:otherwise>
                    An unexpected error occurred
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${not empty errorDetails || not empty pageContext.exception}">
            <div class="error-details">
                <h5>Error Details:</h5>
                <p>
                    <c:choose>
                        <c:when test="${not empty errorDetails}">
                            ${errorDetails}
                        </c:when>
                        <c:when test="${not empty pageContext.exception}">
                            <c:out value="${pageContext.exception}" />
                        </c:when>
                    </c:choose>
                </p>
            </div>
        </c:if>
        
        <div class="error-actions">
            <a href="javascript:history.back()" class="btn btn-secondary me-2">
                <i class="bi bi-arrow-left me-2"></i>Go Back
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="bi bi-house-door me-2"></i>Go to Home
            </a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html> 