<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="h-100">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registration Documents - Residence Registration System</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            body {
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            
            main {
                flex: 1 0 auto;
            }
            
            footer {
                flex-shrink: 0;
            }
            
            .document-header {
                background-color: #f8f9fa;
                padding: 20px 0;
                margin-bottom: 20px;
                border-bottom: 1px solid #dee2e6;
            }
            .document-card {
                transition: transform 0.2s;
                margin-bottom: 20px;
            }
            .document-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .document-icon {
                font-size: 2.5rem;
                color: #6c757d;
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
        </style>
    </head>
    <body class="d-flex flex-column h-100">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/registration/showAll">
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

        <!-- Main Content -->
        <main class="flex-shrink-0">
            <!-- Header -->
            <div class="document-header">
                <div class="container">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="bi bi-file-earmark me-2"></i>Registration Documents</h2>
                            <p class="text-muted mb-0">
                                <c:if test="${not empty registration}">
                                    Registration #${registration.registrationId} - 
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
                                    - Status: 
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
                                </c:if>
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/registration/showAll" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Registrations
                        </a>
                    </div>
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

                <!-- Documents Display -->
                <c:choose>
                    <c:when test="${empty documents}">
                        <div class="empty-state">
                            <i class="bi bi-file-earmark-x"></i>
                            <h4>No documents found</h4>
                            <p class="text-muted">There are no documents attached to this registration.</p>
                            <a href="${pageContext.request.contextPath}/registration/showAll" class="btn btn-primary mt-3">
                                <i class="bi bi-arrow-left me-2"></i>Back to Registrations
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="document" items="${documents}">
                                <div class="col-md-4">
                                    <div class="card document-card">
                                        <div class="card-body text-center">
                                            <div class="document-icon mb-3">
                                                <c:choose>
                                                    <c:when test="${document.contentType.contains('pdf')}">
                                                        <i class="bi bi-file-earmark-pdf"></i>
                                                    </c:when>
                                                    <c:when test="${document.contentType.contains('image')}">
                                                        <i class="bi bi-file-earmark-image"></i>
                                                    </c:when>
                                                    <c:when test="${document.contentType.contains('word')}">
                                                        <i class="bi bi-file-earmark-word"></i>
                                                    </c:when>
                                                    <c:when test="${document.contentType.contains('excel')}">
                                                        <i class="bi bi-file-earmark-excel"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-file-earmark"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <h5 class="card-title">${document.fileName}</h5>
                                            <p class="card-text text-muted">
                                                <c:choose>
                                                    <c:when test="${document.documentType == 'IDENTITY'}">
                                                        <span class="badge bg-info">Identity Document</span>
                                                    </c:when>
                                                    <c:when test="${document.documentType == 'PROOF_OF_RESIDENCE'}">
                                                        <span class="badge bg-success">Proof of Residence</span>
                                                    </c:when>
                                                    <c:when test="${document.documentType == 'TRANSFER'}">
                                                        <span class="badge bg-warning">Transfer Document</span>
                                                    </c:when>
                                                    <c:when test="${document.documentType == 'ADDITIONAL'}">
                                                        <span class="badge bg-secondary">Additional Document</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-dark">${document.documentType}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="card-text small">
                                                Size: ${document.fileSize} bytes<br>
                                                Type: ${document.contentType}
                                            </p>
                                            <form action="${pageContext.request.contextPath}/registration/documents" method="post">
                                                <input type="hidden" name="documentId" value="${document.documentId}">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-download me-1"></i> Download
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <!-- Footer -->
        <footer class="footer mt-auto py-4 bg-dark text-white">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Residence Registration System</h5>
                        <p class="small">A system for managing household registrations and transfers.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="small">&copy; <script>document.write(new Date().getFullYear())</script> Residence Registration System. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 