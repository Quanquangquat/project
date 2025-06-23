<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Residence Registration Management System</title>
    <link
      href="${pageContext.request.contextPath}/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <style>
      .hero-section {
        background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
          url("https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80");
        background-size: cover;
        background-position: center;
        color: white;
        padding: 100px 0;
        margin-bottom: 40px;
      }
      .feature-card {
        padding: 20px;
        text-align: center;
        margin-bottom: 30px;
      }
      .feature-icon {
        font-size: 2.5rem;
        margin-bottom: 15px;
        color: #0d6efd;
      }
    </style>
  </head>
  <body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="#">
          <i class="bi bi-building-fill me-2"></i>
          Residence Registration System
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <a
                class="nav-link"
                href="${pageContext.request.contextPath}/login"
              >
                <i class="bi bi-box-arrow-in-right me-1"></i> Login
              </a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="${pageContext.request.contextPath}/register"
              >
                <i class="bi bi-person-plus me-1"></i> Register
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
      <div class="container text-center">
        <h1 class="display-4 mb-4">Residence Registration Management</h1>
        <p class="lead mb-4">
          Efficiently manage permanent, temporary, and temporary absence
          registrations
        </p>
        <div class="d-grid gap-2 d-md-block">
          <a
            href="${pageContext.request.contextPath}/register"
            class="btn btn-primary btn-lg me-md-2"
          >
            <i class="bi bi-person-plus-fill me-2"></i>Get Started
          </a>
          <a
            href="${pageContext.request.contextPath}/login"
            class="btn btn-outline-light btn-lg"
          >
            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
          </a>
        </div>
      </div>
    </div>

    <!-- Features Section -->
    <div class="container mb-5">
      <div class="row">
        <div class="col-md-4">
          <div class="feature-card">
            <i class="bi bi-house-check feature-icon"></i>
            <h3>Permanent Registration</h3>
            <p>Register and manage permanent residence information</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="feature-card">
            <i class="bi bi-calendar-date feature-icon"></i>
            <h3>Temporary Registration</h3>
            <p>Process and track temporary residence registrations</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="feature-card">
            <i class="bi bi-geo-alt feature-icon"></i>
            <h3>Temporary Absence</h3>
            <p>Manage temporary absence notifications and records</p>
          </div>
        </div>
      </div>
    </div>

    <!-- About Section -->
    <div class="container mb-5">
      <div class="row align-items-center">
        <div class="col-lg-6 mb-4 mb-lg-0">
          <h2>About Our System</h2>
          <p>
            Our Residence Registration Management System provides a
            comprehensive solution for local authorities and property managers
            to efficiently handle all types of residence registrations.
          </p>
          <p>
            The system streamlines the process of registering permanent
            residents, temporary residents, and managing temporary absence
            notifications, ensuring compliance with local regulations.
          </p>
          <a href="#" class="btn btn-primary">Learn More</a>
        </div>
        <div class="col-lg-6">
          <img
            src="https://images.unsplash.com/photo-1554469384-e58fac16e23a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80"
            alt="Residence Registration"
            class="img-fluid rounded shadow"
          />
        </div>
      </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light py-4 mt-auto">
      <div class="container">
        <div class="row">
          <div class="col-md-6 text-center text-md-start">
            <p class="mb-0">
              &copy; 2024 Residence Registration System. All rights reserved.
            </p>
          </div>
          <div class="col-md-6 text-center text-md-end">
            <a href="#" class="text-decoration-none me-3">Privacy Policy</a>
            <a href="#" class="text-decoration-none me-3">Terms of Service</a>
            <a href="#" class="text-decoration-none">Contact</a>
          </div>
        </div>
      </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
  </body>
</html>
