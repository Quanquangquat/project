<%--
    Document   : chooseRegistrations
    Created on : Mar 17, 2025, 3:10:54 AM
    Author     : quang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Choose Registration Type | Household Management</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .container {
                max-width: 900px;
                margin: 40px auto;
                padding: 0;
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                margin-bottom: 30px;
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

            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
                padding: 10px 20px;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            .registration-type-card {
                border: 1px solid #e9ecef;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                transition: all 0.3s;
                cursor: pointer;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .registration-type-card:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transform: translateY(-3px);
                border-color: #3498db;
            }

            .registration-type-card.selected {
                border-color: #3498db;
                background-color: rgba(52, 152, 219, 0.1);
            }

            .registration-type-name {
                font-weight: 600;
                font-size: 1.2rem;
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .registration-type-description {
                color: #7f8c8d;
                flex-grow: 1;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">Choose Registration Type</h2>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light">
                        <i class="bi bi-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <p class="lead mb-4">
                        Please select the type of registration you would like to submit:
                    </p>

                    <form id="registrationTypeForm" action="${pageContext.request.contextPath}/registration/choose" method="post">
                        <input type="hidden" id="registrationTypeId" name="registrationTypeId" value="">

                        <div class="row row-cols-1 row-cols-md-2 g-4">
                            <c:choose>
                                <c:when test="${empty registrationTypes}">
                                    <div class="col-12">
                                        <div class="alert alert-info">
                                            No registration types are available at this time. Please try again later.
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="type" items="${registrationTypes}">
                                        <div class="col">
                                            <div class="registration-type-card" onclick="selectRegistrationType(${type.registrationTypeId}, this)">
                                                <div class="registration-type-name">
                                                    ${type.typeName}
                                                </div>
                                                <div class="registration-type-description">
                                                    ${type.description}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="submit" class="btn btn-primary" id="continueBtn" disabled>
                                <i class="bi bi-arrow-right"></i> Continue
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script>
                                                function selectRegistrationType(typeId, element) {
                                                    // Remove selected class from all cards
                                                    document.querySelectorAll('.registration-type-card').forEach(card => {
                                                        card.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked card
                                                    element.classList.add('selected');

                                                    // Set the selected type ID in the hidden input
                                                    document.getElementById('registrationTypeId').value = typeId;

                                                    // Enable the continue button
                                                    document.getElementById('continueBtn').disabled = false;
                                                }
        </script>
    </body>
</html>