<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard | Household Management</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            :root {
                --primary-color: #3498db;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --success-color: #2ecc71;
                --warning-color: #f39c12;
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
                background: linear-gradient(135deg, var(--secondary-color), #34495e);
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
                font-size: 2.5rem;
                margin-bottom: 15px;
                display: inline-block;
                width: 70px;
                height: 70px;
                line-height: 70px;
                text-align: center;
                border-radius: 50%;
            }

            .icon-users {
                background-color: rgba(52, 152, 219, 0.1);
                color: var(--primary-color);
            }

            .icon-households {
                background-color: rgba(46, 204, 113, 0.1);
                color: var(--success-color);
            }

            .icon-requests {
                background-color: rgba(243, 156, 18, 0.1);
                color: var(--warning-color);
            }

            .icon-reports {
                background-color: rgba(231, 76, 60, 0.1);
                color: var(--accent-color);
            }

            .icon-registrations {
                background-color: rgba(231, 76, 60, 0.1);
                color: var(--accent-color);
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

            .stats-card {
                border-left: 4px solid;
                background-color: white;
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .stats-card-primary {
                border-left-color: var(--primary-color);
            }

            .stats-card-success {
                border-left-color: var(--success-color);
            }

            .stats-card-warning {
                border-left-color: var(--warning-color);
            }

            .stats-card-danger {
                border-left-color: var(--accent-color);
            }

            .stats-card-title {
                color: #6c757d;
                font-size: 0.9rem;
                margin-bottom: 5px;
            }

            .stats-card-value {
                font-size: 1.8rem;
                font-weight: 600;
                margin-bottom: 0;
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
                            <p class="text-light mb-0">Admin Portal</p>
                        </div>
                        <div class="position-sticky pt-3">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="bi bi-speedometer2"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/viewAllUsers">
                                        <i class="bi bi-people"></i> User Management
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/viewAllHouseholds">
                                        <i class="bi bi-houses"></i> Household Management
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/viewAllRequests">
                                        <i class="bi bi-file-earmark-text"></i> Request Management
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/registrations">
                                        <i class="bi bi-clipboard-check"></i> Registration Management
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/generateReports">
                                        <i class="bi bi-bar-chart"></i> Reports
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/manageAnnouncements">
                                        <i class="bi bi-megaphone"></i> Announcements
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                        <!-- Welcome Section -->
                        <div class="welcome-section">
                            <h1>Welcome, <c:out value="${sessionScope.loggedInUser.fullName}" />!</h1>
                            <p class="lead mb-0">Admin Dashboard - Manage users, households, and system operations</p>
                            <div>
                                <nav class="navbar navbar-expand-lg navbar-dark navbar-police sticky-top">
                                    <div class="container-fluid">
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
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/viewProfile?id="><i class="bi bi-person me-2"></i>My Profile</a></li>
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </nav>
                            </div>
                        </div>

<!--                         Stats Overview 
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="stats-card stats-card-primary">
                                    <div class="stats-card-title">Total Users</div>
                                    <div class="stats-card-value">12</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card stats-card-success">
                                    <div class="stats-card-title">Total Households</div>
                                    <div class="stats-card-value">12</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card stats-card-warning">
                                    <div class="stats-card-title">Pending Requests</div>
                                    <div class="stats-card-value">4</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card stats-card-danger">
                                    <div class="stats-card-title">New Today</div>
                                    <div class="stats-card-value">5</div>
                                </div>
                            </div>
                        </div>-->

                        <!-- Main Features -->
                        <h4 class="mb-4">Administration Tools</h4>
                        <div class="row row-cols-1 row-cols-md-2 g-4 mb-5">
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon icon-users">
                                            <i class="bi bi-people"></i>
                                        </div>
                                        <h5 class="card-title">User Management</h5>
                                        <p class="card-text">Manage user accounts, permissions, and profile information.</p>
                                        <a href="${pageContext.request.contextPath}/admin/viewAllUsers" class="btn btn-custom-primary w-100 mb-2">
                                            <i class="bi bi-list-ul me-2"></i>View All Users
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/manageUsers" class="btn btn-custom-secondary w-100">
                                            <i class="bi bi-gear me-2"></i>Manage Users
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon icon-households">
                                            <i class="bi bi-houses"></i>
                                        </div>
                                        <h5 class="card-title">Household Management</h5>
                                        <p class="card-text">View and manage household registrations and member information.</p>
                                        <a href="${pageContext.request.contextPath}/admin/viewAllHouseholds" class="btn btn-custom-primary w-100 mb-2">
                                            <i class="bi bi-list-ul me-2"></i>View All Households
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/manageHouseholds" class="btn btn-custom-secondary w-100">
                                            <i class="bi bi-gear me-2"></i>Manage Households
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon icon-requests">
                                            <i class="bi bi-file-earmark-text"></i>
                                        </div>
                                        <h5 class="card-title">Request Management</h5>
                                        <p class="card-text">Review, approve, or reject user requests and applications.</p>
                                        <a href="${pageContext.request.contextPath}/admin/viewAllRequests" class="btn btn-custom-primary w-100 mb-2">
                                            <i class="bi bi-list-ul me-2"></i>View All Requests
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/approveRequests" class="btn btn-custom-secondary w-100">
                                            <i class="bi bi-check-circle me-2"></i>Approve/Reject Requests
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon icon-reports">
                                            <i class="bi bi-bar-chart"></i>
                                        </div>
                                        <h5 class="card-title">Reports & Announcements</h5>
                                        <p class="card-text">Generate system reports and manage public announcements.</p>
                                        <a href="${pageContext.request.contextPath}/admin/generateReports" class="btn btn-custom-primary w-100 mb-2">
                                            <i class="bi bi-graph-up me-2"></i>Generate Reports
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/manageAnnouncements" class="btn btn-custom-secondary w-100">
                                            <i class="bi bi-megaphone me-2"></i>Manage Announcements
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <div class="feature-icon icon-registrations">
                                            <i class="bi bi-clipboard-check"></i>
                                        </div>
                                        <h5 class="card-title">Registration Management</h5>
                                        <p class="card-text">Review and process household registration requests.</p>
                                        <a href="${pageContext.request.contextPath}/admin/registrations" class="btn btn-custom-primary w-100 mb-2">
                                            <i class="bi bi-list-ul me-2"></i>View All Registrations
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/registrations/pending" class="btn btn-custom-secondary w-100">
                                            <i class="bi bi-check-circle me-2"></i>Process Pending Requests
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Activity -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Recent Activity</h5>
                                        <a href="#" class="btn btn-sm btn-custom-secondary">View All</a>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Activity</th>
                                                        <th>User</th>
                                                        <th>Date</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>New User Registration</td>
                                                        <td>Nguyen Van A</td>
                                                        <td>Today, 10:30 AM</td>
                                                        <td><span class="badge bg-success">Completed</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Household Registration</td>
                                                        <td>Tran Thi B</td>
                                                        <td>Today, 09:15 AM</td>
                                                        <td><span class="badge bg-warning text-dark">Pending</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Address Change Request</td>
                                                        <td>Le Van C</td>
                                                        <td>Yesterday, 3:45 PM</td>
                                                        <td><span class="badge bg-primary">In Review</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>New Member Addition</td>
                                                        <td>Pham Thi D</td>
                                                        <td>Yesterday, 1:20 PM</td>
                                                        <td><span class="badge bg-success">Completed</span></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

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