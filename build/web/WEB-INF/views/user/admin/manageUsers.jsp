<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Users</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .hidden {
                display: none;
            }
            .form-container {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="mt-4">Manage Users</h1>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <p class="lead">Admin: <c:out value="${sessionScope.loggedInUser.fullName}" /></p>
                


                <!-- Display success/error message -->
                <c:if test="${not empty message}">
                    <div class="alert ${message.contains('successfully') ? 'alert-success' : 'alert-danger'} mt-3">
                        <c:out value="${message}" />
                    </div>
                </c:if>

                <!-- Search Form -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h5 class="card-title">Search Users</h5>
                        <form action="${pageContext.request.contextPath}/admin/manageUsers" method="post" class="row g-3">
                            <input type="hidden" name="action" value="search">
                            <div class="col-md-3">
                                <label for="searchCccd" class="form-label">CCCD:</label>
                                <input type="text" name="searchCccd" id="searchCccd" class="form-control" placeholder="Enter CCCD">
                            </div>
                            <div class="col-md-3">
                                <label for="searchFullName" class="form-label">Full Name:</label>
                                <input type="text" name="searchFullName" id="searchFullName" class="form-control" placeholder="Enter Full Name">
                            </div>
                            <div class="col-md-3">
                                <label for="searchEmail" class="form-label">Email:</label>
                                <input type="text" name="searchEmail" id="searchEmail" class="form-control" placeholder="Enter Email">
                            </div>
                            <div class="col-md-3">
                                <label for="searchAddress" class="form-label">Address:</label>
                                <input type="text" name="searchAddress" id="searchAddress" class="form-control" placeholder="Enter Address">
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">Search</button>
                                <button type="button" class="btn btn-secondary" onclick="clearSearch()">Clear Search</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Add User Button and Form -->
                <button id="addUserBtn" class="btn btn-primary mt-3">Add User</button>
                <div id="addForm" class="form-container hidden">
                    <form action="${pageContext.request.contextPath}/admin/manageUsers" method="post" onsubmit="return validateForm(this)">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label for="addFullName">Full Name:</label>
                            <input type="text" name="fullName" id="addFullName" class="form-control" placeholder="Enter Full Name" required>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addEmail">Email:</label>
                            <input type="email" name="email" id="addEmail" class="form-control" placeholder="Enter Email" required>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addPassword">Password:</label>
                            <input type="password" name="password" id="addPassword" class="form-control" placeholder="Enter Password" required>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addRole">Role:</label>
                            <select name="role" id="addRole" class="form-control" required>
                                <option value="">Select a Role</option>
                                <c:forEach var="role" items="${rolesList}">
                                    <option value="${role.roleId}">${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addAddress">Address:</label>
                            <input type="text" name="address" id="addAddress" class="form-control" placeholder="Enter Address" required>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addCccd">CCCD:</label>
                            <input type="text" name="cccd" id="addCccd" class="form-control" placeholder="Enter CCCD (12 digits)" required>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addGender">Gender:</label>
                            <select name="gender" id="addGender" class="form-control">
                                <option value="">-- Select Gender --</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group mt-2">
                            <label for="addPhoneNumber">Phone Number:</label>
                            <input type="tel" name="phoneNumber" id="addPhoneNumber" class="form-control" placeholder="Enter Phone Number" pattern="[0-9]{10,11}" maxlength="11">
                        </div>
                        <button type="submit" class="btn btn-success mt-3">Add User</button>
                        <button type="button" class="btn btn-secondary mt-3" onclick="hideForm('addForm')">Cancel</button>
                    </form>
                </div>

                <!-- User Table -->
                <div class="table-responsive mt-4">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Address</th>
                            <th>CCCD</th>
                            <th>Gender</th>
                            <th>Phone Number</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty usersList}">
                                <c:forEach var="user" items="${usersList}">
                                    <tr>
                                        <td><c:out value="${user.userId}" /></td>
                                        <td><c:out value="${user.fullName}" /></td>
                                        <td><c:out value="${user.email}" /></td>
                                        <td><c:out value="${user.role != null ? user.role : 'Unknown'}" /></td>
                                        <td><c:out value="${user.address}" /></td>
                                        <td><c:out value="${user.cccd}" /></td>
                                        <td><c:out value="${user.gender != null ? user.gender : ''}" /></td>
                                        <td><c:out value="${user.phoneNumber != null ? user.phoneNumber : ''}" /></td>
                                        <td>
                                            <!-- Update Button -->
                                            <a href="${pageContext.request.contextPath}/admin/updateProfile?id=${user.userId}" class="btn btn-warning btn-sm" title="Update User">
                                                Update
                                            </a>
                                            <!-- Delete Button -->
                                            <form action="${pageContext.request.contextPath}/admin/manageUsers" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="deleteuser" value="${user.userId}">
                                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center">No users found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                    
                </div>

                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>

                <script>
                    function showUpdateForm(userId, fullName, email, roleId, address, cccd, gender, phoneNumber) {
                        document.getElementById('updateUserId').value = userId;
                        document.getElementById('updateFullName').value = fullName;
                        document.getElementById('updateEmail').value = email;
                        document.getElementById('updateRole').value = roleId;
                        document.getElementById('updateAddress').value = address;
                        document.getElementById('updateCccd').value = cccd;
                        document.getElementById('updateGender').value = gender;
                        document.getElementById('updatePhoneNumber').value = phoneNumber;
                        document.getElementById('updateForm').classList.remove('hidden');
                    }

                    function hideForm(formId) {
                        document.getElementById(formId).classList.add('hidden');
                    }

                    document.getElementById('addUserBtn').addEventListener('click', function () {
                        document.getElementById('addForm').classList.remove('hidden');
                    });

                    function validateForm(form) {
                        var fullName = form.querySelector('input[name="fullName"]').value;
                        var email = form.querySelector('input[name="email"]').value;
                        var role = form.querySelector('select[name="role"]').value;
                        var address = form.querySelector('input[name="address"]').value;
                        var cccd = form.querySelector('input[name="cccd"]').value;
                        var password = form.querySelector('input[name="password"]') ? form.querySelector('input[name="password"]').value : '';

                        if (!fullName || !email || !role || !address || !cccd) {
                            alert('Please fill in all required fields.');
                            return false;
                        }

                        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailPattern.test(email)) {
                            alert('Please enter a valid email address.');
                            return false;
                        }

                        if (role === "") {
                            alert('Please select a role.');
                            return false;
                        }

                        var cccdPattern = /^\d{12}$/;
                        if (!cccdPattern.test(cccd)) {
                            alert('CCCD must be a 12-digit number.');
                            return false;
                        }

                        if (form.querySelector('input[name="action"]').value === 'add' && !password) {
                            alert('Password is required for adding a new user.');
                            return false;
                        }

                        return true;
                    }

                    function clearSearch() {
                        document.getElementById('searchCccd').value = '';
                        document.getElementById('searchFullName').value = '';
                        document.getElementById('searchEmail').value = '';
                        document.getElementById('searchAddress').value = '';
                        document.querySelector('form[action="/admin/manageUsers"]').submit();
                    }
                </script>
            </c:if>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>