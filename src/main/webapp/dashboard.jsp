<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<%
    // --- 1. SECURITY CHECK ---
    // If user is not logged in, kick them to login page
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String displayName = (user.getUsername() != null) ? user.getUsername() : "Student";

    // --- 2. GET ENROLLED COURSES ---
    List<Course> myCourses = (List<Course>) session.getAttribute("myCourse");
    if (myCourses == null) {
        myCourses = new ArrayList<>();
    }
    
    int enrolledCount = myCourses.size();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-purple: #5d3fd3;
                --primary-dark: #1e1b4b;
                --text-dark: #111827;
                --text-muted: #6b7280;
                --bg-light: #f3f4f6;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-light);
                color: var(--text-dark);
            }

            /* --- DASHBOARD HEADER --- */
            .dash-header {
                background: white;
                padding: 40px 0;
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 30px;
            }
            .welcome-title { font-weight: 800; font-size: 2rem; color: var(--text-dark); margin: 0; }
            .welcome-sub { color: var(--text-muted); font-size: 1rem; margin-top: 5px; }

            /* --- STAT CARDS --- */
            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 20px;
                display: flex;
                align-items: center;
                gap: 20px;
                border: 1px solid #e5e7eb;
                transition: transform 0.2s;
                height: 100%;
            }
            .stat-card:hover { transform: translateY(-3px); box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
            .stat-icon {
                width: 50px; height: 50px;
                border-radius: 12px;
                display: flex; align-items: center; justify-content: center;
                font-size: 1.5rem;
            }
            .icon-purple { background: #f3f0ff; color: var(--primary-purple); }
            .icon-green { background: #d1fae5; color: #059669; }
            .icon-blue { background: #dbeafe; color: #2563eb; }
            
            .stat-info h3 { font-size: 1.5rem; font-weight: 700; margin: 0; }
            .stat-info p { color: var(--text-muted); font-size: 0.9rem; margin: 0; }

            /* --- CONTINUE LEARNING (HERO CARD) --- */
            .continue-card {
                background: linear-gradient(135deg, #5d3fd3 0%, #4338ca 100%);
                color: white;
                border-radius: 20px;
                padding: 30px;
                position: relative;
                overflow: hidden;
                box-shadow: 0 10px 25px rgba(93, 63, 211, 0.25);
            }
            .continue-badge {
                background: rgba(255,255,255,0.2);
                padding: 5px 12px;
                border-radius: 6px;
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                margin-bottom: 15px;
                display: inline-block;
            }
            .continue-title { font-size: 1.5rem; font-weight: 700; margin-bottom: 10px; }
            .progress-label { display: flex; justify-content: space-between; font-size: 0.9rem; margin-bottom: 5px; opacity: 0.9; }
            .progress-custom { height: 8px; background: rgba(255,255,255,0.2); border-radius: 10px; }
            .progress-bar-custom { background: #10b981; border-radius: 10px; }
            .btn-continue {
                background: white; color: var(--primary-purple);
                font-weight: 700; padding: 10px 25px; border-radius: 30px;
                text-decoration: none; display: inline-block; margin-top: 20px;
                transition: transform 0.2s;
            }
            .btn-continue:hover { transform: translateY(-2px); color: var(--primary-purple); }

            /* --- COURSE GRID --- */
            .section-heading { font-size: 1.25rem; font-weight: 700; margin-bottom: 20px; margin-top: 40px; display: flex; justify-content: space-between; align-items: center; }
            .my-course-card {
                background: white; border-radius: 16px; overflow: hidden;
                border: 1px solid #e5e7eb; transition: all 0.3s;
                height: 100%; display: flex; flex-direction: column;
            }
            .my-course-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
            .mc-img { width: 100%; height: 140px; object-fit: cover; }
            .mc-body { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
            .mc-title { font-size: 1rem; font-weight: 700; margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
            .mc-footer { margin-top: auto; padding-top: 15px; }
            .btn-start {
                width: 100%; display: block; text-align: center;
                border: 1px solid #e5e7eb; background: white; color: var(--text-dark);
                padding: 8px; border-radius: 8px; font-weight: 600; text-decoration: none;
                transition: 0.2s;
            }
            .btn-start:hover { background: #f9fafb; border-color: #d1d5db; color: var(--primary-purple); }

            /* --- EMPTY STATE --- */
            .empty-state { text-align: center; padding: 60px 20px; background: white; border-radius: 16px; border: 1px dashed #e5e7eb; }
            .empty-icon { font-size: 3rem; color: #d1d5db; margin-bottom: 15px; }
        </style>
    </head>
    <body>

        <jsp:include page="nav-bar.jsp" />

        <div class="dash-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="welcome-title">Welcome back, <%= displayName %>! 👋</h1>
                        <p class="welcome-sub">You've learned <strong>80%</strong> more than last week. Keep it up!</p>
                    </div>
                    <div class="col-md-4 text-md-end d-none d-md-block">
                        <a href="courses" class="btn btn-outline-dark rounded-pill px-4">Browse Courses</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row g-4">
                
                <div class="col-lg-8">
                    
                    <div class="row g-3 mb-4">
                        <div class="col-sm-4">
                            <div class="stat-card">
                                <div class="stat-icon icon-purple"><i class="fas fa-book-open"></i></div>
                                <div class="stat-info">
                                    <h3><%= enrolledCount %></h3>
                                    <p>Enrolled</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="stat-card">
                                <div class="stat-icon icon-green"><i class="fas fa-check-circle"></i></div>
                                <div class="stat-info">
                                    <h3>0</h3>
                                    <p>Completed</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="stat-card">
                                <div class="stat-icon icon-blue"><i class="fas fa-certificate"></i></div>
                                <div class="stat-info">
                                    <h3>0</h3>
                                    <p>Certificates</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <% if (enrolledCount > 0) { 
                        Course activeCourse = myCourses.get(0); // Simulate "last active"
                    %>
                    <div class="continue-card mb-5">
                        <span class="continue-badge">Continue Learning</span>
                        <h2 class="continue-title"><%= activeCourse.getTitle() %></h2>
                        <div class="mt-4">
                            <div class="progress-label">
                                <span>Progress</span>
                                <span>35%</span> </div>
                            <div class="progress progress-custom">
                                <div class="progress-bar progress-bar-custom" style="width: 35%"></div>
                            </div>
                        </div>
                        <a href="learning.jsp?courseCode=<%= activeCourse.getCourseCode() %>" class="btn-continue">
                            Resume Course <i class="fas fa-play ms-2"></i>
                        </a>
                        <i class="fas fa-laptop-code" style="position: absolute; right: -20px; bottom: -30px; font-size: 10rem; opacity: 0.1; color: white; transform: rotate(-15deg);"></i>
                    </div>
                    <% } %>

                    <div class="section-heading">
                        <span><i class="fas fa-th-large me-2" style="color:var(--primary-purple)"></i> My Courses</span>
                        <a href="courses" style="font-size:0.9rem; text-decoration:none; color:var(--primary-purple)">Browse All ></a>
                    </div>

                    <% if (enrolledCount > 0) { %>
                    <div class="row g-4">
                        <% for (Course c : myCourses) { %>
                        <div class="col-md-6">
                            <div class="my-course-card">
                                <img src="<%= c.getImg_url() %>" class="mc-img" alt="<%= c.getTitle() %>">
                                <div class="mc-body">
                                    <h5 class="mc-title"><%= c.getTitle() %></h5>
                                    
                                    <div class="progress" style="height: 6px; margin-bottom: 15px;">
                                        <div class="progress-bar bg-success" style="width: 15%"></div>
                                    </div>
                                    
                                    <div class="d-flex justify-content-between text-muted" style="font-size:0.85rem; margin-bottom:15px;">
                                        <span><i class="far fa-play-circle"></i> 2/12 Lessons</span>
                                        <span>15%</span>
                                    </div>

                                    <div class="mc-footer">
                                        <a href="learning.jsp?courseCode=<%= c.getCourseCode() %>" class="btn-start">Go to Class</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon"><i class="fas fa-layer-group"></i></div>
                            <h4>No courses yet</h4>
                            <p class="text-muted">Start your learning journey today. Explore our catalog.</p>
                            <a href="courses" class="btn btn-primary rounded-pill px-4 mt-2" style="background: var(--primary-purple); border:none;">Explore Courses</a>
                        </div>
                    <% } %>

                </div>

                <div class="col-lg-4">
                    
                    <div class="card border-0 shadow-sm p-3 mb-4 rounded-4">
                        <div class="card-body">
                            <h5 class="fw-bold mb-3">Weekly Goal</h5>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div style="flex-grow:1;">
                                    <div class="d-flex justify-content-between mb-1">
                                        <small class="fw-bold text-muted">2/5 Days</small>
                                        <small class="fw-bold text-success">On Track</small>
                                    </div>
                                    <div class="progress" style="height: 8px;">
                                        <div class="progress-bar" style="width: 40%; background-color: var(--primary-purple);"></div>
                                    </div>
                                </div>
                                <div style="font-size:1.5rem;">🔥</div>
                            </div>
                            <p class="text-muted small mb-0">Learn 30 minutes a day to maintain your streak!</p>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm p-3 rounded-4">
                        <div class="card-body">
                            <h5 class="fw-bold mb-3">Upcoming Schedule</h5>
                            
                            <div class="d-flex gap-3 mb-3">
                                <div class="text-center p-2 rounded bg-light" style="min-width: 50px;">
                                    <div class="fw-bold text-danger">DEC</div>
                                    <div class="h5 mb-0 fw-bold">18</div>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-1" style="font-size:0.95rem;">Java OOP Live Q&A</h6>
                                    <p class="text-muted small mb-0">20:00 - 21:00 PM</p>
                                </div>
                            </div>

                            <div class="d-flex gap-3">
                                <div class="text-center p-2 rounded bg-light" style="min-width: 50px;">
                                    <div class="fw-bold text-primary">DEC</div>
                                    <div class="h5 mb-0 fw-bold">20</div>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-1" style="font-size:0.95rem;">Web Design Assignment</h6>
                                    <p class="text-muted small mb-0">Due by 11:59 PM</p>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>