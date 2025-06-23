<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
         prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Login - Residence Registration System</title>
        <link
            href="${pageContext.request.contextPath}/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
            />
        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
            }
            .login-container {
                max-width: 450px;
                margin: 0 auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                margin-top: 80px;
            }
            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .login-icon {
                font-size: 3rem;
                color: #0d6efd;
                margin-bottom: 15px;
            }
            .form-floating {
                margin-bottom: 20px;
            }
            .btn-login {
                padding: 10px;
                font-weight: 500;
            }
            .login-footer {
                text-align: center;
                margin-top: 20px;
            }
            .alert {
                margin-bottom: 20px;
            }
            .navbar {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
                                class="nav-link active"
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

        <div class="container">
            <div class="login-container">
                <div class="login-header">
                    <i class="bi bi-shield-lock login-icon"></i>
                    <h2>Welcome Back</h2>
                    <p class="text-muted">Sign in to access your account</p>
                </div>

                <c:if test="${not empty error}">
                    <div
                        class="alert alert-danger alert-dismissible fade show"
                        role="alert"
                        >
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <c:out value="${error}" />
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="alert"
                            aria-label="Close"
                            ></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-floating">
                        <input
                            type="email"
                            name="email"
                            class="form-control"
                            id="floatingEmail"
                            placeholder="name@example.com"
                            required
                            />
                        <label for="floatingEmail"
                               ><i class="bi bi-envelope me-2"></i>Email address</label
                        >
                    </div>

                    <div class="form-floating">
                        <input
                            type="password"
                            name="password"
                            class="form-control"
                            id="floatingPassword"
                            placeholder="Password"
                            required
                            />
                        <label for="floatingPassword"
                               ><i class="bi bi-key me-2"></i>Password</label
                        >
                    </div>

                    <div class="form-check mb-3">
                        <input
                            class="form-check-input"
                            type="checkbox"
                            name="rememberMe"
                            value="on"
                            id="rememberMe"


                            />
                        <label class="form-check-label" for="rememberMe">
                            Remember me
                        </label>
                        <a
                            href="${pageContext.request.contextPath}/forgot-password"
                            class="float-end"
                            >Forgot Password?</a
                        >
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-login">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                        </button>
                    </div>
                </form>

                <div class="login-footer">
                    <p>
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/register"
                           >Register here</a
                        >
                    </p>
                    <a
                        href="${pageContext.request.contextPath}/"
                        class="text-decoration-none"
                        >
                        <i class="bi bi-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>



    </body>
</html>
