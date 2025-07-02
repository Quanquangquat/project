<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Household Details | Household Management</title>
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
                color: white;
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
            }
            .container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0;
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .card-header {
                background-color: #3498db;
                color: white;
                border-radius: 10px 10px 0 0 !important;
                padding: 15px 20px;
            }

            .card-body {
                padding: 25px;
            }

            h1, h2, h3 {
                color: #2c3e50;
            }

            .info-label {
                font-weight: 600;
                color: #7f8c8d;
            }

            .info-value {
                font-weight: 400;
                color: #2c3e50;
            }

            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
                padding: 10px 20px;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            .btn-secondary {
                background-color: #95a5a6;
                border-color: #95a5a6;
                padding: 10px 20px;
            }

            .btn-secondary:hover {
                background-color: #7f8c8d;
                border-color: #7f8c8d;
            }

            .btn-danger {
                background-color: #e74c3c;
                border-color: #e74c3c;
            }

            .btn-danger:hover {
                background-color: #c0392b;
                border-color: #c0392b;
            }

            .table {
                margin-bottom: 0;
            }

            .table th {
                background-color: #f8f9fa;
                color: #2c3e50;
                font-weight: 600;
            }

            .alert {
                margin-bottom: 20px;
            }

            .member-card {
                border: 1px solid #e9ecef;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 15px;
                transition: all 0.3s;
            }

            .member-card:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transform: translateY(-3px);
            }

            .member-name {
                font-weight: 600;
                font-size: 1.1rem;
                color: #2c3e50;
            }

            .member-relationship {
                color: #7f8c8d;
                font-style: italic;
            }

            .member-info {
                margin-top: 10px;
                color: #34495e;
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/userprofile/view">
                                    <i class="bi bi-person"></i> My Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.loggedInUser.householdId}">
                                        <a class="nav-link active" href="${pageContext.request.contextPath}/household/view?householdId=${sessionScope.loggedInUser.householdId}">
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/registration/choose">
                                    <i class="bi bi-file-earmark-text"></i> Registration Requests
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
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
                <c:remove var="success" scope="session" />
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
                <c:remove var="error" scope="session" />
            </c:if>
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">Household Details</h2>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light">
                        <i class="bi bi-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <span class="info-label">Household ID:</span>
                                <span class="info-value">${household.householdId}</span>
                            </div>
                            <div class="mb-3">
                                <span class="info-label">Head of Household:</span>
                                <span class="info-value">${household.headName}</span>
                            </div>
                            <div class="mb-3">
                                <span class="info-label">Address:</span>
                                <span class="info-value">${household.address}</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <span class="info-label">Created Date:</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${household.createdDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </span>
                            </div>
                            <div class="mb-3">
                                <span class="info-label">Area ID:</span>
                                <span class="info-value">${household.areaId}</span>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3>Household Members</h3>
                        <a href="${pageContext.request.contextPath}/household/addMember" class="btn btn-primary">
                            <i class="bi bi-person-plus"></i> Add Member
                        </a>
                    </div>
                    <c:if test="${empty members}">
                        <div class="alert alert-info">
                            No members found for this household.
                        </div>
                    </c:if>
                    <c:if test="${not empty members}">
                        <div class="row">
                            <c:forEach var="member" items="${members}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="member-card">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="member-name">${member.fullName}</div>
                                                <div class="member-relationship">${member.relationship}</div>
                                            </div>
                                            <div>
                                                <button class="btn btn-sm btn-outline-primary"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#memberDetails${member.memberId}">
                                                    <i class="bi bi-info-circle"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="collapse mt-3" id="memberDetails${member.memberId}">
                                            <div class="member-info">
                                                <div><strong>Email:</strong> ${member.email}</div>
                                                <div><strong>CCCD:</strong> ${member.cccd}</div>
                                                <c:if test="${not empty member.gender}">
                                                    <div><strong>Gender:</strong> ${member.gender}</div>
                                                </c:if>
                                                <c:if test="${not empty member.dateOfBirth}">
                                                    <div>
                                                        <strong>Date of Birth:</strong>
                                                        <fmt:formatDate value="${member.dateOfBirth}" pattern="dd/MM/yyyy" />
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty member.phoneNumber}">
                                                    <div><strong>Phone:</strong> ${member.phoneNumber}</div>
                                                </c:if>
                                            </div>
                                            <div class="mt-3">
                                                <a href="${pageContext.request.contextPath}/household/updateMember?memberId=${member.memberId}"
                                                   class="btn btn-sm btn-outline-secondary">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <button class="btn btn-sm btn-outline-danger"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#deleteModal"
                                                        data-member-id="${member.memberId}"
                                                        data-member-name="${member.fullName}">
                                                    <i class="bi bi-trash"></i> Remove
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Removal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to remove <span id="memberNameSpan"></span> from this household?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form id="deleteForm" action="${pageContext.request.contextPath}/household/deleteMember" method="post">
                            <input type="hidden" id="memberIdInput" name="memberId">
                            <input type="hidden" name="householdId" value="${household.householdId}">
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                    <footer class="mt-5 pt-3 border-top text-center text-muted">
                        <p>&copy; 2023 Household Management System. All rights reserved.</p>
                    </footer>
                </div>
            </div>
        </div>
    </c:if>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Set up the delete modal
                $('#deleteModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var memberId = button.data('member-id');
                    var memberName = button.data('member-name');
                    $('#memberIdInput').val(memberId);
                    $('#memberNameSpan').text(memberName);
                });
            });
        </script>
    </body>
</html>