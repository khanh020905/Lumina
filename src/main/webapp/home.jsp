<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            /* --- Global Styles --- */
            :root {
                --primary-purple: #5d3fd3;
                --primary-dark: #1e1b4b;
                --text-dark: #111827;
                --text-muted: #6b7280;
                --bg-light: #f8f9fa;
                --card-hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }

            html {
                scroll-behavior: smooth;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-light);
                overflow-x: hidden;
                padding-top: 0 !important; /* Critical for full screen hero */
            }

            /* =========================================
               1. NAVBAR BEHAVIOR (From Career Page)
               ========================================= */
            .navbar {
                position: fixed !important;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1050;

                /* Start HIDDEN: Move it up exactly 100% of its own height */
                transform: translateY(-100%);

                /* Smooth slide animation */
                transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);

                /* Visual Design */
                background-color: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 20px rgba(0,0,0,0.08) !important;
                padding-top: 10px !important;
                padding-bottom: 10px !important;
            }

            /* This class is added via JS when scrolling down */
            .navbar.visible {
                transform: translateY(0);
            }

            /* =========================================
               2. FULL SCREEN HERO (From Career Page)
               ========================================= */
            .landing-hero {
                height: 100vh; /* Occupies full screen height */
                width: 100%;
                background: radial-gradient(circle at center, #4c1d95 0%, #0f172a 70%, #000000 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                position: relative;
                z-index: 2000;
                color: white;
                text-align: center;
                padding: 20px;
                overflow: hidden;
            }

            /* Ambient Glow */
            .landing-hero::before {
                content: '';
                position: absolute;
                top: -100px;
                left: 50%;
                transform: translateX(-50%);
                width: 800px;
                height: 400px;
                background: radial-gradient(circle, rgba(99, 102, 241, 0.2) 0%, transparent 70%);
                filter: blur(50px);
                pointer-events: none;
            }

            .landing-content {
                z-index: 2;
                animation: fadeUp 1.2s ease-out;
            }

            .landing-title {
                font-family: 'Inter', serif;
                font-size: 4rem;
                font-weight: 800;
                margin-bottom: 20px;
                background: linear-gradient(to right, #fff, #a5b4fc);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                letter-spacing: -2px;
                line-height: 1.1;
            }

            .landing-subtitle {
                font-size: 1.5rem;
                color: #cbd5e1;
                font-weight: 300;
                max-width: 600px;
                margin: 0 auto;
            }

            /* Scroll Indicator */
            .scroll-indicator {
                position: absolute;
                bottom: 40px;
                left: 50%;
                transform: translateX(-50%);
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                opacity: 0.7;
                transition: opacity 0.3s;
                z-index: 10;
            }

            .scroll-indicator:hover {
                opacity: 1;
            }

            .scroll-indicator span {
                font-size: 0.85rem;
                letter-spacing: 2px;
                text-transform: uppercase;
            }

            .scroll-arrow {
                font-size: 1.5rem;
                animation: bounce 2s infinite;
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
                40% { transform: translateY(-10px); }
                60% { transform: translateY(-5px); }
            }

            @keyframes fadeUp {
                from { opacity: 0; transform: translateY(30px); }
                to { opacity: 1; transform: translateY(0); }
            }

            @media (max-width: 768px) {
                .landing-title { font-size: 2.5rem; }
                .landing-subtitle { font-size: 1.1rem; }
            }

            /* =========================================
               3. MAIN CONTENT STYLES
               ========================================= */
            .main-content-wrapper {
                position: relative;
                z-index: 1;
                background-color: var(--bg-light);
            }

            .section-scroll-anchor {
                scroll-margin-top: 140px;
            }

            /* Hero Carousel */
            .hero-carousel-container {
                max-width: 1200px;
                margin: 40px auto 20px auto;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                position: relative;
            }
            .carousel-item {
                height: 380px;
                background-size: cover;
                background-position: center;
                position: relative;
                transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
            }
            .slide-inner-layout {
                display: flex;
                align-items: center;
                height: 100%;
                width: 100%;
                padding: 0 60px;
            }
            .slide-microchip {
                background: linear-gradient(105deg, #4338ca 0%, #3b82f6 100%);
            }
            .slide-content {
                color: white;
                max-width: 50%;
                z-index: 2;
            }
            .slide-badge {
                background-color: rgba(255,255,255,0.2);
                color: white;
                padding: 5px 12px;
                border-radius: 6px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
                margin-bottom: 15px;
            }
            .slide-title {
                font-size: 2.5rem;
                font-weight: 800;
                line-height: 1.1;
                margin-bottom: 15px;
            }
            .slide-desc {
                font-size: 1.1rem;
                opacity: 0.9;
                margin-bottom: 25px;
            }
            .btn-slide-cta {
                background-color: white;
                color: #4338ca;
                padding: 10px 25px;
                border-radius: 30px;
                font-weight: 700;
                text-decoration: none;
                display: inline-block;
                transition: transform 0.2s;
            }
            .btn-slide-cta:hover {
                transform: translateY(-2px);
                color: #4338ca;
            }
            .slide-image-container {
                position: absolute;
                right: 60px;
                top: 50%;
                transform: translateY(-50%);
                width: 300px;
                background: rgba(255,255,255,0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255,255,255,0.2);
                border-radius: 15px;
                padding: 30px;
                text-align: center;
                color: white;
            }
            .carousel-control-prev, .carousel-control-next {
                width: 5%;
                opacity: 0.7;
                z-index: 5;
            }
            .carousel-control-prev:hover, .carousel-control-next:hover {
                opacity: 1;
            }
            .carousel-indicators {
                bottom: 20px;
            }
            .carousel-indicators button {
                width: 10px !important;
                height: 10px !important;
                border-radius: 50% !important;
                background-color: rgba(255, 255, 255, 0.4) !important;
                border: none !important;
                margin: 0 8px !important;
                transition: all 0.3s ease;
                opacity: 1 !important;
                padding: 0;
            }
            .carousel-indicators button.active {
                background-color: white !important;
                transform: scale(1.1);
            }

            /* Categories */
            .categories-wrapper {
                max-width: 1200px;
                margin: 0 auto 40px auto;
                padding: 15px 15px;
                position: sticky;
                top: 75px;
                z-index: 1000;
                background-color: rgba(248, 249, 250, 0.95);
                backdrop-filter: blur(8px);
                border-bottom: 1px solid rgba(0,0,0,0.05);
                border-radius: 0 0 15px 15px;
                display: flex;
                align-items: center;
            }
            .category-scroll-container {
                display: flex;
                overflow-x: auto;
                gap: 15px;
                padding: 5px 5px;
                scrollbar-width: none;
                -ms-overflow-style: none;
                scroll-behavior: smooth;
                width: 100%;
                white-space: nowrap;
                    margin-top: 20px;
            }
            .category-scroll-container::-webkit-scrollbar { display: none; }
            .category-pill {
                white-space: nowrap;
                padding: 10px 25px;
                border-radius: 50px;
                background: white;
                border: 1px solid #e5e7eb;
                color: var(--text-dark);
                font-weight: 600;
                font-size: 0.95rem;
                transition: all 0.2s ease;
                cursor: pointer;
                box-shadow: 0 2px 4px rgba(0,0,0,0.03);
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .category-pill:hover, .category-pill.active {
                background-color: var(--primary-purple);
                color: white;
                border-color: var(--primary-purple);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(93, 63, 211, 0.3);
            }

            /* Scrolling Lists & Cards */
            .floating-arrow {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: white;
                border: 1px solid #e5e7eb;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                z-index: 20;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.2s ease;
                color: var(--text-dark);
                opacity: 0.9;
            }
            .floating-arrow:hover {
                background-color: #fff;
                transform: translateY(-50%) scale(1.1);
                color: var(--primary-purple);
                box-shadow: 0 6px 16px rgba(0,0,0,0.2);
                opacity: 1;
            }
            .floating-arrow.left { left: -22px; }
            .floating-arrow.right { right: -22px; }
            
            .section-container {
                max-width: 1200px;
                margin: 50px auto;
                padding: 0 15px;
                position: relative;
            }
            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
                margin-bottom: 20px;
            }
            .section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--text-dark);
                margin: 0;
            }
            .section-subtitle {
                color: var(--text-muted);
                font-size: 0.95rem;
                margin-top: 5px;
            }
            .see-all-link {
                color: var(--primary-purple);
                text-decoration: none;
                font-weight: 600;
                font-size: 0.9rem;
            }
            .scrolling-wrapper {
                display: flex;
                overflow-x: auto;
                gap: 20px;
                padding-bottom: 20px;
                scrollbar-width: none;
                -ms-overflow-style: none;
                scroll-behavior: smooth;
            }
            .scrolling-wrapper::-webkit-scrollbar { display: none; }
            .card-item { flex: 0 0 auto; width: 280px; }

            .course-card {
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 12px;
                overflow: hidden;
                transition: all 0.3s ease;
                height: 100%;
                position: relative;
                cursor: pointer;
                display: flex;
                flex-direction: column;
            }
            .course-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--card-hover-shadow);
            }
            .course-img { width: 100%; height: 160px; object-fit: cover; }
            .course-badge {
                position: absolute; top: 12px; left: 12px;
                color: white; padding: 4px 8px; border-radius: 4px;
                font-size: 0.75rem; font-weight: 700; text-transform: uppercase;
                background-color: #6366f1;
            }
            .course-body { padding: 16px; flex-grow: 1; display: flex; flex-direction: column; }
            .course-title {
                font-size: 1rem; font-weight: 700; color: var(--text-dark); margin-bottom: 8px;
                display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
                overflow: hidden; height: 48px;
            }
            .course-rating { color: #fbbf24; font-size: 0.85rem; margin-bottom: 12px; }
            .rating-count { color: var(--text-muted); margin-left: 5px; }
            .course-footer { display: flex; justify-content: space-between; align-items: center; margin-top: auto; }
            .price-tag { font-weight: 700; color: var(--primary-purple); font-size: 1.1rem; }
            .price-free { color: #10b981; }
            .original-price {
                text-decoration: line-through; color: #9ca3af; font-size: 0.85rem;
                margin-bottom: 2px; display: block;
            }
            .btn-cart-icon {
                width: 35px; height: 35px; border-radius: 8px;
                background-color: #f3f4f6; color: var(--primary-purple); border: none;
                display: flex; align-items: center; justify-content: center;
                transition: 0.2s; text-decoration: none;
            }
            .btn-cart-icon:hover { background-color: var(--primary-purple); color: white; }
            .btn-enrolled {
                height: 35px; padding: 0 15px; border-radius: 8px;
                background-color: #d1fae5; color: #065f46;
                font-weight: 700; font-size: 0.85rem; border: none;
                display: flex; align-items: center; justify-content: center;
                text-decoration: none; pointer-events: none;
            }

            /* Mentors, Faculty, Toasts */
            .mentor-section { background-color: var(--primary-dark); padding: 60px 0; color: white; margin-top: 60px; }
            .mentor-header { text-align: center; margin-bottom: 40px; }
            .mentor-title { font-size: 2rem; font-weight: 700; margin-bottom: 10px; }
            .mentor-subtitle { opacity: 0.8; max-width: 600px; margin: 0 auto; }
            .mentor-card { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; padding: 30px; height: 100%; }
            .quote-icon { font-size: 2rem; color: #818cf8; margin-bottom: 20px; opacity: 0.5; }
            .quote-text { font-style: italic; font-size: 1rem; line-height: 1.6; margin-bottom: 30px; opacity: 0.9; min-height: 80px; }
            .mentor-profile { display: flex; align-items: center; gap: 15px; }
            .mentor-img { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; }
            .mentor-info h6 { margin: 0; font-weight: 700; }
            .mentor-info span { font-size: 0.85rem; opacity: 0.7; }
            .arrow-btn { width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-dark); cursor: pointer; margin-left: auto; }

            .toast-container { z-index: 1090 !important; position: fixed; top: 80px; right: 20px; }
            .faculty-section { background-color: #f8f9fa; margin-top: 60px; margin-bottom: 40px;}
            .faculty-card {
                width: 95%; max-width: 1300px; height: 400px; margin: 0 auto; margin-bottom: 30px;
                background: radial-gradient(circle at top right, #1e1b4b 0%, #0f172a 100%);
                border-radius: 24px; padding: 50px 40px; text-align: center; color: white;
                position: relative; overflow: hidden; box-shadow: 0 20px 40px -10px rgba(15, 23, 42, 0.3);
            }
            .faculty-card::after {
                content: ''; position: absolute; bottom: -50%; right: -10%; width: 600px; height: 500px;
                background: radial-gradient(circle, rgba(79, 70, 229, 0.15) 0%, transparent 70%);
                border-radius: 50%; pointer-events: none;
            }
            .icon-wrapper {
                margin-top: 12px; width: 56px; height: 56px;
                background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 14px; display: inline-flex; align-items: center; justify-content: center;
                margin-bottom: 16px; backdrop-filter: blur(8px);
            }
            .icon-wrapper i { font-size: 22px; color: #a5b4fc; }
            .faculty-title {
                font-family: 'Inter', serif; font-size: 2.2rem; font-weight: 700; margin-bottom: 12px;
                background: linear-gradient(to right, #ffffff, #e2e8f0);
                -webkit-background-clip: text; -webkit-text-fill-color: transparent; letter-spacing: -0.02em;
            }
            .faculty-desc { font-size: 1.05rem; color: #94a3b8; max-width: 700px; margin: 0 auto 30px auto; line-height: 1.5; }
            .btn-faculty {
                background-color: white; color: #0f172a; padding: 14px 30px; border-radius: 12px; font-weight: 600;
                text-decoration: none; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); display: inline-flex;
                align-items: center; gap: 8px; border: 1px solid transparent;
            }
            .btn-faculty:hover { background-color: #f1f5f9; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }

            /* --- LEARNING PATH BANNER (New) --- */
            .learning-path-banner {
                /* Matches your dark branding */
                background: linear-gradient(135deg, #020617 0%, #1e1b4b 100%);
                border-radius: 24px;
                margin: 40px auto 40px auto; /* Spacing above/below */
                padding: 60px 40px;
                text-align: center;
                color: white;
                max-width: 1200px;
                position: relative;
                overflow: hidden;
                /* Subtle border and shadow for depth */
                border: 1px solid rgba(255, 255, 255, 0.08);
                box-shadow: 0 20px 40px -10px rgba(15, 23, 42, 0.4);
            }

            /* Decorative Glow Effect */
            .learning-path-banner::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(99, 102, 241, 0.15) 0%, transparent 70%);
                filter: blur(40px);
                pointer-events: none;
            }

            .path-content {
                position: relative;
                z-index: 2;
            }

            .path-title {
                font-size: 2rem;
                font-weight: 800;
                margin-bottom: 15px;
                /* Gradient Text for premium look */
                background: linear-gradient(to right, #ffffff, #e0e7ff);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                letter-spacing: -0.02em;
            }

            .path-desc {
                color: #94a3b8; /* Muted blue-grey */
                font-size: 1.1rem;
                margin-bottom: 30px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .btn-path-cta {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                padding: 14px 35px;
                border-radius: 50px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;

                /* Outline Style exactly like your image */
                background: transparent;
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: white;
            }

            .btn-path-cta:hover {
                background: white;
                color: #0f172a; /* Dark text on hover */
                border-color: white;
                transform: translateY(-2px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }

            @media (max-width: 768px) {
                .learning-path-banner {
                    padding: 40px 20px;
                    margin: 20px 15px; /* Add side margin on mobile */
                    border-radius: 16px;
                }
                .path-title { font-size: 1.5rem; }
            }
        </style>
    </head>
    <body>

        <%
            // 1. Retrieve Data for Body Content
            List<Course> courseList = (List<Course>) request.getAttribute("courseList");
            if (courseList == null) {
                courseList = new ArrayList<>();
            }

            // 2. Retrieve Enrolled Courses (for checking status)
            List<Course> enrolledCourses = (List<Course>) session.getAttribute("myCourse");
            if (enrolledCourses == null)
                enrolledCourses = new ArrayList<>();
        %>

        <jsp:include page="nav-bar.jsp" />

        <div class="landing-hero">
            <div class="landing-content">
                <div style="font-size: 3rem; margin-bottom: 20px; color: #818cf8;">
                    <i class="fas fa-door-open"></i>
                </div>

                <h1 class="landing-title"><fmt:message key="home.hero.landing.title"/></h1>

                <p class="landing-subtitle">
                   <fmt:message key="home.hero.landing.desc"/>
                </p>
            </div>

            <div class="scroll-indicator" onclick="scrollToSite()">
                <span>Scroll to Explore</span>
                <i class="fas fa-chevron-down scroll-arrow"></i>
            </div>
        </div>

        <div id="main-site" class="main-content-wrapper">

            <div class="hero-carousel-container">
                <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active slide-microchip">
                            <div class="slide-inner-layout">
                                <div class="slide-content">
                                    <span class="slide-badge">NEW SEMESTER</span>
                                    <h2 class="slide-title"><fmt:message key="home.hero.title"/></h2>
                                    <p class="slide-desc"><fmt:message key="home.hero.desc"/></p>
                                    <a href="courses" class="btn-slide-cta">Explore Courses <i class="fas fa-arrow-right ms-2"></i></a>
                                </div>
                                <div class="slide-image-container">
                                    <div style="font-size: 3rem; margin-bottom: 10px;"><i class="far fa-clock"></i></div>
                                    <h4>Limited Time</h4>
                                    <p style="font-size: 0.9rem; margin:0;">Enroll before Oct 30</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item" style="background: linear-gradient(105deg, #10b981 0%, #059669 100%);">
                            <div class="slide-inner-layout">
                                <div class="slide-content" style="color:white;">
                                    <span class="slide-badge">FREE COURSES</span>
                                    <h2 class="slide-title">Start Your Tech Journey Today</h2>
                                    <p class="slide-desc">Access over 50+ free foundational courses in Web, Data, and Design.</p>
                                    <a href="#" class="btn-slide-cta" style="color:#059669; background:white;">Get Started</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
            <div class="learning-path-banner">
                <div class="path-content">
                    <h2 class="path-title">
                        Not sure where to start your journey?
                    </h2>
                    <p class="path-desc">
                        We'll help you create a personalized learning path optimized for your specific goals and career targets.
                    </p>
                    <a href="learning-path.jsp" class="btn-path-cta">
                        Create Free Path <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <div class="categories-wrapper">
                <div class="category-scroll-container" id="categoryContainer">
                    <a href="#" class="category-pill active"><i class="fas fa-th-large"></i>Courses</a>
                    <a href="#" class="category-pill"><i class="fas fa-bolt"></i> Dev Essentials (Free)</a>
                    <a href="#pro-dev" class="category-pill"><i class="fas fa-code"></i> Zero to Pro-Dev</a>
                    <a href="#math" class="category-pill"><i class="fas fa-square-root-alt"></i> Math & Logic</a>
                    <a href="#languages" class="category-pill"><i class="fas fa-language"></i> Languages</a>
                </div>
            </div>

            <div class="section-container section-scroll-anchor" id="pro-dev">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">From Zero to Pro-Dev</h3>
                        <p class="section-subtitle">Comprehensive paths to master web, software, and mobile development.</p>
                    </div>
                    <a href="courses" class="see-all-link">See all ></a>
                </div>
                <div class="floating-arrow left" onclick="scrollSection('proList', 'left')"><i class="fas fa-chevron-left"></i></div>
                <div class="floating-arrow right" onclick="scrollSection('proList', 'right')"><i class="fas fa-chevron-right"></i></div>
                <div id="proList" class="scrolling-wrapper">
                    <% for (Course c : courseList) {
                            String category = (c.getCategory() != null) ? c.getCategory() : "";
                            if (category.equalsIgnoreCase("Software Engineering")) {
                                boolean isEnrolled = false;
                                for (Course enrolled : enrolledCourses) {
                                    if (enrolled.getId() == c.getId()) {
                                        isEnrolled = true;
                                        break;
                                    }
                                }
                    %>
                    <div class="card-item">
                        <div onclick="window.location.href = 'course-details?id=<%= c.getId()%>'" class="course-card">
                            <img src="<%= c.getImg_url()%>" class="course-img" alt="<%= c.getTitle()%>">
                            <span class="course-badge badge-purple">SE</span>
                            <div class="course-body">
                                <h5 class="course-title"><%= c.getTitle()%></h5>
                                <div class="course-rating"><i class="fas fa-star"></i> 4.7 <span class="rating-count">(42)</span></div>
                                <div class="course-footer">
                                    <% if (isEnrolled) {%>
                                    <div style="flex-grow: 1;"></div>
                                    <a href="learning.jsp?id=<%= c.getId()%>" class="btn-enrolled"><i class="fas fa-check-circle me-1"></i> Enrolled</a>
                                    <% } else { %>
                                    <div>
                                        <% if (c.getPrice() > 0) {%>
                                        <span class="original-price"><%= String.format("%,.0f", c.getPrice() * 1.2).replace(',', '.') + ".000"%>đ</span>
                                        <span class="price-tag"><%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ</span>
                                        <% } else { %>
                                        <span class="price-tag price-free">Free</span>
                                        <% }%>
                                    </div>
                                    <a href="addToCart?id=<%= c.getId()%>" class="btn-cart-icon"><i class="fas fa-shopping-cart"></i></a>
                                        <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                        } %>
                </div>
            </div>

            <div class="section-container section-scroll-anchor" id="math">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">Mathematical Thinking for Developers</h3>
                        <p class="section-subtitle">Master the logic behind the code.</p>
                    </div>
                    <a href="courses" class="see-all-link">See all ></a>
                </div>
                <div class="floating-arrow left" onclick="scrollSection('mathList', 'left')"><i class="fas fa-chevron-left"></i></div>
                <div class="floating-arrow right" onclick="scrollSection('mathList', 'right')"><i class="fas fa-chevron-right"></i></div>
                <div id="mathList" class="scrolling-wrapper">
                    <% for (Course c : courseList) {
                            String category = (c.getCategory() != null) ? c.getCategory() : "";
                            if (category.equalsIgnoreCase("Math for SE")) {
                                boolean isEnrolled = false;
                                for (Course enrolled : enrolledCourses) {
                                    if (enrolled.getId() == c.getId()) {
                                        isEnrolled = true;
                                        break;
                                    }
                                }
                    %>
                    <div class="card-item">
                        <div class="course-card" onclick="window.location.href = 'course-details?id=<%= c.getId()%>'">
                            <img src="<%= c.getImg_url()%>" class="course-img" alt="<%= c.getTitle()%>">
                            <span class="course-badge badge-purple">MATH</span>
                            <div class="course-body">
                                <h5 class="course-title"><%= c.getTitle()%></h5>
                                <div class="course-rating"><i class="fas fa-star"></i> 4.5 <span class="rating-count">(89)</span></div>
                                <div class="course-footer">
                                    <% if (isEnrolled) {%>
                                    <div style="flex-grow: 1;"></div>
                                    <a href="learning.jsp?id=<%= c.getId()%>" class="btn-enrolled" onclick="event.stopPropagation()">
                                        <i class="fas fa-check-circle me-1"></i> Enrolled
                                    </a>
                                    <% } else { %>
                                    <div>
                                        <% if (c.getPrice() > 0) {%>
                                        <span class="original-price"><%= String.format("%,.0f", c.getPrice() * 1.2).replace(',', '.') + ".000"%>đ</span>
                                        <span class="price-tag"><%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ</span>
                                        <% } else { %>
                                        <span class="price-tag price-free">Free</span>
                                        <% }%>
                                    </div>
                                    <a href="addToCart?id=<%= c.getId()%>" class="btn-cart-icon" onclick="event.stopPropagation()">
                                        <i class="fas fa-shopping-cart"></i>
                                    </a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                        } %>
                </div>
            </div>

            <div class="section-container section-scroll-anchor" id="languages">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">Conquer New Languages</h3>
                        <p class="section-subtitle">Expand your global reach with language skills.</p>
                    </div>
                    <a href="courses" class="see-all-link">See all ></a>
                </div>
                <div class="floating-arrow left" onclick="scrollSection('langList', 'left')"><i class="fas fa-chevron-left"></i></div>
                <div class="floating-arrow right" onclick="scrollSection('langList', 'right')"><i class="fas fa-chevron-right"></i></div>
                <div id="langList" class="scrolling-wrapper">
                    <% for (Course c : courseList) {
                            String code = (c.getCourseCode() != null) ? c.getCourseCode() : "";
                            if (code.startsWith("JPD")) {
                                boolean isEnrolled = false;
                                for (Course enrolled : enrolledCourses) {
                                    if (enrolled.getId() == c.getId()) {
                                        isEnrolled = true;
                                        break;
                                    }
                                }
                    %>
                    <div class="card-item">
                        <div onclick="window.location.href = 'course-details?id=<%=c.getId()%>'" class="course-card">
                            <img src="<%= c.getImg_url()%>" class="course-img" alt="<%= c.getTitle()%>">
                            <span class="course-badge badge-purple">LANGUAGE</span>
                            <div class="course-body">
                                <h5 class="course-title"><%= c.getTitle()%></h5>
                                <div class="course-rating"><i class="fas fa-star"></i> 4.3 <span class="rating-count">(45)</span></div>
                                <div class="course-footer">
                                    <% if (isEnrolled) { %>
                                    <div style="flex-grow: 1;"></div>
                                    <a href="#" class="btn-enrolled"><i class="fas fa-check-circle me-1"></i> Enrolled</a>
                                    <% } else { %>
                                    <div>
                                        <% if (c.getPrice() > 0) {%>
                                        <span class="original-price"><%= String.format("%,.0f", c.getPrice() * 1.2).replace(',', '.') + ".000"%>đ</span>
                                        <span class="price-tag"><%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ</span>
                                        <% } else { %>
                                        <span class="price-tag price-free">Free</span>
                                        <% }%>
                                    </div>
                                    <a href="addToCart?id=<%= c.getId()%>" class="btn-cart-icon"><i class="fas fa-shopping-cart"></i></a>
                                        <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                        } %>
                </div>
            </div>

            <div class="mentor-section">
                <div class="container">
                    <div class="mentor-header">
                        <h2 class="mentor-title">Expert Mentors by Your Side</h2>
                        <p class="mentor-subtitle">You are never alone on your learning journey.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="mentor-card">
                                <div class="quote-icon"><i class="fas fa-quote-left"></i></div>
                                <p class="quote-text">"Students will be captivated by the enthusiasm, experience, and humorous stories I bring."</p>
                                <div class="mentor-profile">
                                    <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100" class="mentor-img" alt="Mentor">
                                    <div class="mentor-info"><h6>Anh Khoa</h6><span>Founder, CEO</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="mentor-card">
                                <div class="quote-icon"><i class="fas fa-quote-left"></i></div>
                                <p class="quote-text">"I teach with a practical approach. Theory is concise, focusing on helping students understand quickly."</p>
                                <div class="mentor-profile">
                                    <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100" class="mentor-img" alt="Mentor">
                                    <div class="mentor-info"><h6>Nhat Huy</h6><span>Senior Developer</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="mentor-card">
                                <div class="quote-icon"><i class="fas fa-quote-left"></i></div>
                                <p class="quote-text">"I aim for a teaching style that is serious yet relaxed. Knowledge is solid, explanations are simple."</p>
                                <div class="mentor-profile">
                                    <img src="https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100" class="mentor-img" alt="Mentor">
                                    <div class="mentor-info"><h6>Duc Hai</h6><span>Co-Founder, CTO</span></div>
                                    <div class="arrow-btn"><i class="fas fa-chevron-right"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="toast-container">
                <div id="liveToast" class="toast align-items-center text-white border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body"></div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div class="faculty-section">
                <div class="container">
                    <div class="faculty-card">
                        <div class="icon-wrapper">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <h2 class="faculty-title">Join Our Distinguished Faculty</h2>
                        <p class="faculty-desc">
                            We invite world-class educators and industry leaders to contribute to our 
                            academic mission. Inspire the next generation of scholars by sharing your expertise.
                        </p>
                        <a href="careers" class="btn-faculty">
                            Apply to Teach <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <%-- ==================================================================
     SCROLL NOTIFICATION BAR COMPONENT
     ================================================================== --%>

<%-- 1. HTML STRUCTURE --%>
<c:if test="${not empty notice}">
    <div id="scroll-notification" class="notification-bar notice-${notice.type}">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="notice-content">
                <i class="fas fa-bullhorn me-2"></i>
                <span class="fw-bold me-2">Announcement:</span>
                <span>${notice.message}</span>
            </div>
            
            <div class="notice-actions d-flex align-items-center">
                <c:if test="${not empty notice.buttonText}">empty notice
                    <a href="${pageContext.request.contextPath}/${notice.buttonUrl}" class="btn-notice">
                        ${notice.buttonText}
                    </a>
                </c:if>
                
                <button class="btn-notice-close" onclick="closeNotice()" aria-label="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </div>
</c:if>

<%-- 2. CSS STYLES --%>
<style>
    .notification-bar {
        position: fixed;
        top: -100px; /* Hidden initially */
        left: 0;
        width: 100%;
        z-index: 1040; /* Z-index lower than Navbar (1050) but higher than content */
        padding: 12px 0;
        color: white;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        transition: top 0.5s cubic-bezier(0.19, 1, 0.22, 1);
    }

    /* Active State: Sits exactly below your 75px-80px navbar */
    .notification-bar.active {
        top: 62px; 
    }

    /* Color Variants */
    .notice-danger { background: linear-gradient(90deg, #ef4444, #b91c1c); }  /* Red */
    .notice-success { background: linear-gradient(90deg, #10b981, #047857); } /* Green */
    .notice-primary { background: linear-gradient(90deg, #6366f1, #4338ca); } /* Purple */
    .notice-dark { background: linear-gradient(90deg, #1f2937, #111827); }    /* Dark */

    .notice-content {
        font-size: 0.95rem;
    }

    .btn-notice {
        background: rgba(255,255,255,0.2);
        color: white;
        padding: 5px 15px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.85rem;
        transition: all 0.2s;
        border: 1px solid rgba(255,255,255,0.3);
        white-space: nowrap;
    }
    
    .btn-notice:hover {
        background: white;
        color: #111;
        transform: translateY(-1px);
    }

    .btn-notice-close {
        background: transparent;
        border: none;
        color: rgba(255,255,255,0.8);
        margin-left: 15px;
        font-size: 1.2rem;
        cursor: pointer;
        transition: 0.2s;
        padding: 0;
        line-height: 1;
    }
    
    .btn-notice-close:hover {
        color: white;
        transform: scale(1.1);
    }
    
    /* Mobile Responsive */
    @media (max-width: 768px) {
        .notification-bar .container {
            flex-direction: column;
            gap: 10px;
            text-align: center;
        }
        .notification-bar.active {
            top: auto;
            bottom: 0; /* On mobile, stick to bottom is often better */
        }
    }
</style>

<%-- 3. JAVASCRIPT LOGIC --%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const noticeBar = document.getElementById('scroll-notification');
        
        // 1. Check if user already closed it in this session
        const isClosed = sessionStorage.getItem('noticeClosed') === 'true';

        // 2. Only activate if element exists and hasn't been closed
        if (noticeBar && !isClosed) {
            window.addEventListener('scroll', function() {
                // Show notification after scrolling down 150px
                if (window.scrollY > 150) {
                    noticeBar.classList.add('active');
                } else {
                    noticeBar.classList.remove('active');
                }
            });
        }
    });

    function closeNotice() {
        const noticeBar = document.getElementById('scroll-notification');
        if (noticeBar) {
            // 1. Hide it immediately
            noticeBar.classList.remove('active');
            
            // 2. Save preference to Session Storage so it doesn't pop up again until tab close
            sessionStorage.setItem('noticeClosed', 'true');
        }
    }
</script>

                <jsp:include page="footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // === 1. Navbar Toggle Logic ===
                        const navbar = document.querySelector('.navbar');

                        function toggleNavbar() {
                            if (window.scrollY > 100) {
                                navbar.classList.add('visible');
                            } else {
                                navbar.classList.remove('visible');
                            }
                        }

                        // Initial check
                        toggleNavbar();
                        window.addEventListener('scroll', toggleNavbar);
                    });

                    // === 2. Existing Helper Functions ===
                    function scrollCategories(direction) {
                        const container = document.getElementById('categoryContainer');
                        const scrollAmount = 300;
                        if (direction === 'left') {
                            container.scrollBy({left: -scrollAmount, behavior: 'smooth'});
                        } else {
                            container.scrollBy({left: scrollAmount, behavior: 'smooth'});
                        }
                    }

                    function scrollSection(containerId, direction) {
                        const container = document.getElementById(containerId);
                        const cardWidth = 280 + 20;
                        if (direction === 'left') {
                            container.scrollBy({left: -cardWidth, behavior: 'smooth'});
                        } else {
                            container.scrollBy({left: cardWidth, behavior: 'smooth'});
                        }
                    }

                    function scrollToSite() {
                        const site = document.getElementById('main-site');
                        // Scroll to main site logic
                        site.scrollIntoView({behavior: 'smooth'});
                    }

                    window.onload = function () {
                        // === 3. Toast Notification Logic ===
                        <%
                            String successMsg = (String) session.getAttribute("success");
                            String errorMsg = (String) session.getAttribute("error");
                            if (successMsg != null) {
                                session.removeAttribute("success");
                            }
                            if (errorMsg != null)
                                session.removeAttribute("error");
                        %>
                        var successMsg = "<%= (successMsg != null) ? successMsg : ""%>";
                        var errorMsg = "<%= (errorMsg != null) ? errorMsg : ""%>";

                        var toastEl = document.getElementById('liveToast');
                        var toastBody = toastEl.querySelector('.toast-body');
                        var toastOptions = {delay: 2000};

                        if (successMsg.trim() !== "") {
                            toastEl.classList.remove('bg-danger');
                            toastEl.classList.add('bg-success');
                            toastBody.innerText = successMsg;
                            var toast = new bootstrap.Toast(toastEl, toastOptions);
                            toast.show();
                        } else if (errorMsg.trim() !== "") {
                            toastEl.classList.remove('bg-success');
                            toastEl.classList.add('bg-danger');
                            toastBody.innerText = errorMsg;
                            var toast = new bootstrap.Toast(toastEl, toastOptions);
                            toast.show();
                        }
                    };
                </script>
            </div>
        </div>
    </body>
</html>