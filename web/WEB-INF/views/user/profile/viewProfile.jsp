<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile | Household Management</title>
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

            .profile-card {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                padding: 0;
                overflow: hidden;
            }

            .profile-header {
                background-color: var(--light-bg);
                padding: 20px;
                border-bottom: 1px solid rgba(0,0,0,0.05);
            }

            .profile-body {
                padding: 30px;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background-color: var(--primary-color);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                margin: 0 auto 20px;
            }

            .profile-info-item {
                margin-bottom: 20px;
                border-bottom: 1px solid rgba(0,0,0,0.05);
                padding-bottom: 15px;
            }

            .profile-info-item:last-child {
                border-bottom: none;
            }

            .profile-label {
                font-weight: 600;
                color: #6c757d;
                margin-bottom: 5px;
            }

            .profile-value {
                font-size: 1.1rem;
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

            .btn-custom-danger {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
                color: white;
            }

            .btn-custom-danger:hover {
                background-color: #c0392b;
                border-color: #c0392b;
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
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/userprofile/view">
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
                            <h1>User Profile</h1>
                            <p class="lead mb-0">View and manage your personal information</p>
                        </div>

                        <!-- Profile Information -->
                        <div class="row">
                            <div class="col-md-8 mx-auto">
                                <div class="profile-card">
                                    <div class="profile-header text-center py-4">
                                        <div class="profile-avatar">
                                            <div style="width: 120px; height: 120px; margin: 0 auto; overflow: hidden; border-radius: 50%; background-color: var(--primary-color);">

                                                <img src="${avatarPath}"
                                                     alt="Profile Avatar"
                                                     style="width: 100%; height: 100%; object-fit: cover;"
                                                     >

                                            </div>
                                        </div>
                                        <h3 class="mt-3"><c:out value="${sessionScope.loggedInUser.fullName}" /></h3>
                                        <p class="text-muted">Citizen</p>

                                        <!-- Avatar Upload Button -->
                                        <div class="mt-2">
                                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#avatarUploadModal">
                                                <i class="bi bi-camera"></i> Change Avatar
                                            </button>

                                            <!-- Remove Avatar Button - Only show if user has an avatar -->

                                        </div>
                                    </div>
                                    <div class="profile-body">
                                        <div class="profile-info-item">
                                            <div class="profile-label">
                                                <i class="bi bi-envelope me-2"></i>Email Address
                                            </div>
                                            <div class="profile-value">
                                                <c:out value="${sessionScope.loggedInUser.email}" />
                                            </div>
                                        </div>
                                        <div class="profile-info-item">
                                            <div class="profile-label">
                                                <i class="bi bi-geo-alt me-2"></i>Address
                                            </div>
                                            <div class="profile-value">
                                                <c:out value="${sessionScope.loggedInUser.address}" />
                                            </div>
                                        </div>
                                        <div class="profile-info-item">
                                            <div class="profile-label">
                                                <i class="bi bi-card-text me-2"></i>CCCD (Citizen ID)
                                            </div>
                                            <div class="profile-value">
                                                <c:out value="${sessionScope.loggedInUser.cccd}" />
                                            </div>
                                        </div>
                                        <div class="profile-info-item">
                                            <div class="profile-label">
                                                <i class="bi bi-gender-ambiguous me-2"></i>Gender
                                            </div>
                                            <div class="profile-value">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.loggedInUser.gender}">
                                                        <c:out value="${sessionScope.loggedInUser.gender}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not specified</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="profile-info-item">
                                            <div class="profile-label">
                                                <i class="bi bi-telephone me-2"></i>Phone Number
                                            </div>
                                            <div class="profile-value">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.loggedInUser.phoneNumber}">
                                                        <c:out value="${sessionScope.loggedInUser.phoneNumber}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not specified</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-between mt-4">
                                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-custom-primary">
                                                <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                                            </a>
                                            <a href="${pageContext.request.contextPath}/userprofile/update" class="btn btn-custom-primary">
                                                <i class="bi bi-pencil me-2"></i>Edit Profile
                                            </a>
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



            <!-- Avatar Upload Modal -->
            <div class="modal fade" id="avatarUploadModal" tabindex="-1" aria-labelledby="avatarUploadModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="avatarUploadModalLabel">Set Avatar</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/avatar/update" method="post" id="avatarUploadForm">
                                <div class="mb-3">
                                    <label for="avatarUrl" class="form-label">Image URL</label>
                                    <input type="url" class="form-control" id="avatarUrl" name="avatarUrl" placeholder="https://example.com/image.jpg" required>
                                    <div class="form-text">Enter a direct link to an image (JPG, JPEG, PNG, GIF, AVIF).</div>
                                </div>

                                <div class="text-center mt-4">
                                    <div id="imagePreview" style="display: none; margin-bottom: 15px;">
                                        <img src="#" alt="Preview" style="max-width: 100%; max-height: 200px; border-radius: 5px;">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Avatar</button>
                                </div>
                            </form>
                        </div>
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

                // Image preview functionality for URL input
                const avatarUrl = document.getElementById('avatarUrl');
                const imagePreview = document.getElementById('imagePreview');

                // Add null checks to prevent errors
                if (avatarUrl && imagePreview) {
                    const previewImg = imagePreview.querySelector('img');

                    if (previewImg) {
                        avatarUrl.addEventListener('input', function () {
                            if (this.value && this.value.trim() !== '') {
                                previewImg.src = this.value;
                                imagePreview.style.display = 'block';

                                // Handle image load error
                                previewImg.onerror = function () {
                                    imagePreview.style.display = 'none';
                                    alert('Could not load image from the provided URL. Please check the URL and try again.');
                                };
                            } else {
                                imagePreview.style.display = 'none';
                            }
                        });
                    }
                }

                // Display success/error messages
            <c:if test="${not empty sessionScope.successMessage}">
                alert("${sessionScope.successMessage}");
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                alert("${sessionScope.errorMessage}");
                <c:remove var="errorMessage" scope="session" />
            </c:if>
            });
        </script>
    </body>
</html>