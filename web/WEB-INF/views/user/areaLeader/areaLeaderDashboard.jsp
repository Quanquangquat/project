<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Area Leader Dashboard | Household Management</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            :root {
                --primary-color: #0d6efd;
                --secondary-color: #212529;
                --police-color: #0a58ca;
                --accent-color: #ffc107;
                --success-color: #198754;
                --danger-color: #dc3545;
                --light-bg: #f8f9fa;
            }
            
            body {
                background-color: #f5f5f5;
            }
            
            .navbar-police {
                background-color: var(--police-color);
            }
            
            .sidebar {
                background-color: var(--secondary-color);
                min-height: calc(100vh - 56px);
                position: sticky;
                top: 56px;
            }
            
            .sidebar .nav-link {
                color: rgba(255,255,255,0.8);
                padding: 0.75rem 1.25rem;
                border-radius: 0.25rem;
                margin: 0.25rem 0;
            }
            
            .sidebar .nav-link:hover {
                background-color: rgba(255,255,255,0.1);
                color: #fff;
            }
            
            .sidebar .nav-link.active {
                background-color: var(--primary-color);
                color: white;
            }
            
            .sidebar .nav-link i {
                margin-right: 0.5rem;
            }
            
            .dashboard-card {
                transition: transform 0.2s, box-shadow 0.2s;
                border-radius: 0.5rem;
                overflow: hidden;
                height: 100%;
            }
            
            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            
            .card-icon {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }
            
            .stat-card {
                border-left: 4px solid var(--primary-color);
            }
            
            .stat-card.pending {
                border-left-color: var(--accent-color);
            }
            
            .stat-card.approved {
                border-left-color: var(--success-color);
            }
            
            .stat-card.rejected {
                border-left-color: var(--danger-color);
            }
            
            .recent-item {
                padding: 0.75rem;
                border-bottom: 1px solid #eee;
                transition: background-color 0.2s;
            }
            
            .recent-item:hover {
                background-color: rgba(13, 110, 253, 0.05);
            }
            
            .recent-item:last-child {
                border-bottom: none;
            }
            
            .avatar-container {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                overflow: hidden;
                background-color: #e9ecef;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .avatar-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .avatar-placeholder {
                font-size: 1.2rem;
                color: #6c757d;
            }
            
            @media (max-width: 768px) {
                .sidebar {
                    position: static;
                    min-height: auto;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-police sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                    <i class="bi bi-buildings-fill me-2"></i>
                    Area Management System
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle"></i>
                                <span class="ms-1">${sessionScope.loggedInUser.fullName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="bi bi-person me-2"></i>My Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/settings"><i class="bi bi-gear me-2"></i>Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                    <div class="position-sticky pt-3">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="${pageContext.request.contextPath}/areaLeader/dashboard">
                                    <i class="bi bi-speedometer2"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/list">
                                    <i class="bi bi-clipboard-check"></i> Pending Verifications
                                    <c:if test="${pendingCount > 0}">
                                        <span class="badge bg-warning rounded-pill ms-2">${pendingCount}</span>
                                    </c:if>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/area">
                                    <i class="bi bi-geo-alt"></i> Area Registrations
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/areaLeader/households">
                                    <i class="bi bi-houses"></i> Area Households
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/areaLeader/notifications">
                                    <i class="bi bi-bell"></i> Notifications
                                    <span class="badge bg-danger rounded-pill ms-2">3</span>
                                </a>
                            </li>
                        </ul>
                        
                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                            <span>Verification Tools</span>
                        </h6>
                        <ul class="nav flex-column mb-2">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/list">
                                    <i class="bi bi-list-check"></i>
                                    <span>All Registrations</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/list?status=1">
                                    <i class="bi bi-hourglass-split"></i>
                                    <span>Pending Registrations</span>
                                    <c:if test="${pendingCount > 0}">
                                        <span class="badge bg-danger ms-2">${pendingCount}</span>
                                    </c:if>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/list?status=2">
                                    <i class="bi bi-check-circle"></i>
                                    <span>Approved Registrations</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/list?status=3">
                                    <i class="bi bi-x-circle"></i>
                                    <span>Rejected Registrations</span>
                                </a>
                            </li>
                        </ul>

                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                            <span>Quick Access</span>
                        </h6>
                        <ul class="nav flex-column mb-2">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/areaLeader/calendar">
                                    <i class="bi bi-calendar3"></i> Calendar
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/areaLeader/messages">
                                    <i class="bi bi-chat-dots"></i> Messages
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Area Leader Dashboard</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group me-2">
                                <button type="button" class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-share"></i> Share
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-download"></i> Export
                                </button>
                            </div>
                            <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle">
                                <i class="bi bi-calendar3"></i> This week
                            </button>
                        </div>
                    </div>

                    <!-- Welcome Message -->
                    <div class="alert alert-primary d-flex align-items-center" role="alert">
                        <i class="bi bi-info-circle-fill me-2 flex-shrink-0"></i>
                        <div>
                            Welcome back, <strong>${sessionScope.loggedInUser.fullName}</strong>! You have <strong>${pendingCount}</strong> pending verifications to review.
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <h4 class="mb-3">Quick Actions</h4>
                    <div class="row mb-4">
                        <div class="col-md-3 mb-4">
                            <div class="card dashboard-card text-center">
                                <div class="card-body">
                                    <i class="bi bi-clipboard-check card-icon text-primary"></i>
                                    <h5 class="card-title">Verify Registrations</h5>
                                    <p class="card-text">Review and process pending registration requests in your area</p>
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/registration/list" class="btn btn-primary">
                                            <i class="bi bi-arrow-right-circle"></i> View Pending
                                        </a>
                                        <a href="${pageContext.request.contextPath}/registration/area" class="btn btn-outline-primary">
                                            <i class="bi bi-geo-alt"></i> Area Registrations
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card dashboard-card text-center">
                                <div class="card-body">
                                    <i class="bi bi-check-circle card-icon text-success"></i>
                                    <h5 class="card-title">Verification Process</h5>
                                    <p class="card-text">Approve or reject registration requests</p>
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/registration/list" class="btn btn-success mb-2">
                                            <i class="bi bi-check2-circle"></i> Start Verifying
                                        </a>
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/registration/list?status=2" class="btn btn-outline-success">
                                                <span class="badge bg-success">${approvedCount}</span> Approved
                                            </a>
                                            <a href="${pageContext.request.contextPath}/registration/list?status=3" class="btn btn-outline-danger">
                                                <span class="badge bg-danger">${rejectedCount}</span> Rejected
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card dashboard-card text-center">
                                <div class="card-body">
                                    <i class="bi bi-houses card-icon text-info"></i>
                                    <h5 class="card-title">Manage Area</h5>
                                    <p class="card-text">View and manage households in your area</p>
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/areaLeader/households" class="btn btn-info">
                                            <i class="bi bi-house-check"></i> View Households
                                        </a>
                                        <a href="${pageContext.request.contextPath}/areaLeader/statistics" class="btn btn-outline-info">
                                            <i class="bi bi-graph-up"></i> Area Statistics
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card dashboard-card text-center">
                                <div class="card-body">
                                    <i class="bi bi-bell card-icon text-warning"></i>
                                    <h5 class="card-title">Notifications</h5>
                                    <p class="card-text">Check updates and alerts for your area</p>
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/areaLeader/notifications" class="btn btn-warning">
                                            <i class="bi bi-bell"></i> View Notifications
                                            <span class="badge bg-danger ms-2">3</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Area Statistics -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Area Statistics</h5>
                            <button class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-download"></i> Export Report
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="border-start border-4 border-primary p-3">
                                        <h6 class="text-muted mb-1">Total Households</h6>
                                        <h4 class="mb-0">${totalHouseholds}</h4>
                                        <small class="text-success">
                                            <i class="bi bi-arrow-up"></i> 3.2% increase
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border-start border-4 border-success p-3">
                                        <h6 class="text-muted mb-1">Registered Citizens</h6>
                                        <h4 class="mb-0">${totalCitizens}</h4>
                                        <small class="text-success">
                                            <i class="bi bi-arrow-up"></i> 5.1% increase
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border-start border-4 border-warning p-3">
                                        <h6 class="text-muted mb-1">Pending Changes</h6>
                                        <h4 class="mb-0">${pendingChanges}</h4>
                                        <small class="text-muted">Last 30 days</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border-start border-4 border-info p-3">
                                        <h6 class="text-muted mb-1">Verification Rate</h6>
                                        <h4 class="mb-0">${verificationRate}%</h4>
                                        <small class="text-success">Above target</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Verifications Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Pending Verifications</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty pendingVerifications}">
                                    <p class="text-muted">No pending verifications require your attention.</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Type</th>
                                                    <th>Requester</th>
                                                    <th>Date</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="reg" items="${pendingVerifications}">
                                                    <tr>
                                                        <td>${reg.typeName}</td>
                                                        <td>${reg.userName}</td>
                                                        <td><fmt:formatDate value="${reg.sentDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${reg.areaLeaderVerified}">
                                                                    <span class="badge bg-success">Area Leader Verified</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-warning text-dark">Pending Area Leader</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:if test="${reg.policeVerified}">
                                                                <span class="badge bg-info ms-1">Police Verified</span>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <a href="${pageContext.request.contextPath}/registration/details?id=${reg.registrationId}" 
                                                                   class="btn btn-sm btn-primary" title="View Details">
                                                                    <i class="bi bi-eye"></i> View
                                                                </a>
                                                                <c:if test="${!reg.areaLeaderVerified}">
                                                                    <a href="${pageContext.request.contextPath}/registration/verify?id=${reg.registrationId}" 
                                                                       class="btn btn-sm btn-success" title="Verify Registration">
                                                                        <i class="bi bi-check-circle"></i> Verify
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Recent Activity Section -->
                    <div class="row">
                        <!-- Recent Verifications -->
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Recent Verifications</h5>
                                    <a href="${pageContext.request.contextPath}/registration/history" class="btn btn-sm btn-outline-primary">
                                        View All <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty recentVerifications}">
                                            <p class="text-muted">No recent verifications found.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="list-group">
                                                <c:forEach var="verification" items="${recentVerifications}">
                                                    <div class="list-group-item">
                                                        <div class="d-flex w-100 justify-content-between align-items-center">
                                                            <h6 class="mb-1">
                                                                <i class="bi bi-person-vcard me-2"></i>
                                                                ${verification.description}
                                                            </h6>
                                                            <small class="text-muted">
                                                                <fmt:formatDate value="${verification.sentDate}" pattern="dd/MM/yyyy" />
                                                            </small>
                                                        </div>
                                                        <p class="mb-1">
                                                            <c:choose>
                                                                <c:when test="${verification.status == 'APPROVED'}">
                                                                    <span class="badge bg-success">
                                                                        <i class="bi bi-check-circle"></i> Approved
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${verification.status == 'REJECTED'}">
                                                                    <span class="badge bg-danger">
                                                                        <i class="bi bi-x-circle"></i> Rejected
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-warning text-dark">
                                                                        <i class="bi bi-clock"></i> Pending
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:if test="${verification.policeVerified}">
                                                                <span class="badge bg-info ms-1">
                                                                    <i class="bi bi-shield-check"></i> Police Verified
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${verification.areaLeaderVerified}">
                                                                <span class="badge bg-info ms-1">
                                                                    <i class="bi bi-patch-check"></i> Leader Verified
                                                                </span>
                                                            </c:if>
                                                        </p>
                                                        <div class="mt-2">
                                                            <a href="${pageContext.request.contextPath}/registration/details?id=${verification.registrationId}" 
                                                               class="btn btn-sm btn-outline-primary">
                                                                <i class="bi bi-eye"></i> View Details
                                                            </a>
                                                            <c:if test="${!verification.areaLeaderVerified}">
                                                                <a href="${pageContext.request.contextPath}/registration/verify?id=${verification.registrationId}" 
                                                                   class="btn btn-sm btn-outline-success ms-1">
                                                                    <i class="bi bi-check-circle"></i> Verify
                                                                </a>
            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Incidents -->
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Recent Incidents</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty recentIncidents}">
                                            <p class="text-muted">No recent incidents reported.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="list-group">
                                                <c:forEach var="incident" items="${recentIncidents}">
                                                    <a href="#" class="list-group-item list-group-item-action">
                                                        <div class="d-flex w-100 justify-content-between">
                                                            <h6 class="mb-1">${incident.title}</h6>
                                                            <small><fmt:formatDate value="${incident.date}" pattern="dd/MM/yyyy" /></small>
                                                        </div>
                                                        <p class="mb-1">${incident.description}</p>
                                                        <small>Location: ${incident.location} | Status: ${incident.status}</small>
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Upcoming Events Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Upcoming Events</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty upcomingEvents}">
                                    <p class="text-muted">No upcoming events scheduled.</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="row">
                                        <c:forEach var="event" items="${upcomingEvents}">
                                            <div class="col-md-6 mb-3">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h5 class="card-title">${event.title}</h5>
                                                        <h6 class="card-subtitle mb-2 text-muted">
                                                            <i class="bi bi-calendar"></i> <fmt:formatDate value="${event.date}" pattern="dd/MM/yyyy" />
                                                            | <i class="bi bi-geo-alt"></i> ${event.location}
                                                        </h6>
                                                        <p class="card-text">${event.description}</p>
                                                        <a href="#" class="card-link">View Details</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Verification Guide Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Verification Guide</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="text-center mb-3">
                                        <i class="bi bi-file-text display-4 text-primary"></i>
                                        <h5 class="mt-3">1. Review Registration</h5>
                                        <p class="text-muted">Review registration details, including personal information and supporting documents.</p>
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle"></i> Tip: Check if the address is within your jurisdiction area.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="text-center mb-3">
                                        <i class="bi bi-check2-circle display-4 text-success"></i>
                                        <h5 class="mt-3">2. Verify Information</h5>
                                        <p class="text-muted">Confirm the accuracy of information and compliance with local regulations.</p>
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle"></i> Tip: Look for any inconsistencies in the provided information.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="text-center mb-3">
                                        <i class="bi bi-clipboard-check display-4 text-warning"></i>
                                        <h5 class="mt-3">3. Submit Decision</h5>
                                        <p class="text-muted">Approve or reject the registration with detailed comments on your decision.</p>
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle"></i> Tip: Be specific about reasons if rejecting a registration.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="alert alert-warning mt-3">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                <strong>Important:</strong> Both Area Leader and Police verification are required. Either party can reject a registration if issues are found.
                            </div>
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/registration/list" class="btn btn-primary">
                                    <i class="bi bi-arrow-right-circle"></i> Start Verifying Registrations
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer mt-auto py-3 bg-light">
            <div class="container text-center">
                <span class="text-muted">© 2023 Household Management System | Area Leader Portal</span>
            </div>
        </footer>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Highlight current page in sidebar
                const currentLocation = window.location.pathname;
                const navLinks = document.querySelectorAll('.nav-link');
                
                navLinks.forEach(link => {
                    if (link.getAttribute('href') === currentLocation) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });

                // Initialize tooltips
                const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });
            });
        </script>
    </body>
</html>