<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Households | Household Management</title>
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
        
        .page-header {
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
        
        .btn-custom-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.2s;
        }
        
        .btn-custom-success:hover {
            background-color: #27ae60;
            border-color: #27ae60;
            color: white;
        }
        
        .btn-custom-warning {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.2s;
        }
        
        .btn-custom-warning:hover {
            background-color: #d35400;
            border-color: #d35400;
            color: white;
        }
        
        .btn-custom-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.2s;
        }
        
        .btn-custom-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
            color: white;
        }
        
        .table-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 0;
            overflow: hidden;
        }
        
        .custom-table {
            margin-bottom: 0;
        }
        
        .custom-table thead th {
            background-color: var(--light-bg);
            border-bottom: 2px solid rgba(0,0,0,0.05);
            color: #495057;
            font-weight: 600;
            padding: 12px 15px;
        }
        
        .custom-table tbody tr {
            transition: all 0.2s;
        }
        
        .custom-table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .custom-table td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        
        .form-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
            color: #495057;
        }
        
        .form-control {
            border-radius: 5px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            transition: all 0.2s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
        
        .form-select {
            border-radius: 5px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            transition: all 0.2s;
        }
        
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .btn-action {
            padding: 4px 8px;
            font-size: 0.8rem;
        }
        
        .hidden {
            display: none;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
            border: none;
        }
        
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success-color);
        }
        
        .alert-danger {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--accent-color);
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                    <i class="bi bi-speedometer2"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/viewAllUsers">
                                    <i class="bi bi-people"></i> User Management
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/viewAllHouseholds">
                                    <i class="bi bi-houses"></i> Household Management
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/viewAllRequests">
                                    <i class="bi bi-file-earmark-text"></i> Request Management
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
                    <!-- Page Header -->
                    <div class="page-header">
                        <h1>Manage Households</h1>
                        <p class="lead mb-0">Create, update, and delete household registrations</p>
                    </div>

                    <!-- Display success/error message -->
                    <c:if test="${not empty message}">
                        <div class="alert ${message.contains('successfully') ? 'alert-success' : 'alert-danger'}">
                            <i class="bi ${message.contains('successfully') ? 'bi-check-circle' : 'bi-exclamation-triangle'} me-2"></i>
                            <c:out value="${message}" />
                        </div>
                    </c:if>

                    <!-- Add Household Button -->
                    <div class="d-flex justify-content-end mb-3">
                        <button id="addHouseholdBtn" class="btn btn-custom-primary">
                            <i class="bi bi-plus-circle me-2"></i>Add New Household
                        </button>
                    </div>

                    <!-- Add Household Form -->
                    <div id="addForm" class="form-container hidden mb-4">
                        <h5 class="mb-3"><i class="bi bi-house-add me-2"></i>Add New Household</h5>
                        <form action="${pageContext.request.contextPath}/admin/manageHouseholds" method="post" onsubmit="return validateForm(this)">
                            <input type="hidden" name="action" value="add">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="addHeadOfHouseholdId" class="form-label">Head of Household</label>
                                    <select name="headOfHouseholdId" id="addHeadOfHouseholdId" class="form-select">
                                        <option value="none">None</option>
                                        <c:forEach var="user" items="${usersList}">
                                            <option value="${user.userId}">${user.fullName} (ID: ${user.userId})</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">Select the primary resident who will be the head of this household.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="addAddress" class="form-label">Address</label>
                                    <input type="text" name="address" id="addAddress" class="form-control" placeholder="Enter full address" required>
                                    <div class="form-text">Enter the complete address of the household.</div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end mt-3">
                                <button type="button" class="btn btn-custom-secondary me-2" onclick="hideForm('addForm')">
                                    <i class="bi bi-x-circle me-2"></i>Cancel
                                </button>
                                <button type="submit" class="btn btn-custom-success">
                                    <i class="bi bi-check-circle me-2"></i>Add Household
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Update Household Form -->
                    <div id="updateForm" class="form-container hidden mb-4">
                        <h5 class="mb-3"><i class="bi bi-pencil-square me-2"></i>Update Household</h5>
                        <form action="${pageContext.request.contextPath}/admin/manageHouseholds" method="post" onsubmit="return validateForm(this)">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="householdId" id="updateHouseholdId">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="updateHeadOfHouseholdId" class="form-label">Head of Household</label>
                                    <select name="headOfHouseholdId" id="updateHeadOfHouseholdId" class="form-select">
                                        <option value="none">None</option>
                                        <c:forEach var="user" items="${usersList}">
                                            <option value="${user.userId}">${user.fullName} (ID: ${user.userId})</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">Change the head of household if needed.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="updateAddress" class="form-label">Address</label>
                                    <input type="text" name="address" id="updateAddress" class="form-control" placeholder="Enter full address" required>
                                    <div class="form-text">Update the household address.</div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end mt-3">
                                <button type="button" class="btn btn-custom-secondary me-2" onclick="hideForm('updateForm')">
                                    <i class="bi bi-x-circle me-2"></i>Cancel
                                </button>
                                <button type="submit" class="btn btn-custom-warning">
                                    <i class="bi bi-check-circle me-2"></i>Update Household
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Households Table -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">All Households</h5>
                            <div class="input-group" style="width: 250px;">
                                <input type="text" class="form-control" id="searchInput" placeholder="Search households...">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                            </div>
                        </div>
                        <div class="table-container">
                            <div class="table-responsive">
                                <table class="table custom-table" id="householdsTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Head of Household</th>
                                            <th>Address</th>
                                            <th>Created Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty householdsList}">
                                                <c:forEach var="household" items="${householdsList}">
                                                    <tr>
                                                        <td><c:out value="${household.householdId}" /></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${household.headName != null}">
                                                                    <div class="d-flex align-items-center">
                                                                        <i class="bi bi-person-circle text-secondary me-2"></i>
                                                                        <c:out value="${household.headName}" />
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">None</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><c:out value="${household.address}" /></td>
                                                        <td><fmt:formatDate value="${household.createdDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <button class="btn btn-sm btn-outline-primary btn-action" title="View Details"
                                                                        onclick="location.href='${pageContext.request.contextPath}/household/view?id=${household.householdId}'">
                                                                    <i class="bi bi-eye"></i>
                                                                </button>
                                                                <button class="btn btn-sm btn-outline-warning btn-action" title="Edit Household"
                                                                        onclick="showUpdateForm(${household.householdId}, ${household.headOfHouseholdId != null ? household.headOfHouseholdId : 'null'}, '${household.address}')">
                                                                    <i class="bi bi-pencil"></i>
                                                                </button>
                                                                <button type="button" class="btn btn-sm btn-outline-danger btn-action" title="Delete Household"
                                                                        data-bs-toggle="modal" data-bs-target="#deleteHouseholdModal"
                                                                        data-household-id="${household.householdId}" data-household-address="${household.address}">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="text-center py-4">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="bi bi-houses text-muted" style="font-size: 2rem;"></i>
                                                            <p class="mt-2 mb-0">No households found.</p>
                                                            <p class="text-muted small">Click "Add New Household" to create one.</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-custom-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>

                    <!-- Footer -->
                    <footer class="mt-5 pt-3 border-top text-center text-muted">
                        <p>&copy; 2023 Household Management System. All rights reserved.</p>
                    </footer>
                </div>
            </div>
        </div>

        <!-- Delete Household Modal -->
        <div class="modal fade" id="deleteHouseholdModal" tabindex="-1" aria-labelledby="deleteHouseholdModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteHouseholdModalLabel">Confirm Deletion</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the household at <span id="deleteHouseholdAddress" class="fw-bold"></span>?</p>
                        <p class="text-danger">This action cannot be undone and will remove all associated household members.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form id="deleteHouseholdForm" action="${pageContext.request.contextPath}/admin/manageHouseholds" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" id="deleteHouseholdId" name="householdId" value="">
                            <button type="submit" class="btn btn-danger">Delete Household</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

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
            
            // Add Household button
            document.getElementById('addHouseholdBtn').addEventListener('click', function() {
                document.getElementById('addForm').classList.remove('hidden');
                document.getElementById('updateForm').classList.add('hidden');
            });
            
            // Setup delete household modal
            const deleteHouseholdModal = document.getElementById('deleteHouseholdModal');
            if (deleteHouseholdModal) {
                deleteHouseholdModal.addEventListener('show.bs.modal', function(event) {
                    const button = event.relatedTarget;
                    const householdId = button.getAttribute('data-household-id');
                    const householdAddress = button.getAttribute('data-household-address');
                    
                    document.getElementById('deleteHouseholdId').value = householdId;
                    document.getElementById('deleteHouseholdAddress').textContent = householdAddress;
                });
            }
            
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keyup', function() {
                    const searchTerm = this.value.toLowerCase();
                    const table = document.getElementById('householdsTable');
                    const rows = table.getElementsByTagName('tr');
                    
                    for (let i = 1; i < rows.length; i++) {
                        const row = rows[i];
                        const cells = row.getElementsByTagName('td');
                        let found = false;
                        
                        for (let j = 0; j < cells.length; j++) {
                            const cellText = cells[j].textContent.toLowerCase();
                            if (cellText.indexOf(searchTerm) > -1) {
                                found = true;
                                break;
                            }
                        }
                        
                        if (found) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    }
                });
            }
        });
        
        function showUpdateForm(householdId, headOfHouseholdId, address) {
            document.getElementById('updateHouseholdId').value = householdId;
            document.getElementById('updateHeadOfHouseholdId').value = headOfHouseholdId === null ? "none" : headOfHouseholdId;
            document.getElementById('updateAddress').value = address;
            document.getElementById('updateForm').classList.remove('hidden');
            document.getElementById('addForm').classList.add('hidden');
            
            // Scroll to the form
            document.getElementById('updateForm').scrollIntoView({ behavior: 'smooth' });
        }
        
        function hideForm(formId) {
            document.getElementById(formId).classList.add('hidden');
        }
        
        function validateForm(form) {
            var address = form.querySelector('input[name="address"]').value.trim();
            
            if (!address) {
                alert('Please fill in the address field.');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>