<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="bg-light py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Household Management System</h5>
                <p class="text-muted">A system for managing household registrations, transfers, and member management.</p>
            </div>
            <div class="col-md-3">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/registration" class="text-decoration-none">Registrations</a></li>
                    <li><a href="${pageContext.request.contextPath}/household" class="text-decoration-none">Household</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Contact</h5>
                <ul class="list-unstyled">
                    <li><i class="bi bi-envelope me-2"></i> support@household.gov.vn</li>
                    <li><i class="bi bi-telephone me-2"></i> (84) 123-456-789</li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="d-flex justify-content-between align-items-center">
            <p class="mb-0 text-muted">&copy; <%= java.time.Year.now().getValue() %> Household Management System. All rights reserved.</p>
            <ul class="list-inline mb-0">
                <li class="list-inline-item"><a href="#" class="text-muted"><i class="bi bi-facebook"></i></a></li>
                <li class="list-inline-item"><a href="#" class="text-muted"><i class="bi bi-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#" class="text-muted"><i class="bi bi-instagram"></i></a></li>
            </ul>
        </div>
    </div>
</footer> 