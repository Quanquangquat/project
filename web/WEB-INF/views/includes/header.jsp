<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="bg-primary text-white py-3 mb-4">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between">
            <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center text-white text-decoration-none">
                <h3 class="mb-0">Household Management System</h3>
            </a>
            
            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 mb-md-0 justify-content-center">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link px-3 text-white">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/registration" class="nav-link px-3 text-white">Registrations</a></li>
                <li><a href="${pageContext.request.contextPath}/household" class="nav-link px-3 text-white">Household</a></li>
                <c:if test="${loggedInUser.roleId == 2 || loggedInUser.roleId == 3}">
                    <li><a href="${pageContext.request.contextPath}/registration/area" class="nav-link px-3 text-white">Area Registrations</a></li>
                </c:if>
            </ul>
            
            <div class="text-end">
                <c:if test="${not empty loggedInUser}">
                    <div class="dropdown">
                        <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> ${loggedInUser.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty loggedInUser}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-warning">Sign-up</a>
                </c:if>
            </div>
        </div>
    </div>
</header> 