<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Household | Household Management</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/household/create">
                                <i class="bi bi-people"></i> Create Household
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/registration/choose">
                                <i class="bi bi-file-earmark-text"></i> Registration Requests
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/citizen/transferHousehold">
                                <i class="bi bi-arrow-left-right"></i> Transfer Household
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
                    <h1><i class="bi bi-people me-2"></i>Create Household</h1>
                    <p class="lead mb-0">Create a new household and manage its members</p>
                </div>
                <!-- Success/Error Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <!-- Form tạo hộ khẩu -->
                <div class="card mb-4">
                    <div class="card-header">Create Household</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/household/create" method="post">
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            <div class="mb-3">
                                <label for="areaId" class="form-label">Area</label>
                                <select class="form-select" id="areaId" name="areaId" required>
                                    <option value="">-- Select Area --</option>
                                    <c:forEach var="area" items="${areas}">
                                        <option value="${area.areaId}">${area.areaName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-custom-primary">Create Household</button>
                        </form>
                    </div>
                </div>
                <!-- Form thêm thành viên vào hộ khẩu (chỉ hiển thị nếu đã có householdId) -->
                <c:if test="${not empty householdId}">
                <div class="card mb-4">
                    <div class="card-header">Add Household Member</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/member/add" method="post">
                            <input type="hidden" name="householdId" value="${householdId}">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="">-- Select --</option>
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="relationship" class="form-label">Relationship</label>
                                    <select class="form-select" id="relationship" name="relationship" required>
                                        <option value="">-- Select --</option>
                                        <option value="Chủ hộ">Chủ hộ</option>
                                        <option value="Vợ/Chồng">Vợ/Chồng</option>
                                        <option value="Con cái">Con cái</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="phoneNumber" class="form-label">Phone Number</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
                                </div>
                                <div class="col-md-4">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="cccd" class="form-label">CCCD</label>
                                <input type="text" class="form-control" id="cccd" name="cccd">
                            </div>
                            <button type="submit" class="btn btn-custom-primary">Add Member</button>
                        </form>
                    </div>
                </div>
                <!-- Danh sách thành viên trong hộ khẩu -->
                <div class="card">
                    <div class="card-header">Household Members</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty members}">
                                <p class="text-center text-muted">No members in this household.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Full Name</th>
                                                <th>Gender</th>
                                                <th>Relationship</th>
                                                <th>Date of Birth</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>CCCD</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="member" items="${members}">
                                                <tr>
                                                    <td>${member.fullName}</td>
                                                    <td>${member.gender}</td>
                                                    <td>${member.relationship}</td>
                                                    <td><fmt:formatDate value="${member.dateOfBirth}" pattern="dd/MM/yyyy" /></td>
                                                    <td>${member.phoneNumber}</td>
                                                    <td>${member.email}</td>
                                                    <td>${member.cccd}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                </c:if>
                <!-- Footer -->
                <footer class="mt-5 pt-3 border-top text-center text-muted">
                    <p>&copy; 2023 Household Management System. All rights reserved.</p>
                </footer>
            </div>
        </div>
    </div>
</c:if>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html> 