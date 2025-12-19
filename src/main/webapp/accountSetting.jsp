<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Account Settings - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            /* --- CSS Variables --- */
            :root {
                --primary-purple: #5d3fd3;
                --primary-hover: #4a32a8;
                --text-main: #111827;
                --text-secondary: #6b7280;
                --bg-color: #f8f9fa;
                --card-bg: #ffffff;
                --border-color: #e5e7eb;
                --success: #10b981;
                
                /* Sidebar specific */
                --sidebar-width: 260px;
                --sidebar-active-bg: #e0e7ff;
                --sidebar-active-text: #4338ca;
            }

            /* --- Global Reset --- */
            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-main);
                overflow-x: hidden;
            }

            a { text-decoration: none; color: inherit; }

            /* --- NAVBAR (Standard) --- */
            .navbar-custom { background-color: white; border-bottom: 1px solid #e5e7eb; padding: 0.8rem 2.5rem; z-index: 1020; }
            .brand-logo-nav { font-size: 1.3rem; font-weight: 700; color: var(--primary-purple) !important; }
            .nav-link-custom { color: var(--text-secondary) !important; font-weight: 500; margin-right: 15px; }
            .nav-link-custom:hover, .nav-link-custom.active { color: var(--primary-purple) !important; }
            .search-input { border-radius: 20px; background-color: #f3f4f6; border: none; padding-left: 40px; width: 300px; }
            .search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); z-index: 5; pointer-events: none; }
            .img-avt { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary-purple); }
            .avatar-dropdown-toggle { border: none; background: none; padding: 0; }

            /* --- DROPDOWN --- */
            .dropdown-menu { border: none; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 10px; min-width: 260px; margin-top: 10px !important; animation: fadeIn 0.2s ease-out; }
            .dropdown-user-info { display: flex; align-items: center; padding: 12px; margin-bottom: 10px; background-color: #f9fafb; border-radius: 10px; border: 1px solid #f3f4f6; }
            .dropdown-user-info img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 12px; border: 2px solid var(--primary-purple); }
            .dropdown-user-details h6 { margin: 0; font-size: 0.95rem; font-weight: 700; color: var(--text-main); }
            .dropdown-user-details span { font-size: 0.8rem; color: var(--text-secondary); }
            .dropdown-item { padding: 10px 15px; font-size: 0.95rem; color: #4b5563; font-weight: 500; border-radius: 8px; margin-bottom: 4px; transition: all 0.2s ease; display: flex; align-items: center; }
            .dropdown-item i { width: 25px; font-size: 1rem; color: #9ca3af; transition: color 0.2s; }
            .dropdown-item:hover { background-color: #f5f3ff; color: var(--primary-purple); transform: translateX(4px); }
            .dropdown-item:hover i { color: var(--primary-purple); }
            .dropdown-item.text-danger:hover { background-color: #fef2f2; color: #dc2626 !important; }
            .dropdown-item.text-danger:hover i { color: #dc2626 !important; }
            .dropdown-divider { margin: 8px 0; border-color: #f3f4f6; }
            @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

            /* --- SETTINGS LAYOUT --- */
            .settings-wrapper {
                max-width: 1100px;
                margin: 40px auto;
                padding: 0 20px;
                display: flex;
                gap: 40px;
            }

            /* Sidebar */
            .settings-sidebar {
                width: var(--sidebar-width);
                flex-shrink: 0;
            }
            .sidebar-header {
                font-size: 0.85rem;
                font-weight: 700;
                text-transform: uppercase;
                color: var(--text-secondary);
                margin-bottom: 15px;
                letter-spacing: 0.5px;
            }
            .nav-pill-item {
                display: flex;
                align-items: center;
                padding: 12px 16px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 0.95rem;
                color: var(--text-secondary);
                cursor: pointer;
                transition: all 0.2s;
                margin-bottom: 8px;
            }
            .nav-pill-item i {
                margin-right: 12px;
                font-size: 1.1rem;
                width: 24px;
                text-align: center;
            }
            .nav-pill-item:hover {
                background-color: white;
                color: var(--text-main);
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }
            .nav-pill-item.active {
                background-color: var(--sidebar-active-bg);
                color: var(--sidebar-active-text);
            }
            .nav-pill-item.active i {
                color: var(--sidebar-active-text);
            }

            /* Main Content Area */
            .settings-content {
                flex-grow: 1;
            }

            .settings-card {
                background: white;
                border-radius: 16px;
                border: 1px solid var(--border-color);
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                padding: 30px;
                animation: fadeUp 0.3s ease-out;
            }
            @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

            .content-header {
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 20px;
                margin-bottom: 30px;
            }
            .content-title {
                font-size: 1.5rem;
                font-weight: 800;
                color: var(--text-main);
                margin-bottom: 5px;
            }
            .content-desc {
                color: var(--text-secondary);
                font-size: 0.95rem;
            }

            /* Forms */
            .avatar-upload-area {
                display: flex;
                align-items: center;
                gap: 24px;
                margin-bottom: 30px;
                padding: 20px;
                background-color: #f9fafb;
                border-radius: 12px;
                border: 1px dashed #d1d5db;
            }
            .avatar-preview {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid white;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            .btn-outline {
                background: white;
                border: 1px solid #d1d5db;
                color: var(--text-main);
                padding: 8px 16px;
                border-radius: 8px;
                font-weight: 600;
                font-size: 0.9rem;
                cursor: pointer;
                transition: 0.2s;
            }
            .btn-outline:hover { background: #f3f4f6; border-color: #9ca3af; }

            .form-label {
                font-weight: 600;
                font-size: 0.9rem;
                color: var(--text-main);
                margin-bottom: 8px;
                display: block;
            }
            .form-control-custom {
                width: 100%;
                padding: 10px 15px;
                border-radius: 8px;
                border: 1px solid #d1d5db;
                background-color: #f9fafb;
                font-size: 0.95rem;
                transition: 0.2s;
                font-family: inherit;
            }
            .form-control-custom:focus {
                outline: none;
                border-color: var(--primary-purple);
                background-color: white;
                box-shadow: 0 0 0 3px rgba(93, 63, 211, 0.1);
            }
            .form-control-custom[readonly] {
                background-color: #e5e7eb;
                cursor: not-allowed;
            }
            textarea.form-control-custom {
                min-height: 120px;
                resize: vertical;
            }

            .btn-save {
                background-color: var(--primary-purple);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: 0.2s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-save:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }

            /* Tabs logic */
            .tab-pane { display: none; }
            .tab-pane.active { display: block; }

            /* Responsive */
            @media (max-width: 768px) {
                .settings-wrapper { flex-direction: column; gap: 20px; }
                .settings-sidebar { width: 100%; display: flex; overflow-x: auto; padding-bottom: 10px; }
                .nav-pill-item { white-space: nowrap; margin-right: 10px; margin-bottom: 0; }
                .settings-card { padding: 20px; }
            }

            /* --- TOAST --- */
            .toast-container { z-index: 1090 !important; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); min-width: 300px; }
            .toast { font-size: 1rem; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        </style>
    </head>
    <body>

        <%
            // 1. Session & User Check
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // 2. User Data
            String username = user.getUsername();
            String fullName = (user.getName() != null) ? user.getName() : username;
            String email = user.getEmail();
            String phone = user.getPhoneNumber();
            String bio = (user.getBio() != null) ? user.getBio() : "";
            String userAvt = (user.getUserAvt() != null) ? user.getUserAvt() : "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";

            // 3. Cart Data for Navbar
            List<Course> cartItems = (List<Course>) session.getAttribute("cart");
            int cartCount = (cartItems != null) ? cartItems.size() : 0;
            
            // 4. Message Handling
            String msg = (String) request.getAttribute("msg");
        %>

        <nav class="navbar navbar-expand-lg navbar-custom sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand brand-logo-nav" href="home"><i class="fas fa-book-open me-2"></i> Lumina</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="courses">Courses</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="community.jsp">Community</a></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <div class="position-relative me-4">
                            <i class="fas fa-search search-icon"></i>
                            <form action="courses" method="get">
                                <input class="form-control search-input" type="search" name="search" placeholder="Search courses...">
                            </form>
                        </div>
                        
                        <a href="cart.jsp" class="me-4 text-decoration-none position-relative" style="color: #666;">
                            <i class="fas fa-shopping-cart" style="font-size:1.2rem;"></i>
                            <% if (cartCount > 0) {%>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                                <%= cartCount%>
                            </span>
                            <% }%>
                        </a>

                        <i class="far fa-bell me-4" style="font-size:1.2rem; color:#666; cursor:pointer;"></i>
                        
                        <div class="dropdown">
                            <button class="avatar-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                <img class="img-avt" src="<%=userAvt%>" alt="User">
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <div class="dropdown-user-info">
                                        <img src="<%=userAvt%>" alt="Avatar">
                                        <div class="dropdown-user-details">
                                            <h6><%= username%></h6>
                                            <span>Student</span>
                                        </div>
                                    </div>
                                </li>
                                <li><a class="dropdown-item" href="userInfor.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                                <li><a class="dropdown-item" href="myCourses"><i class="fas fa-book"></i> My Learning</a></li>
                                <li><a class="dropdown-item" href="accountSetting.jsp"><i class="fas fa-cog"></i> Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div class="settings-wrapper">
            
            <aside class="settings-sidebar">
                <div class="sidebar-header">Preferences</div>
                <div class="nav-pill-item active" onclick="switchTab('general', this)">
                    <i class="far fa-user"></i> General
                </div>
                <div class="nav-pill-item" onclick="switchTab('security', this)">
                    <i class="fas fa-lock"></i> Security
                </div>
                <div class="nav-pill-item" onclick="switchTab('notifications', this)">
                    <i class="far fa-bell"></i> Notifications
                </div>
            </aside>

            <main class="settings-content">
                
                <div id="general" class="tab-pane active">
                    <div class="settings-card">
                        <div class="content-header">
                            <h2 class="content-title">Profile Information</h2>
                            <p class="content-desc">Update your photo and personal details.</p>
                        </div>

                        <div class="avatar-upload-area">
                            <img src="<%= userAvt%>" alt="Current Avatar" class="avatar-preview">
                            <div style="flex-grow: 1;">
                                <form action="uploadImage" method="post" enctype="multipart/form-data" id="avatarForm">
                                    <input type="file" name="imageFile" id="imageInput" style="display: none;" accept="image/*" onchange="submitAvatarUpload()">
                                    <button type="button" class="btn-outline" onclick="triggerFileSelect()">
                                        <i class="fas fa-camera me-2"></i> Change Photo
                                    </button>
                                </form>
                                <div style="font-size: 0.85rem; color: #6b7280; margin-top: 8px;">
                                    JPG, GIF or PNG. Max size of 800K.
                                </div>
                            </div>
                        </div>

                        <form action="accountSetting" method="POST">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Username</label>
                                    <input name="username" type="text" class="form-control-custom" value="<%= username%>">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input name="fullName" type="text" class="form-control-custom" value="<%= fullName%>">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Bio</label>
                                <textarea name="bio" class="form-control-custom" placeholder="Write a short bio..."><%= bio%></textarea>
                            </div>

                            <div style="height: 1px; background: #e5e7eb; margin: 30px 0;"></div>
                            
                            <h5 style="font-weight: 700; margin-bottom: 20px;">Contact Info</h5>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Email Address</label>
                                    <input name="email" type="email" class="form-control-custom" value="<%= email%>" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone Number</label>
                                    <input name="phone" type="text" class="form-control-custom" value="<%= (phone != null) ? phone : "" %>">
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn-save"><i class="far fa-save"></i> Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div id="security" class="tab-pane">
                    <div class="settings-card">
                        <div class="content-header">
                            <h2 class="content-title">Security Settings</h2>
                            <p class="content-desc">Manage your password and account security.</p>
                        </div>
                        
                        <form action="newPasswordAccountSetting" method="POST">
                            <div class="mb-4">
                                <label class="form-label">Current Password</label>
                                <input name="currentPassword" type="password" class="form-control-custom" placeholder="Enter current password">
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">New Password</label>
                                    <input name="newPassword" type="password" class="form-control-custom" placeholder="New password">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Confirm Password</label>
                                    <input name="confirmPassword" type="password" class="form-control-custom" placeholder="Confirm password">
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn-save"><i class="fas fa-lock"></i> Update Password</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div id="notifications" class="tab-pane">
                    <div class="settings-card">
                        <div class="content-header">
                            <h2 class="content-title">Notifications</h2>
                            <p class="content-desc">Choose how you want to be notified.</p>
                        </div>
                        <div style="text-align: center; padding: 40px; color: #9ca3af;">
                            <i class="far fa-bell-slash" style="font-size: 3rem; margin-bottom: 15px;"></i>
                            <p>Notification settings are coming soon!</p>
                        </div>
                    </div>
                </div>

            </main>
        </div>
        
        <div class="toast-container">
            <div id="liveToast" class="toast align-items-center text-white border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body"></div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Tab Switching Logic
            function switchTab(tabId, navElement) {
                // Hide all tabs
                document.querySelectorAll('.tab-pane').forEach(el => el.classList.remove('active'));
                // Deactivate sidebar items
                document.querySelectorAll('.nav-pill-item').forEach(el => el.classList.remove('active'));

                // Activate target
                document.getElementById(tabId).classList.add('active');
                if(navElement) {
                    navElement.classList.add('active');
                }
            }

            // Avatar Upload
            function triggerFileSelect() {
                document.getElementById('imageInput').click();
            }
            function submitAvatarUpload() {
                document.getElementById('avatarForm').submit();
            }

            // Toast Logic
            window.onload = function () {
                <%
                    String message = (String) request.getAttribute("msg");
                    // In case you use session for messages in other servlets
                    String sessionSuccess = (String) session.getAttribute("success");
                    String sessionError = (String) session.getAttribute("error");
                    
                    if(sessionSuccess != null) session.removeAttribute("success");
                    if(sessionError != null) session.removeAttribute("error");
                %>
                
                var message = "<%= (message != null) ? message : "" %>";
                var sessionSuccess = "<%= (sessionSuccess != null) ? sessionSuccess : "" %>";
                var sessionError = "<%= (sessionError != null) ? sessionError : "" %>";

                var toastEl = document.getElementById('liveToast');
                var toastBody = toastEl.querySelector('.toast-body');
                var toastOptions = { delay: 3000 };
                var showToast = false;

                if (message.trim() !== "") {
                    // Logic for generic message (usually success in this context)
                    if(message.includes("success") || message.includes("Success")) {
                         toastEl.classList.add('bg-success');
                    } else {
                         toastEl.classList.add('bg-danger');
                    }
                    toastBody.innerText = message;
                    showToast = true;
                } 
                else if (sessionSuccess.trim() !== "") {
                    toastEl.classList.add('bg-success');
                    toastBody.innerText = sessionSuccess;
                    showToast = true;
                }
                else if (sessionError.trim() !== "") {
                    toastEl.classList.add('bg-danger');
                    toastBody.innerText = sessionError;
                    showToast = true;
                }

                if(showToast) {
                    var toast = new bootstrap.Toast(toastEl, toastOptions);
                    toast.show();
                }

                // Handle Active Tab persistence (if Controller sends it)
                <% String activeTab = (String) request.getAttribute("activeTab"); %>
                <% if (activeTab != null && !activeTab.isEmpty()) { %>
                     var tabName = "<%= activeTab %>";
                     var navItem = document.querySelector(".nav-pill-item[onclick*='" + tabName + "']");
                     switchTab(tabName, navItem);
                <% } %>
            };
        </script>
    </body>
</html>