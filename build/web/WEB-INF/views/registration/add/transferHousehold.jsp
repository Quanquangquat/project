<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Transfer Household | Household Management</title>
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

            .page-header {
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
                margin-bottom: 20px;
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

            .status-badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .status-pending {
                background-color: #ffeeba;
                color: #856404;
            }

            .status-approved-leader {
                background-color: #d4edda;
                color: #155724;
            }

            .status-approved-police {
                background-color: #cce5ff;
                color: #004085;
            }

            .status-completed {
                background-color: #c3e6cb;
                color: #155724;
            }

            .status-rejected {
                background-color: #f8d7da;
                color: #721c24;
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
                                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="bi bi-house-door"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/citizen/viewProfile">
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
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/citizen/transferHousehold">
                                        <i class="bi bi-arrow-left-right"></i> Transfer Household
                                    </a>
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
                        <!-- Page Header -->
                        <div class="page-header">
                            <h1><i class="bi bi-arrow-left-right me-2"></i>Transfer Household</h1>
                            <p class="lead mb-0">Submit a request to transfer your household to a new area</p>
                        </div>

                        <!-- Success/Error Messages -->
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="errorMessage" scope="session" />
                        </c:if>

                        <!-- Transfer Request Form -->
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">New Transfer Request</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/citizen/transferHousehold" method="post">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="currentAddress" class="form-label">Current Address</label>
                                            <input type="text" class="form-control" id="currentAddress" name="currentAddress" 
                                                   value="${sessionScope.loggedInUser.address}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="currentArea" class="form-label">Current Area</label>
                                            <input type="text" class="form-control" id="currentArea" 
                                                   value="${currentArea.areaName}, ${currentArea.district}, ${currentArea.city}" readonly>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="destinationAddress" class="form-label">Destination Address</label>
                                            <input type="text" class="form-control" id="destinationAddress" name="destinationAddress" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="destinationAreaId" class="form-label">Destination Area</label>
                                            <select class="form-select" id="destinationAreaId" name="destinationAreaId" required>
                                                <option value="">Select destination area</option>
                                                <c:forEach items="${areas}" var="area">
                                                    <c:if test="${area.areaId != currentArea.areaId}">
                                                        <option value="${area.areaId}">${area.areaName}, ${area.district}, ${area.city}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="reason" class="form-label">Reason for Transfer</label>
                                        <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
                                    </div>
                                    <div class="alert alert-info">
                                        <i class="bi bi-info-circle me-2"></i>
                                        <strong>Note:</strong> Your transfer request will be reviewed by the area leader and police officer. 
                                        You will be notified once your request is processed.
                                    </div>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="reset" class="btn btn-custom-secondary me-md-2">Reset</button>
                                        <button type="submit" class="btn btn-custom-primary">Submit Request</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Transfer History -->
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Transfer History</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty transferHistory}">
                                        <p class="text-center text-muted">You have no transfer requests.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Request Date</th>
                                                        <th>From</th>
                                                        <th>To</th>
                                                        <th>Status</th>
                                                        <th>Notes</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${transferHistory}" var="transfer">
                                                        <tr>
                                                            <td><fmt:formatDate value="${transfer.requestDate}" pattern="dd/MM/yyyy" /></td>
                                                            <td>${transfer.currentAddress}</td>
                                                            <td>${transfer.destinationAddress}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${transfer.status eq 'Pending'}">
                                                                        <span class="status-badge status-pending">Pending</span>
                                                                    </c:when>
                                                                    <c:when test="${transfer.status eq 'Approved by Area Leader'}">
                                                                        <span class="status-badge status-approved-leader">Approved by Area Leader</span>
                                                                    </c:when>
                                                                    <c:when test="${transfer.status eq 'Approved by Police'}">
                                                                        <span class="status-badge status-approved-police">Approved by Police</span>
                                                                    </c:when>
                                                                    <c:when test="${transfer.status eq 'Completed'}">
                                                                        <span class="status-badge status-completed">Completed</span>
                                                                    </c:when>
                                                                    <c:when test="${transfer.status eq 'Rejected'}">
                                                                        <span class="status-badge status-rejected">Rejected</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${transfer.status}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:if test="${not empty transfer.areaLeaderNotes}">
                                                                    <strong>Area Leader:</strong> ${transfer.areaLeaderNotes}<br>
                                                                </c:if>
                                                                <c:if test="${not empty transfer.policeNotes}">
                                                                    <strong>Police:</strong> ${transfer.policeNotes}
                                                                </c:if>
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