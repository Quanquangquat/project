<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password | Household Management</title>
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

            .password-requirements {
                font-size: 0.85rem;
                color: #6c757d;
                margin-top: 10px;
            }

            .password-requirements ul {
                padding-left: 20px;
                margin-bottom: 0;
            }

            .requirement {
                margin-bottom: 5px;
                display: flex;
                align-items: center;
            }

            .requirement i {
                margin-right: 5px;
            }

            .requirement.valid {
                color: var(--success-color);
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
                    <h3>Reset Password</h3>
                    <p class="mb-0">Create a new password</p>
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

                    <div class="step-indicator">
                        <div class="step active">1</div>
                        <div class="step-line active"></div>
                        <div class="step active">2</div>
                        <div class="step-line active"></div>
                        <div class="step active">3</div>
                    </div>

                    <form action="${pageContext.request.contextPath}/reset-password" method="post" id="resetPasswordForm">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                            <div class="password-requirements mt-2">
                                <div class="requirement" id="length-req">
                                    <i class="bi bi-x-circle"></i> At least 8 characters
                                </div>
                                <div class="requirement" id="uppercase-req">
                                    <i class="bi bi-x-circle"></i> At least one uppercase letter
                                </div>
                                <div class="requirement" id="lowercase-req">
                                    <i class="bi bi-x-circle"></i> At least one lowercase letter
                                </div>
                                <div class="requirement" id="number-req">
                                    <i class="bi bi-x-circle"></i> At least one number
                                </div>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            <div class="form-text" id="password-match-message"></div>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary" id="resetBtn">Reset Password</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="auth-footer">
                <p>Remember your password? <a href="${pageContext.request.contextPath}/auth/login">Back to Login</a></p>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');
                const resetBtn = document.getElementById('resetBtn');
                const passwordMatchMessage = document.getElementById('password-match-message');

                // Password requirements elements
                const lengthReq = document.getElementById('length-req');
                const uppercaseReq = document.getElementById('uppercase-req');
                const lowercaseReq = document.getElementById('lowercase-req');
                const numberReq = document.getElementById('number-req');

                // Function to validate password
                function validatePassword() {
                    const password = newPassword.value;

                    // Check length
                    if (password.length >= 8) {
                        lengthReq.classList.add('valid');
                        lengthReq.querySelector('i').className = 'bi bi-check-circle';
                    } else {
                        lengthReq.classList.remove('valid');
                        lengthReq.querySelector('i').className = 'bi bi-x-circle';
                    }

                    // Check uppercase
                    if (/[A-Z]/.test(password)) {
                        uppercaseReq.classList.add('valid');
                        uppercaseReq.querySelector('i').className = 'bi bi-check-circle';
                    } else {
                        uppercaseReq.classList.remove('valid');
                        uppercaseReq.querySelector('i').className = 'bi bi-x-circle';
                    }

                    // Check lowercase
                    if (/[a-z]/.test(password)) {
                        lowercaseReq.classList.add('valid');
                        lowercaseReq.querySelector('i').className = 'bi bi-check-circle';
                    } else {
                        lowercaseReq.classList.remove('valid');
                        lowercaseReq.querySelector('i').className = 'bi bi-x-circle';
                    }

                    // Check number
                    if (/[0-9]/.test(password)) {
                        numberReq.classList.add('valid');
                        numberReq.querySelector('i').className = 'bi bi-check-circle';
                    } else {
                        numberReq.classList.remove('valid');
                        numberReq.querySelector('i').className = 'bi bi-x-circle';
                    }

                    // Check if passwords match
                    if (confirmPassword.value) {
                        checkPasswordsMatch();
                    }
                }

                // Function to check if passwords match
                function checkPasswordsMatch() {
                    if (newPassword.value === confirmPassword.value) {
                        passwordMatchMessage.textContent = 'Passwords match';
                        passwordMatchMessage.className = 'form-text text-success';
                        confirmPassword.classList.remove('is-invalid');
                        confirmPassword.classList.add('is-valid');
                    } else {
                        passwordMatchMessage.textContent = 'Passwords do not match';
                        passwordMatchMessage.className = 'form-text text-danger';
                        confirmPassword.classList.remove('is-valid');
                        confirmPassword.classList.add('is-invalid');
                    }
                }

                // Add event listeners
                if (newPassword) {
                    newPassword.addEventListener('input', validatePassword);
                }

                if (confirmPassword) {
                    confirmPassword.addEventListener('input', checkPasswordsMatch);
                }

                // Form submission validation
                const form = document.getElementById('resetPasswordForm');
                if (form) {
                    form.addEventListener('submit', function (e) {
                        const password = newPassword.value;
                        const confirmPwd = confirmPassword.value;

                        // Check if passwords match
                        if (password !== confirmPwd) {
                            e.preventDefault();
                            passwordMatchMessage.textContent = 'Passwords do not match';
                            passwordMatchMessage.className = 'form-text text-danger';
                            return false;
                        }

                        // Check password requirements
                        const isLengthValid = password.length >= 8;
                        const isUppercaseValid = /[A-Z]/.test(password);
                        const isLowercaseValid = /[a-z]/.test(password);
                        const isNumberValid = /[0-9]/.test(password);

                        if (!isLengthValid || !isUppercaseValid || !isLowercaseValid || !isNumberValid) {
                            e.preventDefault();
                            alert('Please ensure your password meets all requirements.');
                            return false;
                        }

                        return true;
                    });
                }
            });
        </script>
    </body>
</html>