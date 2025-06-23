<%--
    Document   : showRegistrations
    Created on : Mar 17, 2025, 9:31:02 AM
    Author     : quang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>My Registrations - Residence Registration System</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            .table-responsive {
                overflow-x: auto;
            }
            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-approved {
                background-color: #d4edda;
                color: #155724;
            }
            .status-rejected {
                background-color: #f8d7da;
                color: #721c24;
            }
            .btn-action {
                margin-right: 5px;
            }
            .registration-header {
                background-color: #f8f9fa;
                padding: 20px 0;
                margin-bottom: 20px;
                border-bottom: 1px solid #dee2e6;
            }
            .empty-state {
                text-align: center;
                padding: 50px 0;
            }
            .empty-state i {
                font-size: 4rem;
                color: #6c757d;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <i class="bi bi-building-fill me-2"></i>
                    Residence Registration System
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                                <i class="bi bi-speedometer2 me-1"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/registration/showAll">
                                <i class="bi bi-file-earmark-text me-1"></i> My Registrations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/registration/choose">
                                <i class="bi bi-plus-circle me-1"></i> New Registration
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Header -->
        <div class="registration-header">
            <div class="container">
                <h2><i class="bi bi-file-earmark-text me-2"></i>My Registrations</h2>
                <p class="text-muted">View and manage your registration requests</p>
            </div>
        </div>

        <div class="container mb-5">
            <!-- Alert for messages -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Registrations Table -->
            <c:choose>
                <c:when test="${empty registrations}">
                    <div class="empty-state">
                        <i class="bi bi-file-earmark-x"></i>
                        <h4>No registrations found</h4>
                        <p class="text-muted">You haven't submitted any registration requests yet.</p>
                        <a href="${pageContext.request.contextPath}/registration/choose" class="btn btn-primary mt-3">
                            <i class="bi bi-plus-circle me-2"></i>Create New Registration
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Type</th>
                                    <th>Sent Date</th>
                                    <th>Status</th>
                                    <th>Details</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="registration" items="${registrations}">
                                    <tr>
                                        <td>${registration.registrationId}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${registration.registrationTypeId == 1}">
                                                    <span class="badge bg-primary">Transfer Household</span>
                                                </c:when>
                                                <c:when test="${registration.registrationTypeId == 2}">
                                                    <span class="badge bg-info">Split Household</span>
                                                </c:when>
                                                <c:when test="${registration.registrationTypeId == 3}">
                                                    <span class="badge bg-secondary">Register Into Household</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-dark">Other</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${registration.sentDate}" pattern="dd-MM-yyyy" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${registration.registrationStatusId == 1}">
                                                    <span class="badge status-pending">Pending</span>
                                                </c:when>
                                                <c:when test="${registration.registrationStatusId == 2}">
                                                    <span class="badge status-approved">Approved</span>
                                                </c:when>
                                                <c:when test="${registration.registrationStatusId == 3}">
                                                    <span class="badge status-rejected">Rejected</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Unknown</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${registration.registrationTypeId == 1}">
                                                    <c:forEach var="transfer" items="${transferDetails}">
                                                        <c:if test="${transfer.registrationId == registration.registrationId}">
                                                            <strong>From:</strong> ${transfer.previousAddress}<br>
                                                            <strong>To:</strong> ${transfer.newAddress}<br>
                                                            <strong>Move Date:</strong> <fmt:formatDate value="${transfer.moveDate}" pattern="dd-MM-yyyy" />
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Details not available</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="${pageContext.request.contextPath}/registration/show?id=${registration.registrationId}"
                                                   class="btn btn-sm btn-info btn-action">
                                                    <i class="bi bi-eye"></i> View
                                                </a>

                                                <a href="${pageContext.request.contextPath}/registration/documents?id=${registration.registrationId}"
                                                   class="btn btn-sm btn-secondary btn-action">
                                                    <i class="bi bi-file-earmark"></i> Documents
                                                </a>

                                                <c:if test="${registration.registrationStatusId == 1}">
                                                    <a href="${pageContext.request.contextPath}/registration/update?id=${registration.registrationId}"
                                                       class="btn btn-sm btn-warning btn-action">
                                                        <i class="bi bi-pencil"></i> Edit
                                                    </a>

                                                    <button type="button" class="btn btn-sm btn-danger btn-action"
                                                            data-bs-toggle="modal" data-bs-target="#deleteModal${registration.registrationId}">
                                                        <i class="bi bi-trash"></i> Delete
                                                    </button>

                                                    <!-- Delete Confirmation Modal -->
                                                    <div class="modal fade" id="deleteModal${registration.registrationId}" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title">Confirm Deletion</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <p>Are you sure you want to delete this registration request?</p>
                                                                    <p class="text-danger"><strong>This action cannot be undone.</strong></p>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <form action="${pageContext.request.contextPath}/registration/delete" method="post">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="registrationId" value="${registration.registrationId}">
                                                                        <button type="submit" class="btn btn-danger">Delete</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/registration/choose" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i>Create New Registration
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>



        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
