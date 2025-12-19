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
        <title>Course Catalog - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            /* --- GLOBAL VARIABLES & RESET --- */
            :root {
                --primary-purple: #5d3fd3;
                --primary-hover: #4a32a8;
                --text-main: #111827;
                --text-secondary: #6b7280;
                --bg-color: #f8f9fa;
                --card-hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                --badge-bg: #e0e7ff;
                --badge-text: #4338ca;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-main);
                overflow-x: hidden;
            }

            a { text-decoration: none; }

            /* --- LAYOUT --- */
            .catalog-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }

            /* --- HERO BANNER --- */
            .hero-banner { background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); border-radius: 20px; padding: 40px 50px; color: white; margin-bottom: 40px; position: relative; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
            .hero-title { font-size: 2.2rem; font-weight: 800; margin-bottom: 10px; letter-spacing: -0.5px; }
            .hero-text { font-size: 1rem; opacity: 0.9; max-width: 600px; margin-bottom: 20px; font-weight: 400; line-height: 1.6; }
            .hero-footer { display: flex; align-items: center; gap: 12px; }
            .avatars { display: flex; }
            .avatars img { width: 32px; height: 32px; border-radius: 50%; border: 2px solid #6366f1; margin-left: -8px; }
            .avatars img:first-child { margin-left: 0; }
            .join-text { font-size: 0.9rem; font-weight: 500; opacity: 0.9; }

            /* --- STICKY FILTERS --- */
            .filter-sticky-wrapper { position: sticky; top: 73px; z-index: 900; background: rgba(248, 249, 250, 0.95); backdrop-filter: blur(8px); padding: 15px 0; margin-bottom: 20px; border-bottom: 1px solid rgba(0,0,0,0.05); }
            .filter-row { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
            .cat-pills { display: flex; gap: 10px; overflow-x: auto; scrollbar-width: none; flex-grow: 1; padding: 10px 5px; }
            .cat-pill { white-space: nowrap; padding: 8px 18px; border-radius: 50px; background: white; border: 1px solid #e5e7eb; color: var(--text-secondary); font-size: 0.9rem; font-weight: 600; transition: all 0.2s; display: flex; align-items: center; gap: 6px; text-decoration: none; cursor: pointer; }
            .cat-pill:hover, .cat-pill.active { background-color: var(--primary-purple) !important; color: white !important; border-color: var(--primary-purple) !important; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(93, 63, 211, 0.3); }
            .cat-pill.active i, .cat-pill:hover i { color: white !important; }
            .cat-pill i { font-size: 0.85rem; }

            /* --- LIST VIEW COURSE CARD --- */
            .section-header { font-size: 1.25rem; font-weight: 700; color: var(--text-main); margin-bottom: 20px; }
            .count { color: var(--text-secondary); font-weight: 400; font-size: 1rem; margin-left: 5px; }
            .course-list-item { background: white; border: 1px solid #e5e7eb; border-radius: 16px; overflow: hidden; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); margin-bottom: 24px; display: flex; align-items: stretch; position: relative; }
            .course-list-item:hover { transform: translateY(-3px); box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1); border-color: #d1d5db; }
            .card-thumb-wrapper { width: 280px; flex-shrink: 0; position: relative; }
            .card-thumb { width: 100%; height: 100%; object-fit: cover; }
            .badge-cat { position: absolute; top: 15px; left: 15px; background: rgba(255,255,255,0.9); color: var(--primary-purple); padding: 5px 12px; border-radius: 6px; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            .card-content { padding: 24px; flex-grow: 1; display: flex; flex-direction: column; }
            .card-header-row { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 10px; }
            .card-title { font-size: 1.25rem; font-weight: 700; color: var(--text-main); margin: 0; line-height: 1.3; margin-right: 15px; }
            .course-code { font-size: 0.8rem; color: var(--text-secondary); background: #f3f4f6; padding: 4px 8px; border-radius: 4px; font-family: monospace; }
            .card-desc { color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; margin-bottom: 15px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
            .card-meta { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; font-size: 0.9rem; color: var(--text-secondary); }
            .meta-item { display: flex; align-items: center; gap: 6px; }
            .stars { color: #fbbf24; }
            .card-foot { margin-top: auto; padding-top: 20px; border-top: 1px solid #f3f4f6; display: flex; justify-content: space-between; align-items: center; }
            .price-box { display: flex; align-items: baseline; gap: 10px; }
            .price-old { font-size: 0.9rem; text-decoration: line-through; color: #9ca3af; }
            .price-new { font-size: 1.4rem; font-weight: 700; color: var(--primary-purple); }
            .price-free { font-size: 1.4rem; font-weight: 700; color: #10b981; }
            .card-actions { display: flex; gap: 10px; }
            .btn-view { background: white; color: var(--text-main); border: 1px solid #e5e7eb; border-radius: 8px; padding: 8px 16px; font-weight: 600; font-size: 0.9rem; transition: 0.2s; }
            .btn-view:hover { background: #f9fafb; border-color: #d1d5db; }
            .btn-add { background: var(--primary-purple); color: white; border: none; border-radius: 8px; padding: 8px 20px; font-weight: 600; font-size: 0.9rem; display: flex; align-items: center; gap: 8px; text-decoration: none; transition: 0.2s; }
            .btn-add:hover { background: var(--primary-hover); color: white; transform: translateY(-1px); }
            
            /* Enrolled Badge Button */
            .btn-enrolled { height: 35px; padding: 0 15px; border-radius: 8px; background-color: #d1fae5; color: #065f46; font-weight: 700; font-size: 0.85rem; border: none; display: flex; align-items: center; justify-content: center; text-decoration: none; pointer-events: none; }

            /* Pagination */
            .pagination-wrap { margin-top: 60px; display: flex; justify-content: center; }
            .page-btn { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 8px; border: 1px solid #e5e7eb; margin: 0 4px; color: var(--text-main); font-weight: 600; font-size: 0.9rem; transition: 0.2s; background: white; text-decoration: none; }
            .page-btn.active { background: var(--primary-purple); color: white; border-color: var(--primary-purple); }
            .page-btn:hover:not(.active) { background: #f9fafb; border-color: #d1d5db; }

            /* Responsive */
            @media (max-width: 768px) { .course-list-item { flex-direction: column; } .card-thumb-wrapper { width: 100%; height: 200px; } .badge-cat { top: 15px; left: 15px; } }

            /* --- UPDATED TOAST CSS (Middle Top) --- */
            .toast-container { z-index: 1090 !important; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); min-width: 300px; }
            .toast { font-size: 1rem; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        </style>
    </head>
    <body>

        <%
            // Retrieve Course List
            List<Course> courseList = (List<Course>) request.getAttribute("courseList");
            if (courseList == null) courseList = new ArrayList<>();

            // Active Category Logic
            String activeCat = (String) request.getAttribute("activeCategory");
            
            // Retrieve Enrolled Courses (for checking status in the list)
            List<Course> enrolledCourses = (List<Course>) session.getAttribute("myCourse");
            if(enrolledCourses == null) enrolledCourses = new ArrayList<>();

            // --- PAGINATION LOGIC ---
            int pageNum = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try { pageNum = Integer.parseInt(pageStr); } catch (Exception e) {}
            }

            int itemsPerPage = 5;
            int totalItems = courseList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startItem = (pageNum - 1) * itemsPerPage;
            int endItem = Math.min(startItem + itemsPerPage, totalItems);

            List<Course> displayList = new ArrayList<>();
            if (startItem < totalItems) {
                displayList = courseList.subList(startItem, endItem);
            }
        %>

        <jsp:include page="nav-bar.jsp" />

        <div class="catalog-container">

            <div class="hero-banner">
                <div class="row">
                    <div class="col-md-8">
                        <h1 class="hero-title">Expand your horizons.</h1>
                        <p class="hero-text">Choose from over 100+ expert-led courses. Filter by category, difficulty, or popularity to find your next challenge.</p>
                        <div class="hero-footer">
                            <div class="avatars">
                                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="">
                                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="">
                                <img src="https://randomuser.me/api/portraits/men/85.jpg" alt="">
                            </div>
                            <span class="join-text">Join 15k+ students enrolling this week</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="filter-sticky-wrapper">
                <div class="filter-row">
                    <div class="cat-pills">
                        <a href="courses" class="cat-pill <%= (activeCat == null || activeCat.isEmpty() || "All".equals(activeCat)) ? "active" : ""%>">
                            <i class="fas fa-th-large"></i> All Courses
                        </a>
                        <a href="courses?category=Software+Engineering" class="cat-pill <%= "Software Engineering".equals(activeCat) ? "active" : ""%>">
                            <i class="fas fa-laptop-code"></i> Software Engineer
                        </a>
                        <a href="courses?category=Other+Language" class="cat-pill <%= "Other Language".equals(activeCat) ? "active" : ""%>">
                            <i class="fas fa-language"></i> Other Language
                        </a>
                        <a href="courses?category=Math+for+SE" class="cat-pill <%= "Math for SE".equals(activeCat) ? "active" : ""%>">
                            <i class="fas fa-square-root-alt"></i> Math for SE
                        </a>
                    </div>
                    <button class="cat-pill"><i class="fas fa-filter"></i> Filters</button>
                </div>
            </div>

            <div class="section-header">
                <% if(request.getAttribute("searchKeyword") != null) { %>
                    Search Results for "<%= request.getAttribute("searchKeyword") %>" <span class="count">(<%= courseList.size()%>)</span>
                <% } else { %>
                    All Courses <span class="count">(<%= courseList.size()%>)</span>
                <% } %>
            </div>

            <div class="course-list">
                <%
                    if (displayList != null && !displayList.isEmpty()) {
                        for (Course c : displayList) {
                            // Check if already enrolled (Using ID for comparison if needed, but CourseCode is often unique)
                            boolean isEnrolled = false;
                            for(Course enrolled : enrolledCourses) {
                                // Assuming ID is the unique identifier
                                if(enrolled.getId() == c.getId()) {
                                    isEnrolled = true;
                                    break;
                                }
                            }
                %>
                <div class="course-list-item">
                    <div class="card-thumb-wrapper">
                        <img src="<%= c.getImg_url()%>" class="card-thumb" alt="<%= c.getTitle()%>">
                        <span class="badge-cat">
                            <%= (c.getCategory() != null) ? c.getCategory() : c.getCourseCode()%>
                        </span>
                    </div>

                    <div class="card-content">
                        <div class="card-header-row">
                            <h5 class="card-title"><%= c.getTitle()%></h5>
                            <span class="course-code"><%= c.getCourseCode()%></span>
                        </div>

                        <p class="card-desc">
                            <%= (c.getDescription() != null) ? c.getDescription() : "Master this subject with comprehensive lessons and hands-on projects."%>
                        </p>

                        <div class="card-meta">
                            <div class="meta-item">
                                <span class="stars"><i class="fas fa-star"></i> 4.8</span>
                                <span class="reviews">(120 reviews)</span>
                            </div>
                            <div class="meta-item">
                                <i class="far fa-calendar-alt"></i>
                                <%= (c.getCreatedAt() != null) ? c.getCreatedAt() : "2024-01-01"%>
                            </div>
                            <div class="meta-item">
                                <i class="far fa-clock"></i> 24h Total
                            </div>
                        </div>

                        <div class="card-foot">
                            <div class="price-box">
                                <% if (c.getPrice() > 0) {%>
                                <span class="price-new"><%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ</span>
                                <span class="price-old"><%= String.format("%,.0f", c.getPrice() * 1.2).replace(',', '.') + ".000"%>đ</span>
                                <% } else { %>
                                <span class="price-free">Free</span>
                                <% }%>
                            </div>

                            <div class="card-actions">
                                <a href="course-details?id=<%= c.getId()%>" class="btn-view">View Details</a>
                                
                                <% if (isEnrolled) { %>
                                    <a href="learning.jsp?id=<%= c.getId()%>" class="btn-enrolled"><i class="fas fa-check-circle me-1"></i> Enrolled</a>
                                <% } else { %>
                                    <a href="addToCart?id=<%= c.getId()%>" class="btn-add">
                                        <i class="fas fa-cart-plus"></i> Add to cart
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="col-12 text-center py-5">
                    <div class="mb-3">
                        <i class="fas fa-search" style="font-size: 3rem; color: #e5e7eb;"></i>
                    </div>
                    <h4 class="fw-bold text-muted">No courses found</h4>
                    <% if (request.getAttribute("searchKeyword") != null) { %>
                        <p class="text-muted">We couldn't find any matches for "<%= request.getAttribute("searchKeyword") %>".</p>
                    <% } else { %>
                        <p class="text-muted">Try adjusting your filters.</p>
                    <% } %>
                    <a href="courses" class="btn btn-outline-primary rounded-pill mt-3 text-decoration-none">View All Courses</a>
                </div>
                <% } %>
            </div>

            <%
                String queryParams = "";
                if (activeCat != null && !activeCat.isEmpty() && !"All".equals(activeCat)) {
                    queryParams = "&category=" + java.net.URLEncoder.encode(activeCat, "UTF-8");
                }
                if (request.getAttribute("searchKeyword") != null) {
                    queryParams += "&search=" + java.net.URLEncoder.encode((String)request.getAttribute("searchKeyword"), "UTF-8");
                }
            %>
            <div class="pagination-wrap">
                <% if (pageNum > 1) {%>
                <a href="courses?page=<%= pageNum - 1%><%= queryParams%>" class="page-btn"><i class="fas fa-chevron-left"></i></a>
                <% } else { %>
                <span class="page-btn disabled" style="opacity:0.5; pointer-events:none;"><i class="fas fa-chevron-left"></i></span>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) {%>
                <a href="courses?page=<%= i%><%= queryParams%>" class="page-btn <%= (i == pageNum) ? "active" : ""%>"><%= i%></a>
                <% } %>

                <% if (pageNum < totalPages) {%>
                <a href="courses?page=<%= pageNum + 1%><%= queryParams%>" class="page-btn"><i class="fas fa-chevron-right"></i></a>
                <% } else { %>
                <span class="page-btn disabled" style="opacity:0.5; pointer-events:none;"><i class="fas fa-chevron-right"></i></span>
                <% } %>
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

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            window.onload = function () {
                <%
                    String successMsg = (String) session.getAttribute("success");
                    String errorMsg = (String) session.getAttribute("error");
                    if (successMsg != null) session.removeAttribute("success");
                    if (errorMsg != null) session.removeAttribute("error");
                %>
                var successMsg = "<%= (successMsg != null) ? successMsg : ""%>";
                var errorMsg = "<%= (errorMsg != null) ? errorMsg : ""%>";

                var toastEl = document.getElementById('liveToast');
                var toastBody = toastEl.querySelector('.toast-body');
                var toastOptions = { delay: 2000 };

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
    </body>
</html>