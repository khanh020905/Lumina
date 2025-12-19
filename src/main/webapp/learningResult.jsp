<%@page import="Model.Course"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Learning Path - Lumina Learning</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* --- CORE THEME (Consistent with Home/Career) --- */
        :root {
            --primary-purple: #5d3fd3;
            --primary-glow: #818cf8;
            --bg-dark: #020617;
            --card-bg: #0f172a;
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
            padding-top: 0 !important;
            overflow-x: hidden;
        }

        /* --- NAVBAR --- */
        .navbar {
            position: fixed !important; top: 0; left: 0; width: 100%; z-index: 1050;
            background-color: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.08) !important;
            padding: 10px 0 !important;
        }

        /* --- HERO HEADER --- */
        .result-header {
            padding: 120px 20px 60px 20px;
            text-align: center;
            background: radial-gradient(circle at top, #1e1b4b 0%, #020617 70%);
            position: relative;
        }
        
        .result-header::after {
            content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 100px;
            background: linear-gradient(to bottom, transparent, var(--bg-dark));
        }

        .header-badge {
            background: rgba(99, 102, 241, 0.1); border: 1px solid rgba(99, 102, 241, 0.3);
            color: #a5b4fc; padding: 6px 16px; border-radius: 50px; font-size: 0.85rem; font-weight: 600;
            margin-bottom: 20px; display: inline-block; text-transform: uppercase; letter-spacing: 1px;
        }

        .header-title {
            font-size: 3rem; font-weight: 800; margin-bottom: 15px;
            background: linear-gradient(to right, #fff, #a5b4fc);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }

        .header-desc {
            color: var(--text-muted); font-size: 1.1rem; max-width: 600px; margin: 0 auto;
        }

        /* --- TIMELINE CONTAINER --- */
        .timeline-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px 100px 20px;
            position: relative;
        }

        /* Vertical Line */
        .timeline-container::before {
            content: ''; position: absolute; top: 0; bottom: 0; left: 50%;
            width: 2px; background: linear-gradient(to bottom, #312e81, #1e1b4b, transparent);
            transform: translateX(-50%); z-index: 0;
        }

        /* --- COURSE CARD (Timeline Item) --- */
        .timeline-item {
            display: flex; justify-content: center; align-items: center;
            margin-bottom: 60px; position: relative; z-index: 1;
        }

        .timeline-card {
            display: flex; width: 100%; max-width: 900px;
            background: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px; overflow: hidden;
            box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .timeline-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px -5px rgba(93, 63, 211, 0.15);
            border-color: rgba(93, 63, 211, 0.3);
        }

        /* Image Section */
        .card-img-wrapper {
            width: 300px; position: relative; flex-shrink: 0;
        }
        
        .card-img {
            width: 100%; height: 100%; object-fit: cover;
        }

        .course-code-badge {
            position: absolute; top: 15px; left: 15px;
            background: #6366f1; color: white;
            padding: 5px 10px; border-radius: 6px;
            font-weight: 700; font-size: 0.8rem;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        /* Content Section */
        .card-body {
            padding: 30px; flex-grow: 1; display: flex; flex-direction: column;
        }

        .card-title { font-size: 1.5rem; font-weight: 700; color: white; margin-bottom: 10px; }
        
        .ai-reason-box {
            background: rgba(99, 102, 241, 0.05);
            border-left: 3px solid var(--primary-purple);
            padding: 15px; border-radius: 0 8px 8px 0;
            margin-bottom: 20px;
        }
        
        .ai-reason-title {
            font-size: 0.8rem; color: #a5b4fc; text-transform: uppercase; font-weight: 700; margin-bottom: 5px;
            display: flex; align-items: center; gap: 6px;
        }
        
        .ai-reason-text { font-size: 0.95rem; color: #cbd5e1; font-style: italic; line-height: 1.5; }

        .card-footer {
            margin-top: auto; display: flex; justify-content: space-between; align-items: center;
            border-top: 1px solid rgba(255,255,255,0.05); padding-top: 15px;
        }

        .price-tag { font-size: 1.2rem; font-weight: 700; color: var(--primary-purple); }
        .price-free { color: #10b981; font-weight: 700; font-size: 1.2rem; }

        .btn-view {
            background: white; color: #020617; text-decoration: none;
            padding: 10px 25px; border-radius: 50px; font-weight: 600;
            transition: all 0.2s; display: inline-flex; align-items: center; gap: 8px;
        }
        
        .btn-view:hover { background: #e2e8f0; transform: translateY(-2px); }

        /* Step Number Circle */
        .step-number {
            position: absolute; left: 50%; top: -15px; transform: translateX(-50%);
            width: 40px; height: 40px; background: var(--primary-purple);
            border: 4px solid var(--bg-dark); border-radius: 50%;
            color: white; font-weight: 800; display: flex; align-items: center; justify-content: center;
            box-shadow: 0 0 20px rgba(93, 63, 211, 0.5); z-index: 2;
        }

        /* --- EMPTY STATE --- */
        .empty-state { text-align: center; padding: 100px 20px; color: var(--text-muted); }
        .empty-icon { font-size: 4rem; margin-bottom: 20px; opacity: 0.5; }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .timeline-container::before { left: 20px; } /* Move line to left */
            .step-number { left: 20px; }
            .timeline-item { padding-left: 40px; margin-bottom: 40px; }
            .timeline-card { flex-direction: column; width: 100%; }
            .card-img-wrapper { width: 100%; height: 200px; }
            .header-title { font-size: 2rem; }
        }
    </style>
</head>
<body>

    <jsp:include page="nav-bar.jsp" />

    <div class="result-header">
        <div class="header-badge">
            <i class="fas fa-magic me-2"></i> Generated Success
        </div>
        <h1 class="header-title">Your Personalized Path</h1>
        <p class="header-desc">
            Based on your skills and goals, our AI has curated this optimal learning sequence to help you master your specialization.
        </p>
    </div>

    <div class="timeline-container">
        
        <c:choose>
            <c:when test="${not empty courseMap}">
                <% int stepCounter = 1; %>
                <c:forEach var="entry" items="${courseMap}">
                    
                    <div class="timeline-item">
                        <div class="step-number"><%= stepCounter++ %></div>

                        <div class="timeline-card">
                            <div class="card-img-wrapper">
                                <img src="${entry.key.img_url}" class="card-img" alt="${entry.key.title}">
                                <span class="course-code-badge">${entry.key.courseCode}</span>
                            </div>

                            <div class="card-body">
                                <h3 class="card-title">${entry.key.title}</h3>
                                
                                <div class="ai-reason-box">
                                    <div class="ai-reason-title">
                                        Why this course?
                                    </div>
                                    <p class="ai-reason-text">
                                        "${entry.value}"
                                    </p>
                                </div>

                                <div class="card-footer">
                                    <div class="price-section">
                                        <c:choose>
                                            <c:when test="${entry.key.price > 0}">
                                                <span class="price-tag">
                                                    <fmt:formatNumber value="${entry.key.price}" type="number" pattern="#,###"/>.000đ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="price-free">Free</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <a href="course-details?id=${entry.key.id}" class="btn-view">
                                        Start Learning <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:forEach>
                
                <div class="text-center mt-5" style="color: #6366f1;">
                    <div style="font-size: 2rem; margin-bottom: 10px;"><i class="fas fa-flag-checkered"></i></div>
                    <h4 style="color:white; font-weight:700;">Career Goal Reached</h4>
                </div>

            </c:when>
            
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-search"></i></div>
                    <h3>No path generated yet</h3>
                    <p>It seems we couldn't generate a path. Please try selecting different options.</p>
                    <a href="createPath" class="btn-view mt-3">Try Again</a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>