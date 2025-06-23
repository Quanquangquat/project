<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password | Household Management</title>
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
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                padding: 20px;
            }

            .auth-container {
                width: 100%;
                max-width: 450px;
            }

            .auth-card {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .auth-header {
                background: linear-gradient(135deg, var(--primary-color), #2980b9);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .auth-header h3 {
                margin: 0;
                font-weight: 600;
            }

            .auth-body {
                padding: 30px;
            }

            .form-control {
                border-radius: 5px;
                padding: 12px 15px;
                border: 1px solid #ced4da;
                transition: all 0.2s;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 12px 15px;
                font-weight: 500;
                transition: all 0.2s;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            .auth-footer {
                text-align: center;
                margin-top: 20px;
                color: #6c757d;
            }

            .auth-footer a {
                color: var(--primary-color);
                text-decoration: none;
            }

            .auth-footer a:hover {
                text-decoration: underline;
            }

            .alert {
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 20px;
            }

            .otp-input-container {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .otp-input {
                width: 50px;
                height: 50px;
                text-align: center;
                font-size: 1.5rem;
                border: 1px solid #ced4da;
                border-radius: 5px;
            }

            .otp-input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
                outline: none;
            }

            .step-indicator {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .step {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background-color: #e9ecef;
                color: #6c757d;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 5px;
                font-weight: 600;
            }

            .step.active {
                background-color: var(--primary-color);
                color: white;
            }

            .step-line {
                height: 2px;
                width: 50px;
                background-color: #e9ecef;
                margin-top: 15px;
            }

            .step-line.active {
                background-color: var(--primary-color);
            }
        </style>
    </head>
    <body>
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h3>Forgot Password</h3>
                    <p class="mb-0">Reset your password</p>
                </div>
                <div class="auth-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle me-2"></i>${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty sessionScope.otp}">
                            <!-- OTP Verification Form -->
                            <div class="step-indicator">
                                <div class="step active">1</div>
                                <div class="step-line active"></div>
                                <div class="step active">2</div>
                                <div class="step-line"></div>
                                <div class="step">3</div>
                            </div>

                            <p class="text-center mb-4">Enter the 6-digit verification code sent to your email</p>
                            <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                                <div class="mb-4">
                                    <label for="otp" class="form-label">Verification Code</label>
                                    <input type="text" class="form-control" id="otp" name="otp"
                                           maxlength="6" pattern="[0-9]{6}"
                                           placeholder="Enter 6-digit code" required>
                                    <div class="form-text">
                                        Didn't receive the code?
                                        <a href="${pageContext.request.contextPath}/forgot-password">Resend code</a>
                                        or
                                        <a href="${pageContext.request.contextPath}/forgot-password?changeEmail=true">Change email</a>
                                    </div>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Verify Code</button>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <!-- Email Form -->
                            <div class="step-indicator">
                                <div class="step active">1</div>
                                <div class="step-line"></div>
                                <div class="step">2</div>
                                <div class="step-line"></div>
                                <div class="step">3</div>
                            </div>

                            <p class="text-center mb-4">Enter your email address to receive a verification code</p>
                            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                                <div class="mb-4">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email"
                                           placeholder="Enter your email" required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Send Verification Code</button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="auth-footer">
                <p>Remember your password? <a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Auto-focus on first input
                const firstInput = document.querySelector('input:not([type=hidden])');
                if (firstInput) {
                    firstInput.focus();
                }

                // Handle OTP input if present
                const otpInput = document.getElementById('otp');
                if (otpInput) {
                    // Only allow numbers
                    otpInput.addEventListener('input', function (e) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });

                    // Auto-submit when 6 digits are entered
                    otpInput.addEventListener('input', function (e) {
                        if (this.value.length === 6) {
                            this.form.submit();
                        }
                    });
                }
            });
        </script>
    </body>
</html>