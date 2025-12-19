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
        <title>Course Details - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            /* --- GLOBAL VARIABLES --- */
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

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-main);
                overflow-x: hidden;
            }

            /* --- NAVBAR STYLES --- */
            .navbar-custom {
                background-color: white;
                border-bottom: 1px solid #e5e7eb;
                padding: 0.8rem 2.5rem;
                z-index: 1020;
            }
            .brand-logo-nav {
                font-size: 1.3rem;
                font-weight: 700;
                color: var(--primary-purple) !important;
                text-decoration: none;
            }
            .nav-link-custom {
                color: var(--text-secondary) !important;
                font-weight: 500;
                margin-right: 15px;
                text-decoration: none;
            }
            .nav-link-custom:hover, .nav-link-custom.active {
                color: var(--primary-purple) !important;
            }
            .search-input {
                border-radius: 20px;
                background-color: #f3f4f6;
                border: none;
                padding-left: 40px;
                width: 300px;
            }
            .search-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-secondary);
                z-index: 5;
                pointer-events: none;
            }
            .img-avt {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid var(--primary-purple);
            }
            .avatar-dropdown-toggle {
                border: none;
                background: none;
                padding: 0;
            }

            /* Dropdown Styles */
            .dropdown-menu {
                border: none;
                border-radius: 12px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.1);
                padding: 10px;
                min-width: 260px;
                margin-top: 10px !important;
            }
            .dropdown-user-info {
                display: flex;
                align-items: center;
                padding: 12px;
                margin-bottom: 10px;
                background-color: #f9fafb;
                border-radius: 10px;
                border: 1px solid #f3f4f6;
            }
            .dropdown-user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 12px;
                border: 2px solid var(--primary-purple);
            }
            .dropdown-user-details h6 {
                margin: 0;
                font-size: 0.95rem;
                font-weight: 700;
                color: var(--text-main);
            }
            .dropdown-user-details span {
                font-size: 0.8rem;
                color: var(--text-secondary);
            }
            .dropdown-item {
                padding: 10px 15px;
                font-size: 0.95rem;
                color: #4b5563;
                font-weight: 500;
                border-radius: 8px;
                margin-bottom: 4px;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
            }
            .dropdown-item i {
                width: 25px;
                font-size: 1rem;
                color: #9ca3af;
                transition: color 0.2s;
            }
            .dropdown-item:hover {
                background-color: #f5f3ff;
                color: var(--primary-purple);
                transform: translateX(4px);
            }
            .dropdown-item:hover i {
                color: var(--primary-purple);
            }
            .dropdown-divider {
                margin: 8px 0;
                border-color: #f3f4f6;
            }

            /* --- HERO SECTION --- */
            .course-hero {
                background-color: #1e1b4b;
                color: white;
                padding: 60px 0 80px;
                position: relative;
            }
            .hero-content {
                max-width: 800px;
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-text {
                opacity: 0;
                animation: fadeInUp 0.8s ease-out forwards;
            }
            .delay-1 {
                animation-delay: 0.2s;
            }
            .delay-2 {
                animation-delay: 0.4s;
            }

            .course-title {
                font-size: 2.2rem;
                font-weight: 800;
                margin-bottom: 15px;
                line-height: 1.2;
            }
            .course-subtitle {
                font-size: 1.1rem;
                opacity: 0.9;
                margin-bottom: 20px;
                line-height: 1.6;
            }
            .rating-row {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
                font-size: 0.9rem;
            }
            .stars {
                color: #fbbf24;
            }
            .instructor-name {
                color: #818cf8;
                text-decoration: underline;
                cursor: pointer;
            }

            /* --- LAYOUT GRID --- */
            .main-content-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                position: relative;
                top: -40px; /* Overlap hero */
            }

            /* --- SIDEBAR CARD (STICKY) --- */
            .sidebar-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                border: 1px solid #e5e7eb;
                overflow: hidden;
                position: sticky;
                top: 90px;
                z-index: 100;
            }
            .preview-video {
                position: relative;
                height: 200px;
                background: #000;
                cursor: pointer;
            }
            .preview-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                opacity: 0.8;
            }
            .play-overlay {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 60px;
                height: 60px;
                background: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 0 20px rgba(0,0,0,0.2);
                transition: transform 0.2s;
            }
            .play-overlay i {
                color: var(--text-main);
                font-size: 24px;
                margin-left: 4px;
            }
            .sidebar-card:hover .play-overlay {
                transform: translate(-50%, -50%) scale(1.1);
            }

            .sidebar-body {
                padding: 24px;
            }
            .price-large {
                font-size: 1.8rem;
                font-weight: 800;
                color: var(--text-main);
                margin-bottom: 5px;
            }
            .btn-action {
                width: 100%;
                padding: 12px;
                font-weight: 700;
                border-radius: 8px;
                border: none;
                font-size: 1rem;
                margin-bottom: 10px;
                transition: 0.2s;
                display: block;
                text-align: center;
                text-decoration: none;
            }
            .btn-buy {
                background: var(--primary-purple);
                color: white;
            }
            .btn-buy:hover {
                background: var(--primary-hover);
                color: white;
            }
            .btn-cart {
                background: white;
                border: 1px solid var(--text-main);
                color: var(--text-main);
            }
            .btn-cart:hover {
                background: #f3f4f6;
            }

            .course-features {
                list-style: none;
                padding: 0;
                margin-top: 20px;
            }
            .course-features li {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 10px;
                font-size: 0.9rem;
                color: var(--text-secondary);
            }
            .course-features i {
                width: 20px;
                text-align: center;
            }

            /* --- MAIN CONTENT --- */
            .content-box {
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 12px;
                padding: 30px;
                margin-bottom: 30px;
            }
            .box-title {
                font-size: 1.4rem;
                font-weight: 700;
                margin-bottom: 20px;
                color: var(--text-main);
            }

            .learn-list {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            .learn-item {
                display: flex;
                gap: 10px;
                font-size: 0.95rem;
                color: var(--text-main);
            }
            .learn-item i {
                color: var(--text-main);
                margin-top: 4px;
            }

            /* Accordion */
            .accordion-item {
                border: 1px solid #e5e7eb;
                margin-bottom: 10px;
                border-radius: 8px !important;
                overflow: hidden;
            }
            .accordion-button {
                background-color: #f9fafb;
                color: var(--text-main);
                font-weight: 600;
                box-shadow: none !important;
            }
            .accordion-button:not(.collapsed) {
                background-color: #f0f0ff;
                color: var(--primary-purple);
            }
            .lesson-item {
                display: flex;
                justify-content: space-between;
                padding: 12px 20px;
                border-bottom: 1px solid #f3f4f6;
                font-size: 0.95rem;
                cursor: pointer;
                transition: background 0.2s;
            }
            .lesson-item:hover {
                background-color: #f9fafb;
            }
            .lesson-item:last-child {
                border-bottom: none;
            }
            .lesson-icon {
                margin-right: 10px;
                color: var(--text-secondary);
            }

            /* Instructor */
            .instructor-card {
                display: flex;
                gap: 20px;
            }
            .instructor-avt {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
            }
            .instructor-info h4 {
                font-weight: 700;
                font-size: 1.2rem;
                margin-bottom: 4px;
                color: #dc2626;
            }
            .instructor-bio {
                font-size: 0.9rem;
                color: var(--text-secondary);
                line-height: 1.5;
                margin-top: 10px;
            }

            /* Reviews */
            .review-item {
                padding: 20px 0;
                border-bottom: 1px solid #e5e7eb;
            }
            .review-header {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 10px;
            }
            .review-avt {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #111827;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
            }
            .review-user h6 {
                margin: 0;
                font-size: 0.95rem;
                font-weight: 700;
            }
            .review-user .stars {
                font-size: 0.8rem;
            }
            .review-date {
                font-size: 0.8rem;
                color: var(--text-secondary);
                margin-left: auto;
            }

            .review-form textarea {
                width: 100%;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                resize: vertical;
            }
            .btn-submit {
                background: var(--primary-purple);
                color: white;
                border: none;
                padding: 8px 24px;
                border-radius: 8px;
                font-weight: 600;
                float: right;
            }

            @media (max-width: 992px) {
                .main-content-wrapper {
                    flex-direction: column;
                    top: 0;
                    margin-top: 20px;
                }
                .sidebar-card {
                    position: static;
                    margin-bottom: 30px;
                }
                .course-hero {
                    padding: 40px 0;
                }
                .learn-list {
                    grid-template-columns: 1fr;
                }
            }

            .btn-login {
                color: var(--primary-purple);
                border: 1px solid var(--primary-purple);
                border-radius: 20px;
                padding: 5px 20px;
                text-decoration: none;
                font-weight: 600;
                transition: 0.2s;
            }

            .btn-signup {
                background-color: var(--primary-purple);
                color: white;
                border-radius: 20px;
                padding: 6px 20px;
                text-decoration: none;
                font-weight: 600;
                margin-left: 10px;
                transition: 0.2s;
            }
        </style>
    </head>
    <body>

        <%
            // 1. Kiểm tra session User
            User user = (User) session.getAttribute("user");
            boolean isLoggedIn = (user != null);
            String displayName = "Guest";
            String avatarUrl = "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";
            if (isLoggedIn) {
                if (user.getUsername() != null) {
                    displayName = user.getUsername();
                }
                if (user.getUserAvt() != null) {
                    avatarUrl = user.getUserAvt();
                }
            }

            Course c = (Course) request.getAttribute("course");

            List<Course> myCourses = (List<Course>) session.getAttribute("myCourse");
            boolean isEnrolled = false;
            if (myCourses != null) {
                for (Course mc : myCourses) {
                    if (mc.getCourseCode() != null && mc.getCourseCode().equals(c.getCourseCode())) {
                        isEnrolled = true;
                        break;
                    }
                }
            }

            List<Course> cartItems = (List<Course>) session.getAttribute("cart");
            int cartCount = (cartItems != null) ? cartItems.size() : 0;
            boolean isInCart = false;
            if (cartItems != null) {
                for (Course cartC : cartItems) {
                    if (cartC.getCourseCode().equals(c.getCourseCode())) {
                        isInCart = true;
                    }
                }
            }
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
                        <li class="nav-item"><a class="nav-link nav-link-custom active" href="courses">Courses</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="community.jsp">Community</a></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <div class="position-relative me-4">
                            <i class="fas fa-search search-icon"></i>
                            <form action="courses" method="get">
                                <input class="form-control search-input" type="search" name="search" placeholder="Search courses...">
                            </form>
                        </div>

                        <% if (isLoggedIn) { %>
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
                            <button class="avatar-dropdown-toggle" data-bs-toggle="dropdown">
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
                        <% } else { %>
                        <a href="login.jsp" class="btn-login">Login</a>
                        <a href="register.jsp" class="btn-signup">Sign Up</a>
                        <% }%>
                    </div>
                </div>
            </div>
        </nav>

        <section class="course-hero">
            <div class="container">
                <div class="hero-content">
                    <h1 class="course-title animate-text"><%= c.getTitle()%></h1>
                    <p class="course-subtitle animate-text delay-1">
                        <%= c.getDescription()%>
                    </p>

                    <div class="rating-row animate-text delay-2">
                        <span class="badge bg-warning text-dark me-2">Best Seller</span>
                        <span class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i></span>
                        <span style="color:#fbbf24; font-weight:700;">4.5</span>
                        <span class="mx-2">(120 ratings)</span>
                        <span>Created by <span class="instructor-name">Nguyen Anh Khoa</span></span>
                    </div>

                    <div class="animate-text delay-2">
                        <i class="fas fa-globe me-1"></i> Vietnamese
                        <span class="mx-2">|</span>
                        <i class="fas fa-closed-captioning me-1"></i> English [Auto]
                    </div>
                </div>
            </div>
        </section>

        <div class="main-content-wrapper">
            <div class="row">
                <div class="col-lg-8">

                    <div class="content-box mt-4">
                        <h3 class="box-title">What you'll learn</h3>
                        <div class="learn-list">
                            <div class="learn-item"><i class="fas fa-check"></i> <span>Practice Java OOP</span></div>
                            <div class="learn-item"><i class="fas fa-check"></i> <span>Inheritance - String</span></div>
                            <div class="learn-item"><i class="fas fa-check"></i> <span>Deep dive into Override - Overload</span></div>
                            <div class="learn-item"><i class="fas fa-check"></i> <span>Abstraction (abstract - interface)</span></div>
                            <div class="learn-item"><i class="fas fa-check"></i> <span>Practice File I/O operations</span></div>
                        </div>
                    </div>

                    <div class="content-box">
                        <h3 class="box-title">Course Curriculum</h3>
                        <div class="accordion" id="curriculumAccordion">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                        Part 1: Java OOP Review
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#curriculumAccordion">
                                    <div class="accordion-body p-0">
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Introduction - Practice OOP via Zoom <span class="ms-auto text-muted">05:20</span></div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 1 - LAB211 Intro - What is Class? <span class="ms-auto text-muted">15:10</span></div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 2 - Initializing Objects from Class <span class="ms-auto text-muted">20:05</span></div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 3 - Inheritance in OOP <span class="ms-auto text-muted">18:30</span></div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-file-alt"></i></span> MVC Model Documentation</div>
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour">
                                        Part 4: Zoom Class FA25
                                    </button>
                                </h2>
                                <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#curriculumAccordion">
                                    <div class="accordion-body p-0">
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-file-alt"></i></span> Link - Messenger Group for Zoom</div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 1 - OOP Review - MVC and CRUD Flow</div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 3 - Regex and Validation Rules</div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-play-circle"></i></span> Session 5 - Inputter Practice - Report by AI</div>
                                        <div class="lesson-item"><span class="lesson-icon"><i class="fas fa-code"></i></span> Source code for LAB211 exercises</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="content-box">
                        <h3 class="box-title">Instructor</h3>
                        <div class="instructor-card">
                            <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200" alt="Instructor" class="instructor-avt">
                            <div class="instructor-info">
                                <h4>Nguyen Anh Khoa</h4>
                                <div style="color:#6b7280; font-size:0.9rem;">Technical Team Leader</div>
                                <div class="instructor-bio">
                                    Hello everyone, I'm Mentor Anh Khoa, also the founder of FTES. I'm very excited to accompany you on the journey ahead!
                                    <br><br>
                                    <i class="fas fa-users me-1"></i> Member: 2136
                                    <br>
                                    <i class="fas fa-link me-1"></i> <a href="#" style="color:#4f46e5;">https://facebook.com/khoaak71.vip</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="content-box">
                        <h3 class="box-title"><i class="fas fa-star text-warning"></i> 4.3 Course Rating • 3 Reviews</h3>

                        <% if (isLoggedIn) { %>
                        <div class="review-form mb-5">
                            <h6>Review this course</h6>
                            <div class="mb-3 text-warning">
                                <i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </div>
                            <form>
                                <textarea placeholder="Share your experience..."></textarea>
                                <button type="button" class="btn-submit">Submit Review</button>
                            </form>
                        </div>
                        <% } %>

                        <div class="review-list">
                            <div class="review-item">
                                <div class="review-header">
                                    <div class="review-avt">TH</div>
                                    <div class="review-user">
                                        <h6>thanhtuan3011</h6>
                                        <div class="stars text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i></div>
                                    </div>
                                    <div class="review-date">20:48 24/09/2025</div>
                                </div>
                                <p class="text-secondary">good</p>
                            </div>

                            <div class="review-item">
                                <div class="review-header">
                                    <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100" class="review-avt" style="object-fit:cover;">
                                    <div class="review-user">
                                        <h6>lenguyenquockhanh57</h6>
                                        <div class="stars text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                                    </div>
                                    <div class="review-date">07:15 22/09/2025</div>
                                </div>
                                <p class="text-secondary">Mentor Anh Khoa teaches very understandably, focusing on the core mindset. One concept applies to many exercises. Really like his teaching style.</p>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-lg-4">
                    <div class="sidebar-card">
                        <div class="preview-video">
                            <img src="https://images.unsplash.com/photo-1587620962725-abab7fe55159?w=500" class="preview-img" alt="Course Preview">
                            <div class="play-overlay"><i class="fas fa-play"></i></div>
                        </div>
                        <div class="sidebar-body">
                            <% if (isEnrolled) {%>
                            <div class="alert alert-success text-center fw-bold">
                                <i class="fas fa-check-circle"></i> You have joined this course
                            </div>
                            <a href="learning.jsp?courseCode=<%= c.getCourseCode()%>" class="btn-action btn-buy">Start Learning Now</a>
                            <% } else {%>
                            <div class="price-large"><%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ</div>

                            <% if (isInCart) { %>
                            <a href="cart.jsp" class="btn-action btn-buy">Go to Cart</a>
                            <% } else {%>
                            <a href="addToCart?id=<%= c.getId()%>" class="btn-action btn-buy">Buy Now</a>
                            <a href="addToCart?id=<%= c.getId()%>" class="btn-action btn-cart">Add to Cart</a>
                            <% } %>

                            <div style="text-align:center; font-size:0.8rem; margin-top:10px;">30-Day Money-Back Guarantee</div>
                            <% }%>

                            <h6 style="margin-top: 20px; font-weight: 700;">This course includes:</h6>
                            <ul class="course-features">
                                <li><i class="fas fa-video"></i> High-quality roadmap commitment</li>
                                <li><i class="fas fa-file-code"></i> Detailed modules with daily exercises</li>
                                <li><i class="fas fa-users"></i> 24/7 Q&A Support Group</li>
                                <li><i class="fas fa-infinity"></i> Comprehensive documents</li>
                                <li><i class="fas fa-mobile-alt"></i> Access on mobile and TV</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>