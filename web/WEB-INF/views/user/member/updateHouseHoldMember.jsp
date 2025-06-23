<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Household Member | Household Management</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .container {
                max-width: 800px;
                margin: 40px auto;
                padding: 0;
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            .card-header {
                background-color: #3498db;
                color: white;
                border-radius: 10px 10px 0 0 !important;
                padding: 15px 20px;
            }

            .card-body {
                padding: 25px;
            }

            h1, h2, h3 {
                color: #2c3e50;
            }

            .form-label {
                font-weight: 600;
                color: #34495e;
            }

            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
                padding: 10px 20px;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            .btn-secondary {
                background-color: #95a5a6;
                border-color: #95a5a6;
                padding: 10px 20px;
            }

            .btn-secondary:hover {
                background-color: #7f8c8d;
                border-color: #7f8c8d;
            }

            .alert {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">Update Household Member</h2>
                    <a href="${pageContext.request.contextPath}/household/view?householdId=${member.householdId}" class="btn btn-light">
                        <i class="bi bi-arrow-left"></i> Back to Household
                    </a>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/household/updateMember" method="post">
                        <input type="hidden" name="memberId" value="${member.memberId}">
                        <input type="hidden" name="householdId" value="${member.householdId}">

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${member.fullName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="relationship" class="form-label">Relationship to Head <span class="text-danger">*</span></label>
                            <select class="form-select" id="relationship" name="relationship" required onchange="checkOtherRelationship()">
                                <option value="">Select relationship</option>
                                <option value="Spouse" ${member.relationship == 'Spouse' ? 'selected' : ''}>Spouse</option>
                                <option value="Child" ${member.relationship == 'Child' ? 'selected' : ''}>Child</option>
                                <option value="Parent" ${member.relationship == 'Parent' ? 'selected' : ''}>Parent</option>
                                <option value="Sibling" ${member.relationship == 'Sibling' ? 'selected' : ''}>Sibling</option>
                                <option value="Grandparent" ${member.relationship == 'Grandparent' ? 'selected' : ''}>Grandparent</option>
                                <option value="Grandchild" ${member.relationship == 'Grandchild' ? 'selected' : ''}>Grandchild</option>
                                <option value="Other" ${!['Spouse', 'Child', 'Parent', 'Sibling', 'Grandparent', 'Grandchild'].contains(member.relationship) ? 'selected' : ''}>Other</option>
                            </select>
                        </div>

                        <div class="mb-3" id="otherRelationshipDiv" style="display: none;">
                            <label for="otherRelationship" class="form-label">Specify Relationship</label>
                            <input type="text" class="form-control" id="otherRelationship" name="otherRelationship" value="${!['Spouse', 'Child', 'Parent', 'Sibling', 'Grandparent', 'Grandchild'].contains(member.relationship) ? member.relationship : ''}">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="<fmt:formatDate value="${member.dateOfBirth}" pattern="yyyy-MM-dd" />">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="">Select gender</option>
                                    <option value="Male" ${member.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${member.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${member.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="cccd" class="form-label">Citizen ID (CCCD)</label>
                            <input type="text" class="form-control" id="cccd" name="cccd" value="${member.cccd}">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" value="${member.email}">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${member.phoneNumber}">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/household/view?householdId=${member.householdId}" class="btn btn-secondary">
                                Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Update Member
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
                                // Function to check if "Other" relationship is selected
                                function checkOtherRelationship() {
                                    var relationshipSelect = document.getElementById('relationship');
                                    var otherRelationshipDiv = document.getElementById('otherRelationshipDiv');

                                    if (relationshipSelect.value === 'Other') {
                                        otherRelationshipDiv.style.display = 'block';
                                    } else {
                                        otherRelationshipDiv.style.display = 'none';
                                    }
                                }

                                // Call the function on page load
                                document.addEventListener('DOMContentLoaded', function () {
                                    checkOtherRelationship();
                                });
        </script>
    </body>
</html>