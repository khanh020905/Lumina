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
        <title>My Profile - Lumina Learning</title>
        
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
            }

            /* --- Global Reset --- */
            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-main);
                overflow-x: hidden;
            }

            a { text-decoration: none; color: inherit; }

            /* --- NAVBAR (Same as Home) --- */
            .navbar-custom { background-color: white; border-bottom: 1px solid #e5e7eb; padding: 0.8rem 2.5rem; z-index: 1020; }
            .brand-logo-nav { font-size: 1.3rem; font-weight: 700; color: var(--primary-purple) !important; }
            .nav-link-custom { color: var(--text-secondary) !important; font-weight: 500; margin-right: 15px; }
            .nav-link-custom:hover, .nav-link-custom.active { color: var(--primary-purple) !important; }
            .search-input { border-radius: 20px; background-color: #f3f4f6; border: none; padding-left: 40px; width: 300px; }
            .search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); z-index: 5; pointer-events: none; }
            .img-avt { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary-purple); }
            .avatar-dropdown-toggle { border: none; background: none; padding: 0; }

            /* --- PREMIUM DROPDOWN STYLES --- */
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

            /* --- Container --- */
            .profile-container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 0 20px;
            }

            /* --- Header Section --- */
            .profile-header {
                position: relative;
                background: var(--card-bg);
                border-radius: 16px;
                overflow: hidden;
                border: 1px solid var(--border-color);
                margin-bottom: 24px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            }

            .header-bg {
                height: 160px;
                background: linear-gradient(135deg, #4f46e5, #7c3aed);
            }

            .header-content {
                padding: 0 30px 30px 30px;
                display: flex;
                align-items: flex-end;
                margin-top: -66px;
                position: relative;
            }

            .profile-img {
                width: 140px;
                height: 140px;
                border-radius: 50%;
                border: 5px solid #fff;
                object-fit: cover;
                background-color: #ddd;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .user-meta {
                margin-left: 24px;
                margin-bottom: 10px;
                flex-grow: 1;
            }
            .user-meta h1 {
                font-size: 24px;
                font-weight: 800;
                color: var(--text-main);
                margin-bottom: 4px;
            }
            .user-meta .role {
                display: inline-block;
                background-color: #e0e7ff;
                color: #4338ca;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            .edit-btn {
                position: absolute;
                top: 20px;
                right: 20px;
                background: rgba(255,255,255,0.2);
                backdrop-filter: blur(4px);
                padding: 8px 16px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                color: white;
                cursor: pointer;
                border: 1px solid rgba(255,255,255,0.4);
                transition: background 0.2s;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .edit-btn:hover { background: rgba(255,255,255,0.3); color: white; }

            /* --- Grid Layout --- */
            .content-grid {
                display: grid;
                grid-template-columns: 2fr 1fr; /* Left is wider */
                gap: 24px;
            }

            /* --- Cards --- */
            .content-card {
                background: var(--card-bg);
                border-radius: 16px;
                border: 1px solid var(--border-color);
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                padding: 24px;
                margin-bottom: 24px;
            }

            .section-header {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                font-weight: 700;
                font-size: 1.1rem;
                color: var(--text-main);
                border-bottom: 1px solid #f3f4f6;
                padding-bottom: 15px;
            }
            .section-header i {
                margin-right: 10px;
                color: var(--primary-purple);
            }

            .about-text {
                color: var(--text-secondary);
                line-height: 1.6;
                font-size: 15px;
            }

            /* --- Contact Info --- */
            .contact-item { margin-bottom: 16px; }
            .contact-item label {
                display: block;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                color: var(--text-secondary);
                margin-bottom: 4px;
                letter-spacing: 0.5px;
            }
            .contact-item span {
                font-weight: 500;
                font-size: 15px;
                color: var(--text-main);
            }

            /* --- Stats --- */
            .stat-row {
                display: flex;
                align-items: center;
                padding: 20px;
                background: #f8fafc;
                border-radius: 12px;
                border: 1px solid #f1f5f9;
            }
            .stat-icon {
                width: 48px;
                height: 48px;
                background: #e0e7ff;
                color: var(--primary-purple);
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
                margin-right: 16px;
                font-size: 20px;
            }
            .stat-value {
                font-size: 24px;
                font-weight: 800;
                color: var(--text-main);
                line-height: 1;
                margin-bottom: 4px;
            }
            .stat-label {
                font-size: 13px;
                color: var(--text-secondary);
                font-weight: 500;
            }

            /* --- Courses Section --- */
            .courses-title-row { margin: 20px 0 20px 0; }
            .courses-title-row h2 { font-size: 1.5rem; font-weight: 800; color: var(--text-main); }

            .course-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 24px;
            }

            .my-course-card {
                background: white;
                border: 1px solid var(--border-color);
                border-radius: 12px;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                transition: transform 0.2s, box-shadow 0.2s;
                height: 100%;
            }
            .my-course-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            }

            .course-img {
                height: 150px;
                width: 100%;
                object-fit: cover;
            }
            .my-course-body {
                padding: 16px;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .category-badge {
                font-size: 11px;
                color: var(--primary-purple);
                font-weight: 700;
                text-transform: uppercase;
                margin-bottom: 6px;
            }
            .course-code-text {
                font-size: 0.8rem;
                color: var(--text-secondary);
                font-weight: 600;
                margin-bottom: 5px;
            }
            .course-title-text {
                font-size: 1.05rem;
                font-weight: 700;
                margin-bottom: 15px;
                line-height: 1.4;
                color: var(--text-main);
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .progress-meta {
                display: flex;
                justify-content: space-between;
                font-size: 12px;
                margin-bottom: 6px;
                color: var(--text-secondary);
                font-weight: 500;
            }
            .progress-bar-bg {
                height: 6px;
                background: #e5e7eb;
                border-radius: 10px;
                overflow: hidden;
                margin-bottom: 12px;
                width: 100%;
            }
            .progress-fill {
                height: 100%;
                background: var(--primary-purple);
                border-radius: 10px;
            }
            .footer-meta {
                font-size: 11px;
                color: var(--text-secondary);
                margin-top: auto;
                padding-top: 10px;
                border-top: 1px solid #f3f4f6;
            }

            .completed-badge {
                color: var(--success);
                display: flex;
                align-items: center;
                font-weight: 700;
                font-size: 13px;
                margin-bottom: 8px;
            }
            .completed-badge i { margin-right: 6px; }

            /* Responsive */
            @media (max-width: 768px) {
                .content-grid { grid-template-columns: 1fr; }
                .header-content { flex-direction: column; align-items: center; text-align: center; margin-top: -50px; }
                .user-meta { margin-left: 0; margin-top: 15px; }
                .edit-btn { top: 15px; right: 15px; background: rgba(0,0,0,0.5); border: none; }
            }
        </style>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String name = (user.getUsername() != null) ? user.getUsername() : "Student";
            int role = user.getRole();
            String about = user.getBio();
            String email = user.getEmail();
            String phone = user.getPhoneNumber();
            String avt = user.getUserAvt();

            String displayRole = "Student";
            if (role == 1) {
                displayRole = "Super Admin";
            } else if (role == 2) {
                displayRole = "Admin";
            }

            if (about == null || about.isEmpty()) {
                about = "Passionate about creating intuitive and engaging user experiences. Currently learning advanced software patterns.";
            }

            if (avt == null || avt.isEmpty()) {
                avt = "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";
            }

            List<Course> myCourse = (List<Course>) session.getAttribute("myCourse");
            if (myCourse == null) {
                myCourse = new ArrayList<>();
            }
            
            List<Course> cartItems = (List<Course>) session.getAttribute("cart");
            int cartCount = (cartItems != null) ? cartItems.size() : 0;
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
                                <img class="img-avt" src="<%=avt%>" alt="User">
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <div class="dropdown-user-info">
                                        <img src="<%=avt%>" alt="Avatar">
                                        <div class="dropdown-user-details">
                                            <h6><%= name%></h6>
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

        <div class="profile-container">

            <div class="profile-header">
                <a href="accountSetting.jsp" class="edit-btn"><i class="fas fa-pen"></i> Edit Profile</a>
                <div class="header-bg"></div>
                <div class="header-content">
                    <img src="<%= avt%>" alt="Profile" class="profile-img">
                    <div class="user-meta">
                        <h1><%= name%></h1>
                        <span class="role"><%= displayRole%></span>
                    </div>
                </div>
            </div>

            <div class="content-grid">

                <div class="left-col">
                    <div class="content-card">
                        <div class="section-header"><i class="far fa-user"></i> About Me</div>
                        <p class="about-text"><%= about%></p>
                    </div>

                    <div class="content-card">
                        <div class="section-header"><i class="far fa-address-card"></i> Contact Information</div>
                        <div class="contact-item">
                            <label>Email</label>
                            <span><%= email%></span>
                        </div>
                        <div class="contact-item">
                            <label>Phone</label>
                            <span><%= phone != null ? phone : "Not provided"%></span>
                        </div>
                    </div>
                </div>

                <div class="right-col">
                    <div class="content-card">
                        <div class="section-header"><i class="fas fa-chart-line"></i> Learning Stats</div>
                        <div class="stat-row">
                            <div class="stat-icon"><i class="fas fa-book-open"></i></div>
                            <div>
                                <div class="stat-value"><%= myCourse.size()%></div>
                                <div class="stat-label">Courses Enrolled</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="courses-title-row">
                <h2>My Courses</h2>
            </div>

            <div class="course-grid">
                <% if (myCourse.isEmpty()) { %>
                    <div style="grid-column: 1 / -1; text-align: center; color: #6b7280; padding: 40px; background:white; border-radius:12px; border:1px solid #e5e7eb;">
                        <i class="fas fa-graduation-cap" style="font-size: 3rem; margin-bottom: 15px; color: #d1d5db;"></i>
                        <p>You haven't enrolled in any courses yet.</p>
                        <a href="courses" style="color:var(--primary-purple); font-weight:600;">Browse Catalog</a>
                    </div>
                <% } else {
                    for (Course c : myCourse) {
                        int progress = (int) (Math.random() * 100);
                        boolean isCompleted = (progress == 100);
                %>
                <div class="my-course-card">
                    <img src="<%= c.getImg_url() %>" class="course-img" alt="Course Thumbnail">
                    <div class="my-course-body">
                        <div class="category-badge"><%= c.getCategory() != null ? c.getCategory() : "COURSE" %></div>
                        <div class="course-code-text"><%= c.getCourseCode()%></div>
                        <div class="course-title-text"><%= c.getTitle() %></div>

                        <% if (!isCompleted) {%>
                        <div class="progress-meta">
                            <span><%= progress %>% Complete</span>
                        </div>
                        <div class="progress-bar-bg">
                            <div class="progress-fill" style="width: <%= progress %>%;"></div>
                        </div>
                        <div class="footer-meta">Last accessed: Just now</div>
                        <% } else { %>
                        <div class="completed-badge">
                            <i class="fas fa-check-circle"></i> Completed
                        </div>
                        <div class="footer-meta">Completed on 2024-01-01</div>
                        <% } %>
                    </div>
                </div>
                <% } } %>
            </div>

        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>