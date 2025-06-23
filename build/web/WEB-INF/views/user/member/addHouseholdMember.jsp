<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Household Member | Household Management</title>
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
                padding: 30px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            h1 {
                color: #3498db;
                margin-bottom: 30px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: 600;
                color: #2c3e50;
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
            <h1>Register Household Member</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
            </c:if>

            <c:if test="${empty household}">
                <div class="alert alert-danger" role="alert">
                    <p>You don't have a household assigned to your account. Please contact an administrator or create a household first.</p>
                    <p><a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Return to Dashboard</a></p>
                </div>
            </c:if>

            <c:if test="${not empty household}">
                <form action="${pageContext.request.contextPath}/household/registerMember" method="post">
                    <input type="hidden" name="householdId" value="${household.householdId}" id="householdIdField">

                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email (Optional)</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>

                    <div class="form-group">
                        <label for="cccd">Citizen ID (CCCD) (Optional)</label>
                        <input type="text" class="form-control" id="cccd" name="cccd">
                    </div>

                    <div class="form-group">
                        <label for="relationship">Relationship to Head of Household</label>
                        <select class="form-control" id="relationship" name="relationship" required>
                            <option value="">-- Select Relationship --</option>
                            <option value="Spouse">Spouse</option>
                            <option value="Child">Child</option>
                            <option value="Parent">Parent</option>
                            <option value="Sibling">Sibling</option>
                            <option value="Grandparent">Grandparent</option>
                            <option value="Grandchild">Grandchild</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group" id="otherRelationshipGroup" style="display: none;">
                        <label for="otherRelationship">Specify Relationship</label>
                        <input type="text" class="form-control" id="otherRelationship" name="otherRelationship">
                    </div>

                    <div class="form-group">
                        <label for="dateOfBirth">Date of Birth</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth">
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="male" value="Male" checked>
                            <label class="form-check-label" for="male">Male</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="female" value="Female">
                            <label class="form-check-label" for="female">Female</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="other" value="Other">
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber">
                    </div>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/household/view?householdId=${household.householdId}" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Back to Household
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-person-plus"></i> Register Member
                        </button>
                    </div>
                </form>
            </c:if>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Show/hide the "Other Relationship" field based on selection
                $('#relationship').change(function () {
                    if ($(this).val() === 'Other') {
                        $('#otherRelationshipGroup').show();
                        $('#otherRelationship').attr('required', true);
                    } else {
                        $('#otherRelationshipGroup').hide();
                        $('#otherRelationship').attr('required', false);
                    }
                });

                // Form validation before submission
                $('form').submit(function (e) {
                    // Check if householdId is present
                    var householdId = $('#householdIdField').val();
                    if (!householdId) {
                        // Try to get it from the household object
                        var householdIdFromAttribute = '${household.householdId}';
                        if (householdIdFromAttribute) {
                            // Set the value in the form
                            $('#householdIdField').val(householdIdFromAttribute);
                        } else {
                            alert('Household ID is missing. Please go back to the household details page and try again.');
                            e.preventDefault();
                            return false;
                        }
                    }

                    // Check if fullName is filled
                    var fullName = $('#fullName').val();
                    if (!fullName) {
                        alert('Please enter the full name.');
                        $('#fullName').focus();
                        e.preventDefault();
                        return false;
                    }

                    // Check if relationship is selected
                    var relationship = $('#relationship').val();
                    if (!relationship) {
                        alert('Please select a relationship.');
                        $('#relationship').focus();
                        e.preventDefault();
                        return false;
                    }

                    // If relationship is "Other", check if otherRelationship is filled
                    if (relationship === 'Other') {
                        var otherRelationship = $('#otherRelationship').val();
                        if (!otherRelationship) {
                            alert('Please specify the relationship.');
                            $('#otherRelationship').focus();
                            e.preventDefault();
                            return false;
                        }
                    }

                    return true;
                });
            });
        </script>
    </body>
</html>