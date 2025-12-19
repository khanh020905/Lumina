<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Learning - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-purple: #5d3fd3;
                --primary-hover: #4a32a8;
                --text-main: #111827;
                --text-secondary: #6b7280;
                --bg-color: #f8f9fa;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-main);
            }

            /* --- Navbar (Same as Home) --- */
            .navbar-custom { background-color: white; border-bottom: 1px solid #e5e7eb; padding: 0.8rem 2.5rem; z-index: 1020; }
            .brand-logo-nav { font-size: 1.3rem; font-weight: 700; color: var(--primary-purple) !important; }
            .nav-link-custom { color: var(--text-secondary) !important; font-weight: 500; margin-right: 15px; }
            .nav-link-custom:hover, .nav-link-custom.active { color: var(--primary-purple) !important; }
            .search-input { border-radius: 20px; background-color: #f3f4f6; border: none; padding-left: 40px; width: 300px; }
            .search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); z-index: 5; pointer-events: none; }
            .img-avt { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary-purple); }
            .avatar-dropdown-toggle { border: none; background: none; padding: 0; }

            /* --- PREMIUM DROPDOWN STYLES (Copied from Home) --- */
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

            /* --- My Courses Specific Styles --- */
            .page-header {
                background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
                padding: 60px 0 80px;
                color: white;
                margin-bottom: -40px;
            }
            .header-title { font-weight: 800; font-size: 2rem; }
            .header-subtitle { opacity: 0.8; font-weight: 300; }

            .course-grid {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                margin-top: 85px;
            }

            .my-course-card {
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 12px;
                overflow: hidden;
                transition: transform 0.2s, box-shadow 0.2s;
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            .my-course-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            }
            .card-img-top {
                height: 160px;
                object-fit: cover;
            }
            .card-body {
                padding: 20px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }
            .course-category {
                font-size: 0.75rem;
                font-weight: 700;
                color: var(--primary-purple);
                text-transform: uppercase;
                margin-bottom: 8px;
            }
            
            .course-code{
                font-size: 0.8rem;
                font-weight: 700;
                margin-bottom: 10px;
                line-height: 1.2;
                color: var(--text-main);
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            .course-title {
                font-size: 1.1rem;
                font-weight: 700;
                margin-bottom: 15px;
                line-height: 1.4;
                color: var(--text-main);
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            /* Progress Bar Styling */
            .progress-label {
                display: flex;
                justify-content: space-between;
                font-size: 0.85rem;
                color: var(--text-secondary);
                margin-bottom: 5px;
            }
            .progress {
                height: 8px;
                border-radius: 4px;
                background-color: #f3f4f6;
                margin-bottom: 20px;
            }
            .progress-bar {
                background-color: var(--primary-purple);
                border-radius: 4px;
            }

            .btn-continue {
                margin-top: auto;
                background-color: white;
                color: var(--primary-purple);
                border: 1px solid var(--primary-purple);
                width: 100%;
                padding: 10px;
                border-radius: 8px;
                font-weight: 600;
                transition: 0.2s;
                text-decoration: none;
                text-align: center;
            }
            .btn-continue:hover {
                background-color: var(--primary-purple);
                color: white;
            }

            .empty-state {
                text-align: center;
                padding: 80px 20px;
                background: white;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
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

            String displayName = (user.getUsername() != null) ? user.getUsername() : "Student";
            String avatarUrl = (user.getUserAvt() != null) ? user.getUserAvt() : "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";

            List<Course> myCourses = (List<Course>) request.getAttribute("myCourse");
            if (myCourses == null) {
                myCourses = new ArrayList<>(); 
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
                                <img class="img-avt" src="<%=avatarUrl%>" alt="User">
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                
                                <li>
                                    <div class="dropdown-user-info">
                                        <img src="<%=avatarUrl%>" alt="Avatar">
                                        <div class="dropdown-user-details">
                                            <h6><%= displayName%></h6>
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

        <div class="page-header">
            <div class="container">
                <h1 class="header-title">My Learning</h1>
                <p class="header-subtitle">Pick up where you left off.</p>
            </div>
        </div>

        <div class="course-grid">
            <% if (myCourses.isEmpty()) { %>
                <div class="empty-state shadow-sm mt-5">
                    <div style="font-size: 4rem; color: #e5e7eb; margin-bottom: 20px;">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <h3>You haven't enrolled in any courses yet.</h3>
                    <p class="text-muted mb-4">Explore our catalog to find your next skill.</p>
                    <a href="courses" class="btn btn-primary rounded-pill px-4" style="background-color: var(--primary-purple); border:none;">Browse Courses</a>
                </div>
            <% } else { %>
                <div class="row g-4 mt-4 mb-5">
                    <% for (Course c : myCourses) { 
                        int progress = (int)(Math.random() * 100);
                    %>
                    <div class="col-md-4 col-lg-3">
                        <div class="my-course-card">
                            <img src="<%= c.getImg_url() %>" class="card-img-top" alt="<%= c.getTitle() %>">
                            <div class="card-body">
                                <div class="course-category"><%= c.getCategory() %></div>
                                <h6 class="course-code"><%= c.getCourseCode()%></h6>
                                <h5 class="course-title"><%= c.getTitle() %></h5>
                                
                                <div>
                                    <div class="progress-label">
                                        <span>Progress</span>
                                        <span><%= progress %>%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: <%= progress %>%"></div>
                                    </div>
                                </div>

                                <a href="learning.jsp?courseCode=<%= c.getCourseCode() %>" class="btn-continue">
                                    <% if (progress == 0) { %> Start Course <% } else { %> Continue <% } %>
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>