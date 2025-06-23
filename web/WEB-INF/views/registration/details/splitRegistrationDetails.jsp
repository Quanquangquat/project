<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Split Household Registration Details</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }
            
            .details-section {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
                margin-bottom: 30px;
            }
            
            .section-title {
                color: #2c3e50;
                border-bottom: 1px solid #eee;
                padding-bottom: 10px;
                margin-bottom: 20px;
                font-weight: 600;
            }
            
            .detail-label {
                font-weight: 600;
                color: #555;
            }
            
            .detail-value {
                padding-left: 10px;
            }
            
            .document-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                transition: all 0.3s;
            }
            
            .document-card:hover {
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .document-icon {
                font-size: 2rem;
                color: #3498db;
            }
            
            .status-badge {
                font-size: 0.8rem;
                padding: 0.4rem 0.8rem;
            }
            
            .member-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                transition: all 0.3s;
            }
            
            .member-card:hover {
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .head-badge {
                font-size: 0.7rem;
                padding: 0.2rem 0.5rem;
                background-color: #3498db;
                color: white;
                border-radius: 4px;
                margin-left: 8px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
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

        <div class="container mb-5">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <!-- Back Button and Status Badge -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <a href="${pageContext.request.contextPath}/registration/showAll" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Registrations
                        </a>
                        <span class="badge bg-${statusColor} status-badge">
                            <i class="bi bi-circle-fill me-1 small"></i>${registration.status}
                        </span>
                    </div>
                    
                    <!-- Registration Header -->
                    <div class="details-section">
                        <h2 class="mb-4">Split Household Registration #${registration.registrationId}</h2>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <span class="detail-label">Submitted By:</span>
                                    <span class="detail-value">${registration.userName}</span>
                                </p>
                                <p class="mb-2">
                                    <span class="detail-label">Sent Date:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${registration.sentDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <span class="detail-label">Status:</span>
                                    <span class="detail-value">${registration.status}</span>
                                </p>
                                <c:if test="${not empty registration.processedDate}">
                                    <p class="mb-2">
                                        <span class="detail-label">Processed Date:</span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${registration.processedDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </span>
                                    </p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Split Registration Details -->
                    <div class="details-section">
                        <h4 class="section-title">Split Household Details</h4>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <span class="detail-label">Previous Address:</span>
                                    <span class="detail-value">${splitRegistration.previousAddress}</span>
                                </p>
                                <p class="mb-2">
                                    <span class="detail-label">New Address:</span>
                                    <span class="detail-value">${splitRegistration.newAddress}</span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-2">
                                    <span class="detail-label">Planned Move Date:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${splitRegistration.moveDate}" pattern="dd/MM/yyyy" />
                                    </span>
                                </p>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h6 class="detail-label mb-2">Reason for Split:</h6>
                            <div class="p-3 bg-light rounded">
                                ${splitRegistration.reasonForSplit}
                            </div>
                        </div>
                    </div>
                    
                    <!-- Members Section -->
                    <div class="details-section">
                        <h4 class="section-title">Household Members to Move</h4>
                        
                        <c:choose>
                            <c:when test="${not empty splitMembers}">
                                <div class="row">
                                    <c:forEach var="member" items="${splitMembers}">
                                        <div class="col-md-6 mb-3">
                                            <div class="member-card">
                                                <div class="d-flex align-items-center">
                                                    <div>
                                                        <h6 class="mb-1">
                                                            ${member.householdMember.fullName}
                                                            <c:if test="${member.householdMember.memberId eq splitRegistration.headOfHousehold}">
                                                                <span class="head-badge">Head</span>
                                                            </c:if>
                                                        </h6>
                                                        <p class="text-muted mb-0 small">
                                                            ${member.householdMember.relationship} | 
                                                            <c:if test="${not empty member.householdMember.dateOfBirth}">
                                                                <fmt:formatDate value="${member.householdMember.dateOfBirth}" pattern="dd/MM/yyyy" /> | 
                                                            </c:if>
                                                            ${member.householdMember.gender}
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle me-2"></i>
                                    No members found for this split registration.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Documents Section -->
                    <div class="details-section">
                        <h4 class="section-title">Submitted Documents</h4>
                        
                        <c:choose>
                            <c:when test="${not empty documents}">
                                <div class="row">
                                    <c:forEach var="document" items="${documents}">
                                        <div class="col-md-6 mb-3">
                                            <div class="document-card">
                                                <div class="d-flex">
                                                    <div class="document-icon me-3">
                                                        <c:choose>
                                                            <c:when test="${document.documentType eq 'identity'}">
                                                                <i class="bi bi-person-badge"></i>
                                                            </c:when>
                                                            <c:when test="${document.documentType eq 'residence'}">
                                                                <i class="bi bi-house-door"></i>
                                                            </c:when>
                                                            <c:when test="${document.documentType eq 'split'}">
                                                                <i class="bi bi-people"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="bi bi-file-earmark"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0">
                                                            <c:choose>
                                                                <c:when test="${document.documentType eq 'identity'}">
                                                                    Identity Document
                                                                </c:when>
                                                                <c:when test="${document.documentType eq 'residence'}">
                                                                    Proof of Residence
                                                                </c:when>
                                                                <c:when test="${document.documentType eq 'split'}">
                                                                    Split Household Document
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Additional Document
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </h6>
                                                        <p class="mb-0 text-muted small">
                                                            Uploaded on <fmt:formatDate value="${document.uploadDate}" pattern="dd/MM/yyyy" />
                                                        </p>
                                                        <div class="mt-2">
                                                            <a href="${pageContext.request.contextPath}/document/view?id=${document.documentId}" 
                                                               class="btn btn-sm btn-outline-primary" target="_blank">
                                                                <i class="bi bi-eye me-1"></i>View
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/document/download?id=${document.documentId}" 
                                                               class="btn btn-sm btn-outline-secondary ms-2">
                                                                <i class="bi bi-download me-1"></i>Download
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning">
                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                    No documents found for this registration.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Status History Section -->
                    <c:if test="${not empty statusHistories}">
                        <div class="details-section">
                            <h4 class="section-title">Status History</h4>
                            
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Notes</th>
                                            <th>Updated By</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="history" items="${statusHistories}">
                                            <tr>
                                                <td>
                                                    <fmt:formatDate value="${history.changeDate}" pattern="dd/MM/yyyy HH:mm" />
                                                </td>
                                                <td>
                                                    <span class="badge bg-${history.statusColor}">
                                                        ${history.newStatus}
                                                    </span>
                                                </td>
                                                <td>${history.notes}</td>
                                                <td>${history.updatedByName}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between mt-4">
                        <div>
                            <a href="${pageContext.request.contextPath}/registration/showAll" class="btn btn-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Back
                            </a>
                        </div>
                        <div>
                            <c:if test="${isEditable}">
                                <a href="${pageContext.request.contextPath}/registration/edit?id=${registration.registrationId}" 
                                   class="btn btn-primary me-2">
                                    <i class="bi bi-pencil me-2"></i>Edit
                                </a>
                            </c:if>
                            <c:if test="${isCancellable}">
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">
                                    <i class="bi bi-x-circle me-2"></i>Cancel Registration
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Cancel Modal -->
        <c:if test="${isCancellable}">
            <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelModalLabel">Cancel Registration</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to cancel this registration? This action cannot be undone.</p>
                            <form id="cancelForm" action="${pageContext.request.contextPath}/registration/cancel" method="post">
                                <input type="hidden" name="registrationId" value="${registration.registrationId}">
                                <div class="mb-3">
                                    <label for="cancelReason" class="form-label">Reason for Cancellation</label>
                                    <textarea class="form-control" id="cancelReason" name="cancelReason" rows="3" required></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" form="cancelForm" class="btn btn-danger">Cancel Registration</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4">
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