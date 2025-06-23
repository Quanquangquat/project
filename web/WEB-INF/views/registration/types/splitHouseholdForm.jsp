<%--
    Document   : splitHousehold
    Created on : Mar 17, 2025, 3:29:29 AM
    Author     : quang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Split Household Registration</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }
            
            .form-section {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
                margin-bottom: 30px;
            }
            
            .form-section-title {
                color: #2c3e50;
                border-bottom: 1px solid #eee;
                padding-bottom: 10px;
                margin-bottom: 20px;
                font-weight: 600;
            }
            
            .section-title {
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 15px;
                color: #3498db;
            }
            
            .required-field::after {
                content: "*";
                color: red;
                margin-left: 4px;
            }
            
            .submit-btn {
                background-color: #3498db;
                border: none;
                padding: 10px 25px;
                border-radius: 5px;
                font-weight: 600;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            
            .submit-btn:hover {
                background-color: #2980b9;
            }
            
            .member-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                transition: all 0.3s;
            }
            
            .member-card:hover {
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .member-card.selected {
                border-color: #3498db;
                background-color: rgba(52, 152, 219, 0.05);
            }
            
            .member-checkbox {
                margin-right: 10px;
            }
            
            .head-radio {
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <i class="bi bi-building-fill me-2"></i>
                    Residence Registration System
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                                <i class="bi bi-speedometer2 me-1"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/registration/showAll">
                                <i class="bi bi-file-earmark-text me-1"></i> My Registrations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/registration/choose">
                                <i class="bi bi-plus-circle me-1"></i> New Registration
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <!-- Form Header -->
                    <h2 class="text-center mb-4">Split Household Registration</h2>
                    <p class="text-center text-muted mb-5">
                        Use this form to request a split from your current household.
                        Selected members will be moved to a new household.
                    </p>
                    
                    <!-- Error/Success Messages -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <!-- Registration Form -->
                    <form action="${pageContext.request.contextPath}/registration/add" method="post" id="splitHouseholdForm" enctype="multipart/form-data">
                        <input type="hidden" name="registrationType" value="split">
                        
                        <!-- Current Household Information Section -->
                        <div class="form-section">
                            <h4 class="form-section-title">Current Household Information</h4>
                            
                            <div class="mb-3">
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
                                <div class="form-text">
                                    Please select your current household.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="previousAddress" class="form-label">Current Address</label>
                                <input type="text" class="form-control" id="previousAddress" name="previousAddress" 
                                       value="${currentAddress}" readonly>
                                <div class="form-text">
                                    This is your current household address.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="reasonForSplit" class="form-label required-field">Reason for Split</label>
                                <textarea class="form-control" id="reasonForSplit" name="reasonForSplit" rows="3" required></textarea>
                                <div class="form-text">
                                    Please provide a detailed reason for splitting the household.
                                </div>
                            </div>
                        </div>
                        
                        <!-- New Address Information Section -->
                        <div class="form-section">
                            <h4 class="form-section-title">New Address Information</h4>
                            
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="city" class="form-label required-field">Province/City</label>
                                    <select class="form-select" id="city" required>
                                        <option value="">Select Province/City</option>
                                    </select>
                                    <input type="hidden" name="provinceCode" id="provinceCode">
                                    <input type="hidden" name="provinceName" id="provinceName">
                                </div>
                                <div class="col-md-4">
                                    <label for="district" class="form-label required-field">District</label>
                                    <select class="form-select" id="district" required>
                                        <option value="">Select District</option>
                                    </select>
                                    <input type="hidden" name="districtCode" id="districtCode">
                                    <input type="hidden" name="districtName" id="districtName">
                                </div>
                                <div class="col-md-4">
                                    <label for="ward" class="form-label required-field">Ward/Commune</label>
                                    <select class="form-select" id="ward" required>
                                        <option value="">Select Ward</option>
                                    </select>
                                    <input type="hidden" name="wardCode" id="wardCode">
                                    <input type="hidden" name="wardName" id="wardName">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="streetAddress" class="form-label required-field">Street Address</label>
                                <input type="text" class="form-control" id="streetAddress" name="streetAddress" required>
                                <div class="form-text">
                                    Enter the new street address, house/apartment number.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="fullAddress" class="form-label">Complete Address</label>
                                <input type="text" class="form-control" id="fullAddress" name="newAddress" readonly>
                                <div class="form-text">
                                    This is the complete address that will be registered.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="moveDate" class="form-label required-field">Planned Move Date</label>
                                <input type="date" class="form-control" id="moveDate" name="moveDate" required>
                                <div class="form-text">
                                    The date when you plan to move to the new address.
                                </div>
                            </div>
                        </div>
                        
                        <!-- Household Members Section -->
                        <div class="form-section">
                            <h4 class="form-section-title">Household Members</h4>
                            <p class="text-muted mb-3">
                                Select the members who will move to the new household, and designate a head for the new household.
                            </p>
                            
                            <div class="mb-3" id="membersContainer">
                                <c:choose>
                                    <c:when test="${not empty householdMembers}">
                                        <h5 class="section-title mb-3">Members of Current Household</h5>
                                        
                                        <c:forEach var="member" items="${householdMembers}">
                                            <div class="member-card">
                                                <div class="row align-items-center">
                                                    <div class="col-md-1">
                                                        <div class="form-check">
                                                            <input class="form-check-input member-checkbox" type="checkbox" 
                                                                   name="selectedMembers" value="${member.memberId}" 
                                                                   id="member-${member.memberId}">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <h6 class="mb-1">${member.fullName}</h6>
                                                        <p class="text-muted mb-0 small">
                                                            ${member.relationship} | 
                                                            <c:if test="${not empty member.dateOfBirth}">
                                                                <fmt:formatDate value="${member.dateOfBirth}" pattern="dd/MM/yyyy" /> | 
                                                            </c:if>
                                                            ${member.gender}
                                                        </p>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <div class="form-check">
                                                            <input class="form-check-input head-radio" type="radio" 
                                                                   name="headOfHousehold" value="${member.memberId}" 
                                                                   id="head-${member.memberId}" disabled>
                                                            <label class="form-check-label" for="head-${member.memberId}">
                                                                Head
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        
                                        <div class="alert alert-info mt-3" id="memberSelectionInfo">
                                            <i class="bi bi-info-circle me-2"></i>
                                            Select at least one member to move to the new household.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-warning">
                                            <i class="bi bi-exclamation-triangle me-2"></i>
                                            No members found in your current household.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <!-- Document Upload Section -->
                        <div class="form-section">
                            <h4 class="form-section-title">Required Documents</h4>
                            
                            <div class="mb-3">
                                <label for="identityDocument" class="form-label required-field">Identity Document</label>
                                <input type="file" class="form-control" id="identityDocument" name="identityDocument" required>
                                <div class="form-text">
                                    Upload a scanned copy of your ID card, passport, or other identity document.
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="proofOfResidence" class="form-label required-field">Proof of Residence</label>
                                <input type="file" class="form-control" id="proofOfResidence" name="proofOfResidence" required>
                                <div class="form-text">
                                    Upload a document that proves your current residence (utility bill, lease agreement, etc.).
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="splitDocument" class="form-label required-field">Split Household Document</label>
                                <input type="file" class="form-control" id="splitDocument" name="splitDocument" required>
                                <div class="form-text">
                                    Upload any document related to the household split (agreement, court order, etc.).
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="additionalDocument" class="form-label">Additional Document (Optional)</label>
                                <input type="file" class="form-control" id="additionalDocument" name="additionalDocument">
                                <div class="form-text">
                                    You can upload any additional document that supports your registration.
                                </div>
                            </div>
                        </div>
                        
                        <!-- Consent Section -->
                        <div class="form-section">
                            <h4 class="form-section-title">Consent</h4>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="headOfHouseholdConsent" name="headOfHouseholdConsent" required>
                                <label class="form-check-label required-field" for="headOfHouseholdConsent">
                                    I confirm that I have obtained consent from the current head of household for this split request.
                                </label>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="termsConsent" required>
                                <label class="form-check-label required-field" for="termsConsent">
                                    I confirm that all information provided is accurate and true to the best of my knowledge.
                                </label>
                            </div>
                        </div>
                        
                        <!-- Form Buttons -->
                        <div class="d-flex justify-content-between mb-5">
                            <a href="${pageContext.request.contextPath}/registration/choose" class="btn btn-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Back
                            </a>
                            <button type="submit" class="btn btn-primary submit-btn">
                                <i class="bi bi-check2-circle me-2"></i>Submit Registration
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Residence Registration System</h5>
                        <p class="small">A system for managing household registrations and transfers.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="small">&copy; <script>document.write(new Date().getFullYear())</script> Residence Registration System. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Axios for API calls -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                console.log("DOM content loaded - initializing form...");
                
                // Form and input references
                const form = document.getElementById('splitHouseholdForm');
                const cityDropdown = document.getElementById('city');
                const districtDropdown = document.getElementById('district');
                const wardDropdown = document.getElementById('ward');
                const streetAddressInput = document.getElementById('streetAddress');
                const fullAddressInput = document.getElementById('fullAddress');
                
                // Hidden inputs
                const provinceCodeInput = document.getElementById('provinceCode');
                const provinceNameInput = document.getElementById('provinceName');
                const districtCodeInput = document.getElementById('districtCode');
                const districtNameInput = document.getElementById('districtName');
                const wardCodeInput = document.getElementById('wardCode');
                const wardNameInput = document.getElementById('wardName');
                
                // Household and member elements
                const currentHouseholdSelect = document.getElementById('currentHouseholdId');
                const previousAddressInput = document.getElementById('previousAddress');
                const memberCheckboxes = document.querySelectorAll('.member-checkbox');
                const headRadios = document.querySelectorAll('.head-radio');
                
                // Validate elements exist to prevent JS errors
                if (!form || !cityDropdown || !districtDropdown || !wardDropdown) {
                    console.error("Critical form elements missing");
                    return;
                }
                
                // Load address data using fetch instead of axios
                async function fetchAddressData() {
                    try {
                        console.log("Fetching address data...");
                        const response = await fetch("https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json");
                        
                        if (!response.ok) {
                            throw new Error(`HTTP error! Status: ${response.status}`);
                        }
                        
                        const data = await response.json();
                        console.log(`Address data loaded: ${data.length} provinces`);
                        renderCities(data);
                    } catch (error) {
                        console.error("Error loading address data:", error);
                        alert("Failed to load address data. Please refresh the page and try again. Error: " + error.message);
                    }
                }
                
                // Populate city dropdown and set up event listeners
                function renderCities(data) {
                    // Clear and populate cities dropdown
                    cityDropdown.innerHTML = '<option value="">Select Province/City</option>';
                    data.forEach(city => {
                        cityDropdown.appendChild(new Option(city.Name, city.Id));
                    });
                    
                    // City selection handler
                    cityDropdown.addEventListener('change', function() {
                        // Reset subsequent dropdowns
                        districtDropdown.innerHTML = '<option value="">Select District</option>';
                        wardDropdown.innerHTML = '<option value="">Select Ward</option>';
                        
                        if (!this.value) {
                            provinceNameInput.value = "";
                            provinceCodeInput.value = "";
                            return;
                        }
                        
                        // Find selected city and populate districts
                        const selectedCity = data.find(city => city.Id === this.value);
                        if (selectedCity && selectedCity.Districts) {
                            selectedCity.Districts.forEach(district => {
                                districtDropdown.appendChild(new Option(district.Name, district.Id));
                            });
                            
                            // Store province details
                            provinceNameInput.value = selectedCity.Name;
                            provinceCodeInput.value = selectedCity.Id;
                            console.log("Province selected:", selectedCity.Name);
                        }
                        
                        // Reset other values
                        districtNameInput.value = "";
                        districtCodeInput.value = "";
                        wardNameInput.value = "";
                        wardCodeInput.value = "";
                        
                        updateFullAddress();
                    });
                    
                    // District selection handler
                    districtDropdown.addEventListener('change', function() {
                        // Reset ward dropdown
                        wardDropdown.innerHTML = '<option value="">Select Ward</option>';
                        
                        if (!this.value || !cityDropdown.value) {
                            districtNameInput.value = "";
                            districtCodeInput.value = "";
                            resetWardUI();
                            return;
                        }
                        
                        try {
                            // Find selected city and district
                            const selectedCity = data.find(city => city.Id === cityDropdown.value);
                            if (!selectedCity) return;
                            
                            const selectedDistrict = selectedCity.Districts.find(district => district.Id === this.value);
                            if (!selectedDistrict) return;
                            
                            // Store district details
                            districtNameInput.value = selectedDistrict.Name;
                            districtCodeInput.value = selectedDistrict.Id;
                            console.log("District selected:", selectedDistrict.Name);
                            
                            // Process wards for this district
                            const wards = selectedDistrict.Wards || [];
                            console.log(`Found ${wards.length} wards for district ${selectedDistrict.Name}`);
                            
                            if (wards.length > 0) {
                                // Add wards to dropdown
                                wards.forEach(ward => {
                                    wardDropdown.appendChild(new Option(ward.Name, ward.Id));
                                });
                                
                                // Handle ward requirement logic
                                const wardLabel = document.querySelector('label[for="ward"]');
                                if (wards.length > 1) {
                                    // Multiple wards - make selection required
                                    if (wardLabel) {
                                        wardLabel.textContent = "Ward";
                                        wardLabel.classList.add("required-field");
                                    }
                                    wardDropdown.setAttribute("required", "required");
                                    wardDropdown.disabled = false;
                                } else {
                                    // Only one ward - make optional and auto-select
                                    if (wardLabel) {
                                        wardLabel.textContent = "Ward";
                                        wardLabel.classList.remove("required-field");
                                    }
                                    wardDropdown.removeAttribute("required");
                                    wardDropdown.disabled = false;
                                    
                                    // Auto-select the single ward
                                    wardDropdown.selectedIndex = 1;
                                    
                                    // Store ward details
                                    const selectedWard = wards[0];
                                    wardNameInput.value = selectedWard.Name;
                                    wardCodeInput.value = selectedWard.Id;
                                }
                            } else {
                                // No wards in this district
                                const wardLabel = document.querySelector('label[for="ward"]');
                                if (wardLabel) {
                                    wardLabel.textContent = "Ward (Not Available)";
                                    wardLabel.classList.remove("required-field");
                                }
                                wardDropdown.removeAttribute("required");
                                wardDropdown.disabled = true;
                            }
                            
                            updateFullAddress();
                        } catch (error) {
                            console.error("Error processing district selection:", error);
                        }
                    });
                    
                    // Ward selection handler
                    wardDropdown.addEventListener('change', function() {
                        if (!this.value) {
                            wardNameInput.value = "";
                            wardCodeInput.value = "";
                        } else {
                            // Store ward details
                            const selectedOption = this.options[this.selectedIndex];
                            wardNameInput.value = selectedOption.text;
                            wardCodeInput.value = this.value;
                        }
                        
                        updateFullAddress();
                    });
                    
                    // Street address handler
                    if (streetAddressInput) {
                        streetAddressInput.addEventListener('input', updateFullAddress);
                    }
                }
                
                // Reset ward UI to default state
                function resetWardUI() {
                    const wardLabel = document.querySelector('label[for="ward"]');
                    if (wardLabel) {
                        wardLabel.textContent = "Ward";
                        wardLabel.classList.remove("required-field");
                    }
                    
                    wardDropdown.innerHTML = '<option value="">Select Ward</option>';
                    wardDropdown.removeAttribute("required");
                    wardDropdown.disabled = false;
                    
                    wardNameInput.value = "";
                    wardCodeInput.value = "";
                    
                    updateFullAddress();
                }
                
                // Update full address display
                function updateFullAddress() {
                    if (!fullAddressInput) return;
                    
                    const parts = [
                        streetAddressInput ? streetAddressInput.value.trim() : "",
                        wardNameInput ? wardNameInput.value : "",
                        districtNameInput ? districtNameInput.value : "",
                        provinceNameInput ? provinceNameInput.value : ""
                    ].filter(part => part.length > 0);
                    
                    fullAddressInput.value = parts.join(', ');
                }
                
                // Handle member selection checkboxes
                memberCheckboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function() {
                        const memberId = this.value;
                        const headRadio = document.getElementById('head-' + memberId);
                        
                        if (headRadio) {
                            headRadio.disabled = !this.checked;
                            if (!this.checked && headRadio.checked) {
                                headRadio.checked = false;
                            }
                        }
                        
                        updateMemberSelectionInfo();
                    });
                });
                
                // Update member selection info message
                function updateMemberSelectionInfo() {
                    const memberSelectionInfo = document.getElementById('memberSelectionInfo');
                    if (!memberSelectionInfo) return;
                    
                    const checkedCount = document.querySelectorAll('.member-checkbox:checked').length;
                    const headSelected = document.querySelector('.head-radio:checked') !== null;
                    
                    if (checkedCount === 0) {
                        memberSelectionInfo.innerHTML = '<i class="bi bi-info-circle me-2"></i>Select at least one member to move to the new household.';
                        memberSelectionInfo.className = 'alert alert-info mt-3';
                    } else if (!headSelected) {
                        memberSelectionInfo.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i>Please select a head for the new household.';
                        memberSelectionInfo.className = 'alert alert-warning mt-3';
                    } else {
                        memberSelectionInfo.innerHTML = '<i class="bi bi-check-circle me-2"></i>You have selected ' + checkedCount + ' member(s) and designated a head for the new household.';
                        memberSelectionInfo.className = 'alert alert-success mt-3';
                    }
                }
                
                // Form validation
                if (form) {
                    form.addEventListener('submit', function(event) {
                        console.log("Form submission attempted");
                        
                        // Validate member selection
                        const checkedMembers = document.querySelectorAll('.member-checkbox:checked');
                        if (checkedMembers.length === 0) {
                            event.preventDefault();
                            alert('Please select at least one member to move to the new household.');
                            return;
                        }
                        
                        // Validate head selection
                        const headSelected = document.querySelector('.head-radio:checked');
                        if (!headSelected) {
                            event.preventDefault();
                            alert('Please designate a head for the new household.');
                            return;
                        }
                        
                        // Validate ward if required
                        if (wardDropdown && wardDropdown.hasAttribute('required') && !wardDropdown.value) {
                            event.preventDefault();
                            wardDropdown.classList.add('is-invalid');
                            wardDropdown.style.borderColor = '#dc3545';
                            alert('Please select a ward for the new address.');
                            return;
                        }
                        
                        // Validate all required fields
                        const requiredFields = form.querySelectorAll('[required]');
                        let isValid = true;
                        
                        requiredFields.forEach(field => {
                            if (!field.value.trim()) {
                                isValid = false;
                                field.classList.add('is-invalid');
                                if (field.tagName === 'SELECT') {
                                    field.style.borderColor = '#dc3545';
                                }
                            } else {
                                field.classList.remove('is-invalid');
                                if (field.tagName === 'SELECT') {
                                    field.style.borderColor = '';
                                }
                            }
                        });
                        
                        if (!isValid) {
                            event.preventDefault();
                            alert('Please fill in all required fields before submitting.');
                            return;
                        }
                        
                        // Validate complete address is filled
                        if (fullAddressInput && !fullAddressInput.value.trim()) {
                            event.preventDefault();
                            alert('Please complete the address information for the new household.');
                            return;
                        }
                        
                        console.log("Form validation passed, submitting form");
                    });
                }
                
                // Initialize address data
                fetchAddressData();
                
                // Handle household selection
                if (currentHouseholdSelect) {
                    currentHouseholdSelect.addEventListener('change', async function() {
                        if (!previousAddressInput) return;
                        
                        const householdId = this.value;
                        if (!householdId) {
                            previousAddressInput.value = '';
                            return;
                        }
                        
                        try {
                            const response = await fetch('${pageContext.request.contextPath}/api/full-address?householdId=' + householdId);
                            if (response.ok) {
                                const data = await response.json();
                                previousAddressInput.value = data.address || '';
                            } else {
                                console.error('Error fetching household address:', response.status);
                                previousAddressInput.value = 'Error loading address';
                            }
                        } catch (error) {
                            console.error('Error fetching household details:', error);
                            previousAddressInput.value = 'Error loading address';
                        }
                    });
                    
                    // Trigger change event for initial value
                    if (currentHouseholdSelect.value) {
                        const event = new Event('change');
                        currentHouseholdSelect.dispatchEvent(event);
                    }
                }
                
                console.log("Form initialization complete");
            });
        </script>
    </body>
</html>
