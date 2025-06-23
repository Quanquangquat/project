<%--
    Document   : test
    Created on : Mar 17, 2025, 4:52:59 AM
    Author     : quang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Transfer Form Data Test</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .data-card {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .section-title {
                border-bottom: 2px solid #0d6efd;
                padding-bottom: 5px;
                margin-bottom: 15px;
            }
            .data-row {
                margin-bottom: 10px;
            }
            .data-label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4 mb-5">
            <h1 class="text-center mb-4">Transfer Household Registration Data</h1>
            
            <!-- Registration Type Information -->
            <div class="data-card">
                <h3 class="section-title">Registration Information</h3>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Registration Type ID:</div>
                    <div class="col-md-8">${registrationTypeId}</div>
                </div>
            </div>
            
            <!-- Current Household Information -->
            <div class="data-card">
                <h3 class="section-title">Current Household Information</h3>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Current Household ID:</div>
                    <div class="col-md-8">${currentHouseholdId}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Current Address:</div>
                    <div class="col-md-8">${previousAddress}</div>
                </div>
            </div>
            
            <!-- New Address Information -->
            <div class="data-card">
                <h3 class="section-title">New Address Information</h3>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Province/City Code:</div>
                    <div class="col-md-8">${provinceCode}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Province/City Name:</div>
                    <div class="col-md-8">${provinceName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">District Code:</div>
                    <div class="col-md-8">${districtCode}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">District Name:</div>
                    <div class="col-md-8">${districtName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Ward Code:</div>
                    <div class="col-md-8">${wardCode}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Ward Name:</div>
                    <div class="col-md-8">${wardName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">House Number:</div>
                    <div class="col-md-8">${houseNumber}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Complete New Address:</div>
                    <div class="col-md-8">${newAddress}</div>
                </div>
            </div>
            
            <!-- Transfer Details -->
            <div class="data-card">
                <h3 class="section-title">Transfer Details</h3>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Move Date:</div>
                    <div class="col-md-8">${moveDate}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Reason for Transfer:</div>
                    <div class="col-md-8">${reasonForTransfer}</div>
                </div>
            </div>
            
            <!-- Document Information -->
            <div class="data-card">
                <h3 class="section-title">Document Information</h3>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Identity Document:</div>
                    <div class="col-md-8">${identityDocumentName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Proof of Residence:</div>
                    <div class="col-md-8">${proofOfResidenceName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Transfer Document:</div>
                    <div class="col-md-8">${transferDocumentName}</div>
                </div>
                <div class="row data-row">
                    <div class="col-md-4 data-label">Additional Document:</div>
                    <div class="col-md-8">${additionalDocumentName}</div>
                </div>
            </div>
            
            <!-- All Parameters (Debug Information) -->
            <div class="data-card">
                <h3 class="section-title">All Parameters (Debug Information)</h3>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Parameter Name</th>
                            <th>Parameter Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allParams}" var="param">
                            <tr>
                                <td>${param.key}</td>
                                <td>${param.value}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Back Button -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/registration/choose" class="btn btn-primary">Back to Registration Selection</a>
            </div>
        </div>
        
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
