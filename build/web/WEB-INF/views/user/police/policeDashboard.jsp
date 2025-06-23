<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Citizen Dashboard | Household Management</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            :root {
                --primary-color: #3498db;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --light-bg: #f8f9fa;
                --dark-bg: #343a40;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .sidebar {
                background-color: var(--secondary-color);
                color: white;
                height: 100vh;
                position: fixed;
                padding-top: 20px;
                transition: all 0.3s;
            }

            .sidebar-header {
                padding: 20px 15px;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .sidebar-header h3 {
                margin-bottom: 0;
                font-size: 1.5rem;
            }

            .sidebar .nav-link {
                color: rgba(255,255,255,0.8);
                padding: 12px 20px;
                margin: 5px 0;
                border-radius: 5px;
                transition: all 0.2s;
            }

            .sidebar .nav-link:hover {
                background-color: rgba(255,255,255,0.1);
                color: white;
            }

            .sidebar .nav-link i {
                margin-right: 10px;
            }

            .sidebar .nav-link.active {
                background-color: var(--primary-color);
                color: white;
            }

            .main-content {
                margin-left: 250px;
                padding: 20px;
                transition: all 0.3s;
            }

            .welcome-section {
                background: linear-gradient(135deg, var(--primary-color), #2980b9);
                color: white;
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                transition: transform 0.3s, box-shadow 0.3s;
                margin-bottom: 20px;
                height: 100%;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px rgba(0,0,0,0.1);
            }

            .card-header {
                background-color: white;
                border-bottom: 1px solid rgba(0,0,0,0.05);
                font-weight: 600;
                padding: 15px 20px;
                border-radius: 10px 10px 0 0 !important;
            }

            .card-body {
                padding: 20px;
            }

            .feature-icon {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 15px;
            }

            .btn-custom-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
                padding: 8px 16px;
                border-radius: 5px;
                transition: all 0.2s;
            }

            .btn-custom-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
                color: white;
            }

            .btn-custom-secondary {
                background-color: #f8f9fa;
                border-color: #e9ecef;
                color: #495057;
                padding: 8px 16px;
                border-radius: 5px;
                transition: all 0.2s;
            }

            .btn-custom-secondary:hover {
                background-color: #e9ecef;
                border-color: #dee2e6;
            }

            .btn-custom-danger {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
                color: white;
            }

            .btn-custom-danger:hover {
                background-color: #c0392b;
                border-color: #c0392b;
            }

            .logout-section {
                margin-top: 30px;
            }

            /* Mobile responsiveness */
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    margin-bottom: 20px;
                }

                .main-content {
                    margin-left: 0;
                }

                .sidebar-header {
                    text-align: center;
                }

                .mobile-menu-toggle {
                    display: block;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <div class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                        <div class="sidebar-header">
                            <h3>Household Management</h3>
                            <p class="text-light mb-0">Citizen Portal</p>
                        </div>
                        <div class="position-sticky pt-3">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="bi bi-house-door"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/userprofile/view">
                                        <i class="bi bi-person"></i> My Profile
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.loggedInUser.householdId}">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/household/details?id=${sessionScope.loggedInUser.householdId}">
                                                <i class="bi bi-people"></i> Household Info
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="nav-link" href="${pageContext.request.contextPath}/household/create">
                                                <i class="bi bi-people"></i> Create Household
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/registration">
                                        <i class="bi bi-file-earmark-text"></i> Registration Requests
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/citizen/viewReports">
                                        <i class="bi bi-bar-chart"></i> Reports
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/citizen/viewAnnouncements">
                                        <i class="bi bi-megaphone"></i> Announcements
                                    </a>
                                </li>
                                <li class="nav-item mt-5">
                                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right"></i> Logout
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                        <!-- Welcome Section -->
                        <div class="welcome-section">
                            <div class="row align-items-center">
                                <div class="col-md-2 text-center">
                                    <div style="width: 100px; height: 100px; margin: 0 auto; overflow: hidden; border-radius: 50%; border: 3px solid white;">
                                        <img src="${pageContext.request.contextPath}/avatar/${sessionScope.loggedInUser.userId}"
                                             alt="Profile Avatar"
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                    </div>
                                </div>
                                <div class="col-md-10">
                                    <h1>Welcome, <c:out value="${sessionScope.loggedInUser.fullName}" />!</h1>
                                    <p class="lead mb-0">Access and manage your household information and services.</p>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <h4 class="mb-4">Quick Actions</h4>
                        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon">
                                            <i class="bi bi-person-circle"></i>
                                        </div>
                                        <h5 class="card-title">Profile Management</h5>
                                        <p class="card-text">View and update your personal information.</p>
                                        <a href="${pageContext.request.contextPath}/userprofile/view" class="btn btn-custom-primary w-100 mb-2">View Profile</a>
                                        <a href="${pageContext.request.contextPath}/userprofile/update" class="btn btn-custom-secondary w-100">Update Profile</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon">
                                            <i class="bi bi-house-heart"></i>
                                        </div>
                                        <h5 class="card-title">Household Management</h5>
                                        <p class="card-text">Manage your household members and information.</p>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.loggedInUser.householdId}">
                                                <a href="${pageContext.request.contextPath}/household/details?id=${sessionScope.loggedInUser.householdId}" class="btn btn-custom-primary w-100 mb-2">View Household</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/household/create" class="btn btn-custom-primary w-100 mb-2">Create Household</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="${pageContext.request.contextPath}/citizen/transferHousehold" class="btn btn-custom-secondary w-100">Transfer Household</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon">
                                            <i class="bi bi-clipboard-check"></i>
                                        </div>
                                        <h5 class="card-title">Registration Requests</h5>
                                        <p class="card-text">Manage your household registration requests.</p>
                                        <a href="${pageContext.request.contextPath}/registration" class="btn btn-custom-primary w-100 mb-2">Registration Dashboard</a>
                                        <a href="${pageContext.request.contextPath}/registration/list" class="btn btn-custom-secondary w-100">View My Requests</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcements Preview -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Recent Announcements</h5>
                                        <a href="${pageContext.request.contextPath}/citizen/viewAnnouncements" class="btn btn-sm btn-custom-secondary">View All</a>
                                    </div>
                                    <div class="card-body">
                                        <!-- This would be populated with actual announcements from the database -->
                                        <p class="text-muted text-center">No recent announcements to display.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Your Account Information -->


                        <!-- Footer -->
                        <footer class="mt-5 pt-3 border-top text-center text-muted">
                            <p>&copy; 2023 Household Management System. All rights reserved.</p>
                        </footer>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
            // Add any custom JavaScript functionality here
            document.addEventListener('DOMContentLoaded', function () {
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
            });
        </script>
    </body>
</html>