<%--
    Document   : transferHousehold
    Created on : Mar 17, 2025, 3:29:13 AM
    Author     : quang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.AddressDAO" %>
<%@ page import="model.Province" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Transfer Household Registration</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Custom CSS -->
        <style>
            .form-container {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .required-field::after {
                content: "*";
                color: red;
                margin-left: 4px;
            }
            .section-title {
                border-bottom: 2px solid #0d6efd;
                padding-bottom: 5px;
                margin-bottom: 20px;
            }
            .address-row {
                margin-bottom: 20px;
            }
            .address-select {
                margin-bottom: 15px;
            }
            .form-floating {
                margin-top: 10px;
            }
            .document-preview-item {
                transition: all 0.3s ease;
                border-left: 4px solid #0d6efd;
            }
            .document-preview-item:hover {
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .document-preview {
                max-height: 300px;
                overflow-y: auto;
                padding: 10px;
                border-radius: 5px;
                background-color: #f8f9fa;
            }
            .loading-indicator {
                display: inline-block;
                width: 1rem;
                height: 1rem;
                margin-left: 0.5rem;
                vertical-align: middle;
                border: 0.2em solid currentColor;
                border-right-color: transparent;
                border-radius: 50%;
                animation: spinner-border .75s linear infinite;
            }
            .loading-text {
                display: inline-block;
                margin-left: 0.5rem;
                font-size: 0.875rem;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4 mb-5">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center mb-4">Transfer Household Registration</h2>

                    <!-- Alert for errors or success messages -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/registration/add" method="POST" id="transferForm" class="needs-validation" novalidate enctype="multipart/form-data">
                            <!-- Hidden field for registration type -->
                            <input type="hidden" name="registrationTypeId" value="${selectedRegistrationType.registrationTypeId}">

                            <!-- Current Household Information Section -->
                            <div class="mb-4">
                                <h4 class="section-title">Current Household Information</h4>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="currentHouseholdId" class="form-label required-field">Current Household</label>
                                        <select class="form-select" id="currentHouseholdId" name="currentHouseholdId" required>
                                            <option value="">Select your current household</option>
                                            <c:if test="${not empty loggedInUser.householdId}">
                                                <option value="${loggedInUser.householdId}" selected>Your Current Household</option>
                                            </c:if>
                                            <c:forEach items="${userHouseholds}" var="household">
                                                <option value="${household.householdId}">${household.address} (ID: ${household.householdId})</option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select your current household.
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="previousAddress" class="form-label required-field">Current Address</label>
                                        <input type="text" class="form-control" id="previousAddress" name="previousAddress"
                                               value="${loggedInUser.address}" required readonly>
                                        <div class="invalid-feedback">
                                            Current address is required.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- New Address Information Section -->
                            <div class="mb-4">
                                <h4 class="section-title">New Address Information</h4>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label for="city" class="form-label required-field">Province/City</label>
                                        <select class="form-select" id="city" name="provinceCode" required>
                                            <option value="">Select Province/City</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select a province/city.
                                        </div>
                                    </div>

                                    <div class="col-md-4 mb-3">
                                        <label for="district" class="form-label required-field">District</label>
                                        <select class="form-select" id="district" name="districtCode" required>
                                            <option value="">Select District</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select a district.
                                        </div>
                                    </div>

                                    <div class="col-md-4 mb-3">
                                        <label for="ward" class="form-label">Ward</label>
                                        <select class="form-select" id="ward" name="wardCode">
                                            <option value="">Select Ward</option>
                                        </select>
                                        <div class="form-text">Optional if the district doesn't have wards</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-floating mb-3">
                                            <input
                                                type="text"
                                                name="houseNumber"
                                                class="form-control"
                                                id="floatingHouseNumber"
                                                placeholder="House Number and Street"
                                                required
                                                />
                                            <label for="floatingHouseNumber">
                                                <i class="bi bi-house me-2"></i>House Number and Street
                                            </label>
                                            <div class="invalid-feedback">
                                                Please enter house number and street.
                                            </div>
                                        </div>

                                        <!-- Hidden field to store the complete address -->
                                        <input type="hidden" name="newAddress" id="completeAddress" required />
                                        
                                        <!-- Hidden fields to store location names -->
                                        <input type="hidden" name="provinceName" id="provinceName" required />
                                        <input type="hidden" name="districtName" id="districtName" required />
                                        <input type="hidden" name="wardName" id="wardName" />
                                    </div>
                                </div>
                            </div>

                            <!-- Transfer Details Section -->
                            <div class="mb-4">
                                <h4 class="section-title">Transfer Details</h4>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="moveDate" class="form-label required-field">Move Date</label>
                                        <input type="date" class="form-control" id="moveDate" name="moveDate" required>
                                        <div class="invalid-feedback">
                                            Move date is required.
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="reasonForTransfer" class="form-label required-field">Reason for Transfer</label>
                                        <textarea class="form-control" id="reasonForTransfer" name="reasonForTransfer" rows="3" required></textarea>
                                        <div class="invalid-feedback">
                                            Please provide a reason for transfer.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Supporting Documents Section -->
                            <div class="mb-4">
                                <h4 class="section-title">Supporting Documents</h4>
                                <p class="text-muted mb-3">Please upload documents to support your transfer request (PDF, JPG, PNG files only, max 5MB each).</p>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="identityDocument" class="form-label required-field">Identity Document</label>
                                        <input type="file" class="form-control" id="identityDocument" name="identityDocument"
                                               accept=".pdf,.jpg,.jpeg,.png" required>
                                        <div class="form-text">Upload a copy of your ID card or passport</div>
                                        <div class="invalid-feedback">
                                            Please upload an identity document.
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="proofOfResidence" class="form-label required-field">Proof of Current Residence</label>
                                        <input type="file" class="form-control" id="proofOfResidence" name="proofOfResidence"
                                               accept=".pdf,.jpg,.jpeg,.png" required>
                                        <div class="form-text">Upload a utility bill or rental agreement</div>
                                        <div class="invalid-feedback">
                                            Please upload proof of your current residence.
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="transferDocument" class="form-label required-field">Transfer Document</label>
                                        <input type="file" class="form-control" id="transferDocument" name="transferDocument"
                                               accept=".pdf,.jpg,.jpeg,.png" required>
                                        <div class="form-text">Upload a document supporting your reason for transfer</div>
                                        <div class="invalid-feedback">
                                            Please upload a document supporting your transfer reason.
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="additionalDocument" class="form-label">Additional Document (Optional)</label>
                                        <input type="file" class="form-control" id="additionalDocument" name="additionalDocument"
                                               accept=".pdf,.jpg,.jpeg,.png">
                                        <div class="form-text">Upload any additional supporting document if needed</div>
                                    </div>
                                </div>

                                <div class="document-preview mt-3" id="documentPreviewArea">
                                    <!-- Document previews will be displayed here -->
                                </div>
                            </div>

                            <!-- Declaration Section -->
                            <div class="mb-4">
                                <h4 class="section-title">Declaration</h4>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="declaration" name="declaration" required>
                                    <label class="form-check-label" for="declaration">
                                        I hereby declare that the information provided is true and correct to the best of my knowledge.
                                    </label>
                                    <div class="invalid-feedback">
                                        You must agree before submitting.
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Buttons -->
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button type="button" class="btn btn-secondary me-md-2" onclick="window.history.back();">Cancel</button>
                                <button type="submit" class="btn btn-primary" id="submitBtn">Submit Registration</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

        <!-- Custom JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
        // Address selection variables
                                            const citis = document.getElementById("city");
                                            const districts = document.getElementById("district");
                                            const wards = document.getElementById("ward");

        // Fetch and render data when DOM is loaded
                                            document.addEventListener('DOMContentLoaded', function () {
                                                const today = new Date().toISOString().split('T')[0];
                                                document.getElementById('moveDate').setAttribute('min', today);

                                                // Fetch address data
                                                const parameter = {
                                                    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                                    method: "GET",
                                                    responseType: "application/json",
                                                };

                                                axios(parameter)
                                                        .then(function (result) {
                                                            console.log("Address data loaded successfully");
                                                            renderCities(result.data);
                                                        })
                                                        .catch(function (error) {
                                                            console.error("Error loading address data:", error);
                                                            alert("Failed to load address data. Please refresh the page and try again.");
                                                        });
                                            });

        // Render cities/provinces
                                            function renderCities(data) {
                                                citis.innerHTML = '<option value="">Select Province/City</option>';
                                                for (const x of data) {
                                                    citis.options[citis.options.length] = new Option(x.Name, x.Id);
                                                }

                                                // City change event
                                                citis.onchange = function () {
                                                    districts.innerHTML = '<option value="">Select District</option>';
                                                    wards.innerHTML = '<option value="">Select Ward</option>';
                                                    if (this.value) {
                                                        const result = data.filter(n => n.Id === this.value);
                                                        for (const k of result[0].Districts) {
                                                            districts.options[districts.options.length] = new Option(k.Name, k.Id);
                                                        }
                                                        
                                                        // Store the province name
                                                        const provinceName = this.options[this.selectedIndex].text;
                                                        document.getElementById("provinceName").value = provinceName;
                                                        console.log("Province name stored:", provinceName);
                                                    } else {
                                                        document.getElementById("provinceName").value = "";
                                                    }
                                                    
                                                    // Clear district and ward names
                                                    document.getElementById("districtName").value = "";
                                                    document.getElementById("wardName").value = "";
                                                    
                                                    updateCompleteAddress();
                                                };

                                                // District change event
                                                districts.onchange = function () {
                                                    wards.innerHTML = '<option value="">Select Ward</option>';
                                                    if (this.value) {
                                                        try {
                                                            const dataCity = data.filter(n => n.Id === citis.value);
                                                            if (!dataCity || dataCity.length === 0) {
                                                                console.error("City data not found");
                                                                return;
                                                            }
                                                            
                                                            const district = dataCity[0].Districts.filter(n => n.Id === this.value);
                                                            if (!district || district.length === 0) {
                                                                console.error("District data not found");
                                                                return;
                                                            }
                                                            
                                                            const dataWards = district[0].Wards || [];
                                                            
                                                            // Log detailed ward information for debugging
                                                            console.log("District selected:", this.options[this.selectedIndex].text);
                                                            console.log("Wards data:", dataWards);
                                                            console.log("Wards length:", dataWards.length);
                                                            
                                                            // Store the district name
                                                            const districtName = this.options[this.selectedIndex].text;
                                                            document.getElementById("districtName").value = districtName;
                                                            
                                                            // Check if the district has any wards
                                                            if (dataWards.length > 0) {
                                                                // Log individual wards for debugging
                                                                dataWards.forEach((ward, index) => {
                                                                    console.log(`Ward ${index + 1}:`, ward.Name, ward.Id);
                                                                });
                                                                
                                                                // Populate wards
                                                                for (const w of dataWards) {
                                                                    wards.options[wards.options.length] = new Option(w.Name, w.Id);
                                                                }
                                                                
                                                                // Handle ward selection requirement based on count
                                                                if (dataWards.length > 1) {
                                                                    // If there are multiple wards, make it required
                                                                    document.querySelector('label[for="ward"]').textContent = "Ward";
                                                                    document.querySelector('label[for="ward"]').classList.add("required-field");
                                                                    wards.setAttribute("required", "required");
                                                                    document.querySelector('div.col-md-4.mb-3 .form-text').textContent = "Please select a ward";
                                                                    wards.disabled = false;
                                                                    
                                                                    // Add invalid feedback if it doesn't exist
                                                                    let invalidFeedback = wards.nextElementSibling.nextElementSibling;
                                                                    if (!invalidFeedback || !invalidFeedback.classList.contains('invalid-feedback')) {
                                                                        invalidFeedback = document.createElement('div');
                                                                        invalidFeedback.classList.add('invalid-feedback');
                                                                        invalidFeedback.textContent = 'Please select a ward.';
                                                                        wards.parentNode.appendChild(invalidFeedback);
                                                                    }
                                                                    
                                                                    console.log("Multiple wards available - Ward selection required");
                                                                } else {
                                                                    // If there's only one ward, keep it optional
                                                                    document.querySelector('label[for="ward"]').textContent = "Ward";
                                                                    document.querySelector('label[for="ward"]').classList.remove("required-field");
                                                                    wards.removeAttribute("required");
                                                                    wards.disabled = true;
                                                                    document.querySelector('div.col-md-4.mb-3 .form-text').textContent = "No ward available";
                                                                    
                                                                    
                                                                    // Auto-select the only ward if there's exactly one
                                                                    if (dataWards.length === 1) {
                                                                        wards.selectedIndex = 1; // Select the first ward (index 1 because of the placeholder)
                                                                        // Trigger the onchange event
                                                                        const event = new Event('change');
                                                                        wards.dispatchEvent(event);
                                                                    }
                                                                    
                                                                    console.log("Only one ward available - Ward selection optional");
                                                                }
                                                            } else {
                                                                // Update UI to show there are no wards available
                                                                document.querySelector('label[for="ward"]').textContent = "Ward (Not Available)";
                                                                document.querySelector('label[for="ward"]').classList.remove("required-field");
                                                                wards.removeAttribute("required");
                                                                document.querySelector('div.col-md-4.mb-3 .form-text').textContent = "This district doesn't have any wards";
                                                                wards.disabled = true;
                                                                
                                                                console.log("District has 0 wards - Ward dropdown disabled");
                                                            }
                                                            
                                                            console.log("District name stored:", districtName);
                                                        } catch (error) {
                                                            console.error("Error processing district data:", error);
                                                            console.error("Error details:", error.message);
                                                            console.error("Error stack:", error.stack);
                                                            
                                                            // Update UI to show there's an error
                                                            document.querySelector('label[for="ward"]').textContent = "Ward (Error)";
                                                            document.querySelector('label[for="ward"]').classList.remove("required-field");
                                                            wards.removeAttribute("required");
                                                            document.querySelector('div.col-md-4.mb-3 .form-text').textContent = "Could not load wards for this district";
                                                            wards.disabled = true;
                                                        }
                                                    } else {
                                                        document.getElementById("districtName").value = "";
                                                        
                                                        // Reset ward UI
                                                        document.querySelector('label[for="ward"]').textContent = "Ward";
                                                        document.querySelector('label[for="ward"]').classList.remove("required-field");
                                                        wards.removeAttribute("required");
                                                        document.querySelector('div.col-md-4.mb-3 .form-text').textContent = "Optional if the district doesn't have wards";
                                                        wards.disabled = false;
                                                        
                                                        console.log("District selection cleared - Ward dropdown reset");
                                                    }
                                                    
                                                    // Clear ward name
                                                    document.getElementById("wardName").value = "";
                                                    
                                                    updateCompleteAddress();
                                                };

                                                // Ward change event
                                                wards.onchange = function () {
                                                    if (this.value) {
                                                        // Store the ward name
                                                        const wardName = this.options[this.selectedIndex].text;
                                                        document.getElementById("wardName").value = wardName;
                                                        console.log("Ward name stored:", wardName);
                                                    } else {
                                                        document.getElementById("wardName").value = "";
                                                    }
                                                    
                                                    updateCompleteAddress();
                                                };

                                                // House number change event
                                                document.getElementById("floatingHouseNumber").addEventListener("input", updateCompleteAddress);
                                            }

        // Update complete address (keep your existing function)
                                            function updateCompleteAddress() {
                                                const houseNumber = document.getElementById("floatingHouseNumber").value.trim();
                                                const cityText = citis.options[citis.selectedIndex]?.text || "";
                                                const districtText = districts.options[districts.selectedIndex]?.text || "";
                                                const wardText = wards.options[wards.selectedIndex]?.text || "";

                                                if (houseNumber &&
                                                        cityText && cityText !== "Select Province/City" &&
                                                        districtText && districtText !== "Select District") {
                                                    
                                                    let addressParts = [houseNumber];
                                                    
                                                    // Only add ward if it's selected
                                                    if (wardText && wardText !== "Select Ward") {
                                                        addressParts.push(wardText);
                                                    }
                                                    
                                                    // Always add district and city
                                                    addressParts.push(districtText);
                                                    addressParts.push(cityText);
                                                    
                                                    const completeAddress = addressParts.join(', ');
                                                    document.getElementById("completeAddress").value = completeAddress;
                                                    console.log("Complete address updated:", completeAddress);
                                                } else {
                                                    document.getElementById("completeAddress").value = "";
                                                }
                                            }
        </script>
        
        <!-- Document validation script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const maxSizeInBytes = 5 * 1024 * 1024; // 5MB
                const allowedFileTypes = ['.pdf', '.jpg', '.jpeg', '.png'];
                
                // Function to validate file
                const validateFile = (fileInput, fileName) => {
                    if (fileInput.files.length > 0) {
                        const file = fileInput.files[0];
                        
                        // Check file size
                        if (file.size > maxSizeInBytes) {
                            alert(`${fileName} exceeds the maximum file size of 5MB. Please upload a smaller file.`);
                            fileInput.value = ''; // Clear the file input
                            return false;
                        }
                        
                        // Check file type
                        const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
                        if (!allowedFileTypes.includes(fileExtension)) {
                            alert(`${fileName} has an invalid file type. Allowed types are: PDF, JPG, JPEG, PNG.`);
                            fileInput.value = ''; // Clear the file input
                            return false;
                        }
                        
                        console.log(`${fileName} validated successfully:`, {
                            name: file.name,
                            size: (file.size / 1024 / 1024).toFixed(2) + 'MB',
                            type: file.type
                        });
                    }
                    return true;
                };
                
                // Add event listeners to file inputs
                document.getElementById('identityDocument').addEventListener('change', function() {
                    validateFile(this, 'Identity Document');
                });
                
                document.getElementById('proofOfResidence').addEventListener('change', function() {
                    validateFile(this, 'Proof of Residence');
                });
                
                document.getElementById('transferDocument').addEventListener('change', function() {
                    validateFile(this, 'Transfer Document');
                });
                
                document.getElementById('additionalDocument').addEventListener('change', function() {
                    validateFile(this, 'Additional Document');
                });
            });
        </script>
        
        <!-- Form submission validation script -->
        <script>
            // Form submission handler
            document.getElementById('transferForm').addEventListener('submit', function(event) {
                // Check all required fields
                const form = this;
                const requiredFields = form.querySelectorAll('[required]');
                let isValid = true;
                
                // Check each required field
                requiredFields.forEach(function(field) {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.classList.add('is-invalid');
                        
                        // If it's a select element, add a red border
                        if (field.tagName === 'SELECT') {
                            field.style.borderColor = '#dc3545';
                        }
                    } else {
                        field.classList.remove('is-invalid');
                        
                        // If it's a select element, remove the red border
                        if (field.tagName === 'SELECT') {
                            field.style.borderColor = '';
                        }
                    }
                });
                
                // Check ward selection if it's required (has the required attribute)
                const wardSelect = document.getElementById('ward');
                if (wardSelect.hasAttribute('required') && (!wardSelect.value || wardSelect.value === "")) {
                    isValid = false;
                    wardSelect.classList.add('is-invalid');
                    wardSelect.style.borderColor = '#dc3545';
                    console.log("Ward selection is required but not selected");
                } else {
                    wardSelect.classList.remove('is-invalid');
                    wardSelect.style.borderColor = '';
                    console.log("Ward validation passed:", wardSelect.hasAttribute('required') ? "required" : "not required");
                }
                
                // Check if hidden fields are filled
                const completeAddress = document.getElementById('completeAddress').value;
                const provinceName = document.getElementById('provinceName').value;
                const districtName = document.getElementById('districtName').value;
                
                // Check if required document files are selected
                const identityDocumentInput = document.getElementById('identityDocument');
                const proofOfResidenceInput = document.getElementById('proofOfResidence');
                const transferDocumentInput = document.getElementById('transferDocument');
                
                console.log("Form submission - Address values:", {
                    completeAddress: completeAddress,
                    provinceName: provinceName,
                    districtName: districtName,
                    wardName: document.getElementById('wardName').value, 
                    wardRequired: wardSelect.hasAttribute('required')
                });
                
                console.log("Form submission - Document files:", {
                    identityDocument: identityDocumentInput.files.length,
                    proofOfResidence: proofOfResidenceInput.files.length,
                    transferDocument: transferDocumentInput.files.length
                });
                
                console.log("Declaration checked:", document.getElementById('declaration').checked);
                
                // Validate that all required address fields are filled
                if (!completeAddress || !provinceName || !districtName) {
                    event.preventDefault();
                    alert("Please complete all required address information before submitting.");
                    return false;
                }
                
                // Validate that all required document files are selected
                if (!identityDocumentInput.files.length || !proofOfResidenceInput.files.length || !transferDocumentInput.files.length) {
                    event.preventDefault();
                    alert("Please upload all required documents before submitting.");
                    return false;
                }
                
                // Validate that declaration is checked
                const declarationCheckbox = document.getElementById('declaration');
                if (!declarationCheckbox.checked) {
                    event.preventDefault();
                    alert("Please confirm the declaration before submitting.");
                    declarationCheckbox.focus();
                    
                    // Highlight the declaration section
                    const declarationSection = document.querySelector('.form-check');
                    declarationSection.classList.add('border', 'border-danger', 'p-3', 'rounded');
                    
                    return false;
                }
                
                // If any required field is invalid, prevent submission
                if (!isValid) {
                    event.preventDefault();
                    alert("Please fill in all required fields before submitting.");
                    return false;
                }
                
                // Show loading indicator on submit button
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Submitting...';
                submitBtn.disabled = true;
                
                return true;
            });
        </script>
        
        <!-- Declaration checkbox styling script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const declarationCheckbox = document.getElementById('declaration');
                const declarationSection = document.querySelector('.form-check');
                const declarationLabel = document.querySelector('.form-check-label');
                
                // Function to update declaration section styling
                function updateDeclarationStyling() {
                    if (declarationCheckbox.checked) {
                        declarationSection.classList.remove('border', 'border-danger', 'p-3', 'rounded', 'bg-danger-subtle');
                        declarationLabel.classList.remove('fw-bold');
                    } else {
                        declarationSection.classList.add('border', 'border-danger', 'p-3', 'rounded', 'bg-danger-subtle');
                        declarationLabel.classList.add('fw-bold');
                    }
                }
                
                // Initial styling
                updateDeclarationStyling();
                
                // Update styling when checkbox state changes
                declarationCheckbox.addEventListener('change', updateDeclarationStyling);
            });
        </script>
    </body>
</html>
