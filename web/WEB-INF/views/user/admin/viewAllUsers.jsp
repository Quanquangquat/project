<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View All Users | Household Management</title>
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

            .btn-custom-danger {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
                color: white;
            }

            .btn-custom-danger:hover {
                background-color: #c0392b;
                border-color: #c0392b;
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

            .role-badge {
                padding: 5px 10px;
                border-radius: 50px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .role-admin {
                background-color: rgba(231, 76, 60, 0.1);
                color: var(--accent-color);
            }

            .role-citizen {
                background-color: rgba(52, 152, 219, 0.1);
                color: var(--primary-color);
            }

            .role-manager {
                background-color: rgba(46, 204, 113, 0.1);
                color: var(--success-color);
            }

            .role-officer {
                background-color: rgba(243, 156, 18, 0.1);
                color: var(--warning-color);
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
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/viewAllUsers">
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
                            <h1>User Management</h1>
                            <p class="lead mb-0">View and manage all users in the system</p>
                        </div>

                        <!-- Search and Filters -->
                        <div class="search-filters">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" class="form-control" id="searchInput" placeholder="Search users...">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select" id="roleFilter">
                                        <option value="">All Roles</option>
                                        <option value="Admin">Admin</option>
                                        <option value="Citizen">Citizen</option>
                                        <option value="Manager">Manager</option>
                                        <option value="Officer">Officer</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-custom-primary w-100" id="applyFilters">
                                        <i class="bi bi-funnel me-2"></i>Apply Filters
                                    </button>
                                </div>
                                <div class="col-md-2">
                                    <button class="btn btn-custom-secondary w-100" id="resetFilters">
                                        <i class="bi bi-arrow-counterclockwise me-2"></i>Reset
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Users Table -->
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">All Users</h5>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive">
                                    <table class="table custom-table" id="usersTable">
                                        <thead>
                                            <tr>
                                                <th>User ID</th>
                                                <th>Full Name</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Address</th>
                                                <th>CCCD</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty usersList}">
                                                    <c:forEach var="user" items="${usersList}">
                                                        <tr>
                                                            <td><c:out value="${user.userId}" /></td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <div class="me-2">
                                                                        <i class="bi bi-person-circle text-secondary fs-5"></i>
                                                                    </div>
                                                                    <div>
                                                                        <c:out value="${user.fullName}" />
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td><c:out value="${user.email}" /></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${user.role eq 'Admin'}">
                                                                        <span class="role-badge role-admin">Admin</span>
                                                                    </c:when>
                                                                    <c:when test="${user.role eq 'Citizen'}">
                                                                        <span class="role-badge role-citizen">Citizen</span>
                                                                    </c:when>
                                                                    <c:when test="${user.role eq 'Manager'}">
                                                                        <span class="role-badge role-manager">Manager</span>
                                                                    </c:when>
                                                                    <c:when test="${user.role eq 'Officer'}">
                                                                        <span class="role-badge role-officer">Officer</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="role-badge"><c:out value="${user.role}" /></span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><c:out value="${user.address}" /></td>
                                                            <td><c:out value="${user.cccd}" /></td>
                                                            <td>
                                                                <div class="action-buttons">
                                                                    <a href="${pageContext.request.contextPath}/admin/viewProfile?id=${user.userId}" class="btn btn-sm btn-outline-primary btn-action" title="View Details">
                                                                        <i class="bi bi-eye"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/admin/updateProfile?id=${user.userId}" class="btn btn-sm btn-outline-secondary btn-action" title="Edit User">
                                                                        <i class="bi bi-pencil"></i>
                                                                    </a>
                                                                    <form action="${pageContext.request.contextPath}/admin/manageUsers" method="post" 
                                                                          style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="deleteuser" value="${user.userId}">
                                                                        <button type="submit" class="btn btn-sm btn-outline-danger btn-action" title="Delete User">
                                                                            <i class="bi bi-trash"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="7" class="text-center py-4">
                                                            <div class="d-flex flex-column align-items-center">
                                                                <i class="bi bi-people text-muted" style="font-size: 2rem;"></i>
                                                                <p class="mt-2 mb-0">No users found.</p>
                                                                <p class="text-muted small">Try adjusting your search or filters.</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <!--                                <div class="pagination-container">
                                                                    <div class="page-info">
                                                                        Showing <span id="startRecord">1</span> to <span id="endRecord">10</span> of <span id="totalRecords">100</span> entries
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
                                                                </div>-->
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

            <!-- Delete User Modal -->
            <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteUserModalLabel">Confirm Deletion</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete the user <span id="deleteUserName" class="fw-bold"></span>?</p>
                            <p class="text-danger">This action cannot be undone.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <form id="deleteUserForm" action="${pageContext.request.contextPath} /admin/manageUsers" method="get">
                                <input type="hidden" id="deleteUserId" name="userId" value="delete">
                                <button type="submit" class="btn btn-danger">Delete User</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
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

                                                                                  // Setup delete user modal
                                                                                  const deleteUserModal = document.getElementById('deleteUserModal');
                                                                                  if (deleteUserModal) {
                                                                                      deleteUserModal.addEventListener('show.bs.modal', function (event) {
                                                                                          const button = event.relatedTarget;
                                                                                          const userId = button.getAttribute('data-user-id');
                                                                                          const userName = button.getAttribute('data-user-name');

                                                                                          document.getElementById('deleteUserId').value = userId;
                                                                                          document.getElementById('deleteUserName').textContent = userName;
                                                                                      });
                                                                                  }

                                                                                  // Search functionality
                                                                                  const searchInput = document.getElementById('searchInput');
                                                                                  if (searchInput) {
                                                                                      searchInput.addEventListener('keyup', function () {
                                                                                          const searchTerm = this.value.toLowerCase();
                                                                                          const table = document.getElementById('usersTable');
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

                                                                                  // Role filter functionality
                                                                                  const roleFilter = document.getElementById('roleFilter');
                                                                                  const applyFilters = document.getElementById('applyFilters');

                                                                                  if (applyFilters && roleFilter) {
                                                                                      applyFilters.addEventListener('click', function () {
                                                                                          const selectedRole = roleFilter.value.toLowerCase();
                                                                                          const table = document.getElementById('usersTable');
                                                                                          const rows = table.getElementsByTagName('tr');

                                                                                          for (let i = 1; i < rows.length; i++) {
                                                                                              const row = rows[i];
                                                                                              const roleCell = row.getElementsByTagName('td')[3];

                                                                                              if (!roleCell)
                                                                                                  continue;

                                                                                              const roleName = roleCell.textContent.toLowerCase();

                                                                                              if (selectedRole === '' || roleName.indexOf(selectedRole) > -1) {
                                                                                                  row.style.display = '';
                                                                                              } else {
                                                                                                  row.style.display = 'none';
                                                                                              }
                                                                                          }
                                                                                      });
                                                                                  }

                                                                                  // Reset filters
                                                                                  const resetFilters = document.getElementById('resetFilters');
                                                                                  if (resetFilters) {
                                                                                      resetFilters.addEventListener('click', function () {
                                                                                          if (searchInput)
                                                                                              searchInput.value = '';
                                                                                          if (roleFilter)
                                                                                              roleFilter.value = '';

                                                                                          const table = document.getElementById('usersTable');
                                                                                          const rows = table.getElementsByTagName('tr');

                                                                                          for (let i = 1; i < rows.length; i++) {
                                                                                              rows[i].style.display = '';
                                                                                          }
                                                                                      });
                                                                                  }
                                                                              });
        </script>
    </body>
</html>