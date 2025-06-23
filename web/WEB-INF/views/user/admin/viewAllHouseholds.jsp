<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Households | Household Management</title>
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
        
        .search-filters {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
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
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .btn-action {
            padding: 4px 8px;
            font-size: 0.8rem;
        }
        
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background-color: var(--light-bg);
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        
        .page-info {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .badge-household {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--primary-color);
            padding: 5px 10px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
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
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/userProfile.jsp">
                                    <i class="bi bi-person-circle"></i> My Profile
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
                        <h1>Household Management</h1>
                        <p class="lead mb-0">View and manage all registered households in the system</p>
                    </div>

                    <!-- Success and Error Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <!-- Search and Filters -->
                    <div class="search-filters">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search by address, head name...">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-calendar-date"></i></span>
                                    <input type="date" class="form-control" id="dateFilter" placeholder="Filter by date">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-custom-secondary w-100" id="resetFilters">
                                    <i class="bi bi-arrow-counterclockwise me-2"></i>Reset
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Overview -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body d-flex align-items-center">
                                    <div class="rounded-circle p-3 bg-primary bg-opacity-10 me-3">
                                        <i class="bi bi-houses text-primary fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted mb-1">Total Households</h6>
                                        <h3 class="mb-0">${householdsList.size()}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body d-flex align-items-center">
                                    <div class="rounded-circle p-3 bg-success bg-opacity-10 me-3">
                                        <i class="bi bi-person-check text-success fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted mb-1">With Household Head</h6>
                                        <h3 class="mb-0">
                                            <c:set var="withHeadCount" value="0" />
                                            <c:forEach var="household" items="${householdsList}">
                                                <c:if test="${household.headName != null}">
                                                    <c:set var="withHeadCount" value="${withHeadCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${withHeadCount}
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body d-flex align-items-center">
                                    <div class="rounded-circle p-3 bg-warning bg-opacity-10 me-3">
                                        <i class="bi bi-calendar-check text-warning fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted mb-1">Created This Month</h6>
                                        <h3 class="mb-0">
                                            <c:set var="thisMonthCount" value="0" />
                                            <c:set var="currentMonth" value="<%=java.time.LocalDate.now().getMonthValue()%>" />
                                            <c:set var="currentYear" value="<%=java.time.LocalDate.now().getYear()%>" />
                                            <c:forEach var="household" items="${householdsList}">
                                                <jsp:useBean id="date" class="java.util.Date" />
                                                <c:set target="${date}" property="time" value="${household.createdDate.time}" />
                                                <c:if test="${date.month + 1 == currentMonth && date.year + 1900 == currentYear}">
                                                    <c:set var="thisMonthCount" value="${thisMonthCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${thisMonthCount}
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Households Table -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">All Households</h5>
                            <div>
                                <a href="${pageContext.request.contextPath}/admin/manageHouseholds" class="btn btn-sm btn-custom-primary">
                                    <i class="bi bi-gear me-1"></i> Manage Households
                                </a>
                                <button class="btn btn-sm btn-outline-secondary ms-2" id="exportBtn">
                                    <i class="bi bi-download me-1"></i> Export
                                </button>
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
                                                        <td>
                                                            <span class="badge-household">#<c:out value="${household.householdId}" /></span>
                                                        </td>
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
                                                        <td><fmt:formatDate value="${household.createdDate}" pattern="dd MMM yyyy" /></td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <a href="${pageContext.request.contextPath}/admin/viewHousehold?id=${household.householdId}" class="btn btn-sm btn-outline-primary btn-action" title="View Details">
                                                                    <i class="bi bi-eye"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/admin/manageHouseholds?edit=${household.householdId}" class="btn btn-sm btn-outline-secondary btn-action" title="Edit Household">
                                                                    <i class="bi bi-pencil"></i>
                                                                </a>
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
                                                            <p class="text-muted small">Try adding a new household from the Manage Households page.</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${not empty householdsList && householdsList.size() > 10}">
                                <div class="pagination-container">
                                    <div class="page-info">
                                        Showing <span id="startRecord">1</span> to <span id="endRecord">10</span> of <span id="totalRecords">${householdsList.size()}</span> entries
                                    </div>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination mb-0">
                                            <li class="page-item disabled">
                                                <a class="page-link" href="#" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-custom-secondary">
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
            
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keyup', function() {
                    filterTable();
                });
            }
            
            // Date filter functionality
            const dateFilter = document.getElementById('dateFilter');
            if (dateFilter) {
                dateFilter.addEventListener('change', function() {
                    filterTable();
                });
            }
            
            // Reset filters
            const resetFilters = document.getElementById('resetFilters');
            if (resetFilters) {
                resetFilters.addEventListener('click', function() {
                    if (searchInput) searchInput.value = '';
                    if (dateFilter) dateFilter.value = '';
                    
                    const table = document.getElementById('householdsTable');
                    const rows = table.getElementsByTagName('tr');
                    
                    for (let i = 1; i < rows.length; i++) {
                        rows[i].style.display = '';
                    }
                });
            }
            
            // Export button
            const exportBtn = document.getElementById('exportBtn');
            if (exportBtn) {
                exportBtn.addEventListener('click', function() {
                    alert('Export functionality would be implemented here.');
                    // In a real implementation, this would trigger a download of the data in CSV or Excel format
                });
            }
            
            // Function to filter the table based on search input and date filter
            function filterTable() {
                const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
                const dateValue = dateFilter ? dateFilter.value : '';
                
                const table = document.getElementById('householdsTable');
                const rows = table.getElementsByTagName('tr');
                
                for (let i = 1; i < rows.length; i++) {
                    const row = rows[i];
                    const cells = row.getElementsByTagName('td');
                    
                    if (cells.length === 0) continue; // Skip if no cells (like in "No households found" row)
                    
                    let matchesSearch = false;
                    let matchesDate = true; // Default to true if no date filter
                    
                    // Check search term
                    for (let j = 0; j < cells.length; j++) {
                        const cellText = cells[j].textContent.toLowerCase();
                        if (cellText.indexOf(searchTerm) > -1) {
                            matchesSearch = true;
                            break;
                        }
                    }
                    
                    // Check date if filter is applied
                    if (dateValue) {
                        const dateCell = cells[3]; // Assuming the date is in the 4th column (index 3)
                        const cellDate = new Date(dateCell.textContent);
                        const filterDate = new Date(dateValue);
                        
                        // Compare only year, month, and day
                        matchesDate = cellDate.getFullYear() === filterDate.getFullYear() &&
                                     cellDate.getMonth() === filterDate.getMonth() &&
                                     cellDate.getDate() === filterDate.getDate();
                    }
                    
                    // Show/hide row based on both filters
                    if (matchesSearch && matchesDate) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            }
        });
    </script>
</body>
</html>