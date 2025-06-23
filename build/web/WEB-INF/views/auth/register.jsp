<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
         prefix="c" %>
<%@ page import="dao.AddressDAO" %>
<%@ page import="model.Province" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Register - Residence Registration System</title>
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
            .register-container {
                max-width: 650px;
                margin: 0 auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                margin-top: 50px;
                margin-bottom: 50px;
            }
            .register-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .register-icon {
                font-size: 3rem;
                color: #198754;
                margin-bottom: 15px;
            }
            .form-floating {
                margin-bottom: 20px;
            }
            .btn-register {
                padding: 10px;
                font-weight: 500;
            }
            .register-footer {
                text-align: center;
                margin-top: 20px;
            }
            .alert {
                margin-bottom: 20px;
            }
            .navbar {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .form-text {
                font-size: 0.875em;
                color: #6c757d;
            }
            .is-loading .spinner-border {
                display: inline-block !important;
            }
            .feedback-icon {
                position: absolute;
                right: 2.5rem;
                top: 1rem;
                z-index: 5;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 24px;
                height: 24px;
            }
            .spinner-border {
                width: 1rem;
                height: 1rem;
                border-width: 0.15em;
                display: none;
            }
            .valid-icon {
                color: #198754;
                display: none;
                font-size: 1.5rem;
            }
            .invalid-icon {
                color: #dc3545;
                display: none;
                font-size: 1.5rem;
            }

            /* Debug styles to make icons more visible */
            .bi-check-circle-fill, .bi-x-circle-fill {
                font-size: 1.5rem;
            }

            .form-select.is-loading {
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='0 0 40 40'%3E%3Cpath d='M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z'/%3E%3Cpath fill='%23000' d='M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0C22.32,8.481,24.301,9.057,26.013,10.047z'%3E%3CanimateTransform attributeType='xml' attributeName='transform' type='rotate' from='0 20 20' to='360 20 20' dur='0.5s' repeatCount='indefinite'/%3E%3C/path%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 0.75rem center;
                background-size: 1rem 1rem;
            }

            /* Address selection styles */
            .address-row {
                margin-bottom: 15px;
            }
            .address-select {
                margin-bottom: 10px;
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
                                class="nav-link"
                                href="${pageContext.request.contextPath}/login"
                                >
                                <i class="bi bi-box-arrow-in-right me-1"></i> Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a
                                class="nav-link active"
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
            <div class="register-container">
                <div class="register-header">
                    <i class="bi bi-person-plus-fill register-icon"></i>
                    <h2>Create Account</h2>
                    <p class="text-muted">
                        Register to access the Residence Registration System
                    </p>
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

                <!-- Duplication check alerts -->
                <div
                    id="emailDuplicateAlert"
                    class="alert alert-danger alert-dismissible fade show"
                    role="alert"
                    style="display: none"
                    >
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    This email is already registered in the system.
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                        ></button>
                </div>

                <div
                    id="cccdDuplicateAlert"
                    class="alert alert-danger alert-dismissible fade show"
                    role="alert"
                    style="display: none"
                    >
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    This ID number is already registered in the system.
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                        ></button>
                </div>

                <form
                    id="registrationForm"
                    action="${pageContext.request.contextPath}/register"
                    method="post"
                    class="needs-validation"
                    novalidate
                    >
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-floating mb-3">
                                <input
                                    type="text"
                                    name="fullName"
                                    class="form-control"
                                    id="floatingName"
                                    placeholder="Full Name"
                                    required
                                    />
                                <label for="floatingName"
                                       ><i class="bi bi-person me-2"></i>Full Name</label
                                >
                                <div class="invalid-feedback">
                                    Please enter your full name.
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating mb-3 position-relative">
                                <input
                                    type="email"
                                    name="email"
                                    class="form-control"
                                    id="floatingEmail"
                                    placeholder="name@example.com"
                                    required
                                    />
                                <label for="floatingEmail"
                                       ><i class="bi bi-envelope me-2"></i>Email Address</label
                                >
                                <div class="feedback-icon">
                                    <span
                                        class="spinner-border text-primary"
                                        id="emailSpinner"
                                        ></span>
                                    <i
                                        class="bi bi-check-circle-fill valid-icon"
                                        id="emailValid"
                                        ></i>
                                    <i
                                        class="bi bi-x-circle-fill invalid-icon"
                                        id="emailInvalid"
                                        ></i>
                                </div>
                                <div class="invalid-feedback" id="emailFeedback">
                                    Please enter a valid email address.
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input
                                    type="password"
                                    name="password"
                                    class="form-control"
                                    id="floatingPassword"
                                    placeholder="Password"
                                    required
                                    pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
                                    />
                                <label for="floatingPassword"
                                       ><i class="bi bi-key me-2"></i>Password</label
                                >
                                <div class="form-text">
                                    Password must be at least 8 characters with uppercase, lowercase, and numbers.
                                </div>
                                <div class="invalid-feedback">
                                    Password must meet the requirements.
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating mb-3">
                                <input
                                    type="text"
                                    name="cccd"
                                    class="form-control"
                                    id="floatingCCCD"
                                    placeholder="ID Number"
                                    required
                                    pattern="[0-9]{12}"
                                    maxlength="12"
                                    />
                                <label for="floatingCCCD"
                                       ><i class="bi bi-card-text me-2"></i>ID Number</label
                                >
                                <div class="feedback-icon">
                                    <span
                                        class="spinner-border text-primary"
                                        id="cccdSpinner"
                                        ></span>
                                    <i
                                        class="bi bi-check-circle-fill valid-icon"
                                        id="cccdValid"
                                        ></i>
                                    <i
                                        class="bi bi-x-circle-fill invalid-icon"
                                        id="cccdInvalid"
                                        ></i>
                                </div>
                                <div class="form-text">
                                    Enter your 12-digit ID number.
                                </div>
                                <div class="invalid-feedback" id="cccdFeedback">
                                    Please enter a valid 12-digit ID number.
                                </div>
                            </div>
                        </div>

                        <!-- Gender Field -->
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <select name="gender" class="form-select" id="floatingGender" required>
                                    <option value="">-- Select Gender --</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                                <label for="floatingGender">
                                    <i class="bi bi-gender-ambiguous me-2"></i>Gender
                                </label>
                                <div class="invalid-feedback">
                                    Please select your gender.
                                </div>
                            </div>
                        </div>

                        <!-- Phone Number Field -->
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input
                                    type="tel"
                                    name="phoneNumber"
                                    class="form-control"
                                    id="floatingPhone"
                                    placeholder="Phone Number"
                                    pattern="[0-9]{10,11}"
                                    maxlength="11"
                                    />
                                <label for="floatingPhone">
                                    <i class="bi bi-telephone me-2"></i>Phone Number
                                </label>
                                <div class="form-text">
                                    Enter your 10-11 digit phone number.
                                </div>
                                <div class="invalid-feedback">
                                    Please enter a valid phone number.
                                </div>
                            </div>
                        </div>

                        <!-- Address Section -->
                        <div class="col-md-12">
                            <h5 class="mb-3"><i class="bi bi-geo-alt me-2"></i>Address Information</h5>
                        </div>

                        <div class="col-md-12 address-row">
                            <div class="row">
                                <div class="col-md-4 address-select">
                                    <label for="city" class="form-label">Province/City</label>
                                    <select class="form-select" id="city" name="provinceCode" required>
                                        <option value="">Select Province/City</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a province/city.
                                    </div>
                                </div>

                                <div class="col-md-4 address-select">
                                    <label for="district" class="form-label">District</label>
                                    <select class="form-select" id="district" name="districtCode" required>
                                        <option value="">Select District</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a district.
                                    </div>
                                </div>

                                <div class="col-md-4 address-select">
                                    <label for="ward" class="form-label">Ward</label>
                                    <select class="form-select" id="ward" name="wardCode" required>
                                        <option value="">Select Ward</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a ward.
                                    </div>
                                </div>
                            </div>
                        </div>

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
                            <input type="hidden" name="address" id="completeAddress" />

                            <!-- Hidden fields to store location names -->
                            <input type="hidden" name="provinceName" id="provinceName" />
                            <input type="hidden" name="districtName" id="districtName" />
                            <input type="hidden" name="wardName" id="wardName" />
                        </div>
                    </div>

                    <div class="form-check mb-3">
                        <input
                            class="form-check-input"
                            type="checkbox"
                            value=""
                            id="termsCheck"
                            required
                            />
                        <label class="form-check-label" for="termsCheck">


                            I agree to the <a href="#">Terms of Service</a> and
                            <a href="#">Privacy Policy</a>
                        </label>
                        <div class="invalid-feedback">
                            You must agree before registering.
                        </div>
                    </div>

                    <div class="d-grid">
                        <button
                            type="submit"
                            class="btn btn-success btn-register"
                            id="registerButton"
                            >
                            <i class="bi bi-person-plus-fill me-2"></i>Create Account
                        </button>
                    </div>
                </form>

                <div class="register-footer">
                    <p>
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login">Login here</a>
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


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

        <!-- Form validation script -->
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
                'use strict';

                // Variables for duplication checks
                let emailDuplicate = false;
                let cccdDuplicate = false;
                let emailTimeout = null;
                let cccdTimeout = null;

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation');

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener(
                            'submit',
                            function (event) {
                                // We're now handling address validation in the jQuery submit handler
                                // So we only need to check form validity and duplication issues here

                                // Check form validity and duplication issues
                                if (!form.checkValidity() || emailDuplicate || cccdDuplicate) {
                                    event.preventDefault();
                                    event.stopPropagation();

                                    // Show appropriate alerts if duplication is the issue
                                    if (emailDuplicate) {
                                        document.getElementById("emailDuplicateAlert").style.display = "block";
                                    }
                                    if (cccdDuplicate) {
                                        document.getElementById("cccdDuplicateAlert").style.display = "block";
                                    }
                                }

                                form.classList.add('was-validated');
                            },
                            false
                            );
                });

                // Password confirmation validation
                const password = document.getElementById('floatingPassword');
                const confirmPassword = document.getElementById('floatingConfirmPassword');

                function validatePassword() {
                    if (password.value !== confirmPassword.value) {
                        confirmPassword.setCustomValidity("Passwords don't match");
                    } else {
                        confirmPassword.setCustomValidity('');
                    }
                }

                if (confirmPassword) {
                    password.addEventListener('change', validatePassword);
                    confirmPassword.addEventListener('keyup', validatePassword);
                }

                // Email duplication check
                const emailInput = document.getElementById("floatingEmail");

                emailInput.addEventListener("input", function () {
                    const email = this.value.trim();

                    // Clear previous timeout
                    if (emailTimeout) {
                        clearTimeout(emailTimeout);
                    }

                    // Reset validation state
                    emailDuplicate = false;
                    document.getElementById("emailDuplicateAlert").style.display = "none";

                    // Only check if email is valid format and not empty
                    if (email && this.checkValidity()) {
                        // Set timeout to avoid too many requests
                        emailTimeout = setTimeout(function () {
                            checkEmailDuplication(email);
                        }, 500);
                    }
                });

                // CCCD duplication check
                const cccdInput = document.getElementById("floatingCCCD");

                cccdInput.addEventListener("input", function () {
                    const cccd = this.value.trim();

                    // Clear previous timeout
                    if (cccdTimeout) {
                        clearTimeout(cccdTimeout);
                    }

                    // Reset validation state
                    cccdDuplicate = false;
                    document.getElementById("cccdDuplicateAlert").style.display = "none";

                    // Only check if CCCD is valid format (12 digits) and not empty
                    if (cccd && cccd.length === 12 && /^\d+$/.test(cccd)) {
                        // Set timeout to avoid too many requests
                        cccdTimeout = setTimeout(function () {
                            checkCCCDDuplication(cccd);
                        }, 500);
                    }
                });

                // Function to check email duplication via AJAX
                function checkEmailDuplication(email) {
                    console.log("Checking email duplication:", email);

                    $.ajax({
                        url: "${pageContext.request.contextPath}/validate/email", // Ensure this is correct
                        type: "GET",
                        data: {email: email},
                        dataType: "json",
                        success: function (data) {
                            console.log("Response:", data);

                            if (data.isDuplicate) {
                                emailDuplicate = true;
                                document.getElementById("emailDuplicateAlert").style.display = "block";
                            } else {
                                emailDuplicate = false;
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error checking email:", error);
                            console.error("Response:", xhr.responseText); // Log the response text
                            emailDuplicate = false;
                        }
                    });
                }

                // Function to check CCCD duplication via AJAX
                function checkCCCDDuplication(cccd) {
                    console.log("Checking ID number duplication:", cccd);

                    $.ajax({
                        url: "${pageContext.request.contextPath}/validate/cccd",
                        type: "GET",
                        data: {cccd: cccd},
                        dataType: "json",
                        success: function (data) {
                            console.log("ID check response:", data);

                            if (data.isDuplicate) {
                                console.log("ID number already exists");
                                cccdDuplicate = true;
                                document.getElementById("cccdDuplicateAlert").style.display = "block";
                            } else {
                                console.log("ID number is valid");
                                cccdDuplicate = false;
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error checking ID number:", error);
                            cccdDuplicate = false;
                        }
                    });
                }
            })();
        </script>

        <!-- Address selection script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                console.log("Initializing address dropdowns");
                
                // Address selection variables
                const citis = document.getElementById("city");
                const districts = document.getElementById("district");
                const wards = document.getElementById("ward");
                const houseNumberInput = document.getElementById("floatingHouseNumber");
                const completeAddressInput = document.getElementById("completeAddress");
                const provinceNameInput = document.getElementById("provinceName");
                const districtNameInput = document.getElementById("districtName");
                const wardNameInput = document.getElementById("wardName");
                
                // Validate elements exist
                if (!citis || !districts || !wards || !houseNumberInput || !completeAddressInput) {
                    console.error("Critical address elements missing");
                    return;
                }

                // Fetch address data
                console.log("Fetching address data...");
                fetch("https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json")
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! Status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log("Address data loaded successfully:", data.length, "provinces");
                        renderCities(data);
                    })
                    .catch(error => {
                        console.error("Error loading address data:", error);
                        alert("Failed to load address data. Please refresh the page and try again.");
                    });

                // Render cities/provinces
                function renderCities(data) {
                    citis.innerHTML = '<option value="">Select Province/City</option>';
                    for (const x of data) {
                        citis.options[citis.options.length] = new Option(x.Name, x.Id);
                    }

                    // City change event
                    citis.onchange = function() {
                        districts.innerHTML = '<option value="">Select District</option>';
                        wards.innerHTML = '<option value="">Select Ward</option>';
                        
                        if (this.value) {
                            const result = data.filter(n => n.Id === this.value);
                            if (result && result.length > 0 && result[0].Districts) {
                                for (const k of result[0].Districts) {
                                    districts.options[districts.options.length] = new Option(k.Name, k.Id);
                                }
                                
                                // Store the province name
                                const provinceName = this.options[this.selectedIndex].text;
                                provinceNameInput.value = provinceName;
                                console.log("Province name stored:", provinceName);
                            } else {
                                console.error("No districts found for province ID:", this.value);
                            }
                        } else {
                            provinceNameInput.value = "";
                        }
                        
                        // Clear district and ward names
                        districtNameInput.value = "";
                        wardNameInput.value = "";
                        
                        updateCompleteAddress();
                    };

                    // District change event
                    districts.onchange = function() {
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
                                districtNameInput.value = districtName;
                                
                                // Check if the district has any wards
                                if (dataWards.length > 1) {
                                    // Log individual wards for debugging
                                    dataWards.forEach((ward, index) => {
                                        console.log(`Ward ${index + 1}:`, ward.Name, ward.Id);
                                    });
                                    
                                    // Populate wards
                                    for (const w of dataWards) {
                                        wards.options[wards.options.length] = new Option(w.Name, w.Id);
                                    }
                                    
                                    // For registration, always make ward required if available
                                    wards.setAttribute("required", "required");
                                    wards.disabled = false;
                                    
                                    // Auto-select the only ward if there's exactly one
                                    if (dataWards.length === 1) {
                                        wards.selectedIndex = 1; // Select the first ward (index 1 because of the placeholder)
                                        // Trigger the change event
                                        const event = new Event('change');
                                        wards.dispatchEvent(event);
                                    }
                                } else {
                                    // No wards available for this district
                                    wards.removeAttribute("required");
                                    wards.disabled = true;
                                    
                                    console.log("District has 0 wards - Ward dropdown disabled");
                                }
                                
                                console.log("District name stored:", districtName);
                            } catch (error) {
                                console.error("Error processing district data:", error);
                            }
                        } else {
                            districtNameInput.value = "";
                            
                            // Reset ward selection
                            wards.innerHTML = '<option value="">Select Ward</option>';
                            wards.disabled = false;
                            wards.removeAttribute("required");
                            
                            console.log("District selection cleared - Ward dropdown reset");
                        }
                        
                        // Clear ward name
                        wardNameInput.value = "";
                        
                        updateCompleteAddress();
                    };

                    // Ward change event
                    wards.onchange = function() {
                        if (this.value) {
                            // Store the ward name
                            const wardName = this.options[this.selectedIndex].text;
                            wardNameInput.value = wardName;
                            console.log("Ward name stored:", wardName);
                        } else {
                            wardNameInput.value = "";
                        }
                        
                        updateCompleteAddress();
                    };

                    // House number change event
                    houseNumberInput.addEventListener("input", updateCompleteAddress);
                }

                // Function to update complete address
                function updateCompleteAddress() {
                    const houseNumber = houseNumberInput.value.trim();
                    const cityText = citis.options[citis.selectedIndex]?.text || "";
                    const districtText = districts.options[districts.selectedIndex]?.text || "";
                    const wardText = wards.options[wards.selectedIndex]?.text || "";

                    if (houseNumber &&
                        cityText && cityText !== "Select Province/City" &&
                        districtText && districtText !== "Select District") {
                        
                        let addressParts = [houseNumber];
                        
                        // Only add ward if it's selected and available
                        if (wardText && wardText !== "Select Ward") {
                            addressParts.push(wardText);
                        }
                        
                        // Always add district and city
                        addressParts.push(districtText);
                        addressParts.push(cityText);
                        
                        const completeAddress = addressParts.join(', ');
                        completeAddressInput.value = completeAddress;
                        console.log("Complete address updated:", completeAddress);
                    } else {
                        completeAddressInput.value = "";
                    }
                }

                // Form submission handler for address validation
                $("#registrationForm").submit(function(event) {
                    const houseNumber = $("#floatingHouseNumber").val();
                    const provinceCode = $("#city").val();
                    const districtCode = $("#district").val();
                    const wardCode = $("#ward").val();
                    const wardRequired = $("#ward").prop("required") || false;

                    console.log("Form submission - Address values:", {
                        houseNumber: houseNumber,
                        provinceCode: provinceCode,
                        districtCode: districtCode,
                        wardCode: wardCode,
                        wardRequired: wardRequired
                    });

                    // Check if all required address fields are filled
                    if (houseNumber.trim() === "" || !districtCode || !provinceCode) {
                        console.error("Address information incomplete");
                        event.preventDefault();
                        alert("Please fill in all address information");
                        return false;
                    }
                    
                    // Check ward if it's required
                    if (wardRequired && !wardCode) {
                        console.error("Ward is required but not selected");
                        event.preventDefault();
                        $("#ward").addClass("is-invalid").css("border-color", "#dc3545");
                        alert("Please select a ward for your address");
                        return false;
                    }

                    // Create the complete address using the stored names
                    const provinceName = provinceNameInput.value;
                    const districtName = districtNameInput.value;
                    const wardName = wardNameInput.value;

                    // Build address with or without ward
                    let addressParts = [houseNumber];
                    if (wardName) addressParts.push(wardName);
                    addressParts.push(districtName);
                    addressParts.push(provinceName);
                    
                    const completeAddress = addressParts.join(', ');
                    $("#completeAddress").val(completeAddress);
                    console.log("Complete address set to:", completeAddress);

                    // Let the form continue submission if everything is valid
                    return true;
                });
            });
        </script>
    </body>
</html>
