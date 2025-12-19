<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Careers - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-purple: #5d3fd3;
                --text-dark: #111827;
                --text-muted: #6b7280;
                --bg-light: #f8f9fa;
            }

            html {
                scroll-behavior: smooth;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-light);
                color: var(--text-dark);
                padding-top: 0 !important;
            }

            /* --- NAVBAR OVERRIDE (Hidden Initially) --- */
            .navbar {
                position: fixed !important;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;

                /* Start HIDDEN: Move it up exactly 100% of its own height */
                transform: translateY(-100%);

                /* Smooth slide animation */
                transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);

                /* Design when it appears */
                background-color: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 20px rgba(0,0,0,0.08) !important;
                padding-top: 10px !important;
                padding-bottom: 10px !important;
            }

            /* --- NAVBAR VISIBLE (Added via JS) --- */
            .navbar.visible {
                /* Slide it back down into view */
                transform: translateY(0);
            }


            /* --- 1. FULL SCREEN HERO HEADER --- */
            .career-header {
                height: 100vh;
                min-height: 600px;
                background: radial-gradient(70% 90% at 50% 0%, #1e1b4b 0%, #0f172a 100%);
                color: white;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .career-header::before {
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

            .career-content-wrapper {
                z-index: 2;
                max-width: 800px;
                padding: 0 20px;
                animation: fadeInUp 1s ease-out;
            }

            .career-icon-box {
                width: 70px;
                height: 70px;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 30px;
                backdrop-filter: blur(5px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .career-title {
                font-family: 'Inter', serif;
                font-size: 4rem;
                font-weight: 800;
                margin-bottom: 20px;
                letter-spacing: -1.5px;
                line-height: 1.1;
            }

            .career-sub {
                font-size: 1.3rem;
                color: #cbd5e1;
                font-weight: 300;
                line-height: 1.6;
                margin-bottom: 40px;
            }

            /* Scroll Down Indicator */
            .scroll-down-btn {
                position: absolute;
                bottom: 40px;
                left: 50%;
                transform: translateX(-50%);
                color: rgba(255, 255, 255, 0.6);
                text-decoration: none;
                display: flex;
                flex-direction: column;
                align-items: center;
                font-size: 0.9rem;
                transition: color 0.3s;
                z-index: 10;
                cursor: pointer;
            }
            .scroll-down-btn:hover {
                color: white;
            }
            .scroll-down-btn i {
                font-size: 1.5rem;
                margin-top: 8px;
                animation: bounce 2s infinite;
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% {
                    transform: translateY(0);
                }
                40% {
                    transform: translateY(-10px);
                }
                60% {
                    transform: translateY(-5px);
                }
            }
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

            /* --- 2. JOB LIST STYLES --- */
            .jobs-container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 80px 20px 40px 20px;
            }

            .job-card {
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 16px;
                padding: 30px;
                margin-bottom: 24px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                flex-direction: column;
                position: relative;
            }
            .job-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.08);
                border-color: #a5b4fc;
            }
            .job-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 15px;
            }
            .job-info h4 {
                font-weight: 700;
                font-size: 1.5rem;
                margin: 0;
                color: var(--text-dark);
            }

            .job-desc {
                color: var(--text-muted);
                font-size: 1.05rem;
                line-height: 1.6;
                margin-bottom: 25px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .job-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top: 1px solid #f1f5f9;
                padding-top: 20px;
            }

            .date-badge {
                font-size: 0.9rem;
                font-weight: 500;
                color: #64748b;
                display: flex;
                align-items: center;
                gap: 8px;
                background-color: #f8fafc;
                padding: 6px 14px;
                border-radius: 50px;
            }

            .btn-apply {
                background-color: var(--primary-purple);
                color: white;
                padding: 12px 28px;
                border-radius: 10px;
                font-weight: 600;
                text-decoration: none;
                transition: 0.2s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-apply:hover {
                background-color: #4338ca;
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(93, 63, 211, 0.3);
            }

            /* --- 3. EMPTY STATE --- */
            @keyframes floatUpDown {
                0% {
                    transform: rotate(-10deg) translateY(0px);
                }
                50% {
                    transform: rotate(-10deg) translateY(-15px);
                }
                100% {
                    transform: rotate(-10deg) translateY(0px);
                }
            }

            .empty-state {
                text-align: center;
                padding: 100px 20px;
                background: white;
                border: 2px dashed #e2e8f0;
                border-radius: 24px;
                max-width: 900px;
                margin: 40px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .empty-icon {
                font-size: 4rem;
                color: #cbd5e1;
                margin-bottom: 24px;
                display: inline-block;
                animation: floatUpDown 3s ease-in-out infinite;
            }
            .empty-title {
                font-size: 2rem;
                font-weight: 800;
                color: #1e293b;
                margin-bottom: 12px;
                letter-spacing: -0.5px;
            }
            .empty-desc {
                font-size: 1.1rem;
                color: #64748b;
                max-width: 500px;
                margin-bottom: 35px;
                line-height: 1.6;
            }
            .btn-empty-back {
                background-color: transparent;
                color: #64748b;
                border: 1px solid #cbd5e1;
                padding: 12px 32px;
                border-radius: 50px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.2s;
            }
            .btn-empty-back:hover {
                border-color: #94a3b8;
                color: #334155;
                background-color: #f8fafc;
            }

            @media (max-width: 768px) {
                .career-title {
                    font-size: 2.8rem;
                }
                .job-footer {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }
                .btn-apply {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="nav-bar.jsp" />

        <%
            String errorMsg = (String) session.getAttribute("error");
            if (errorMsg != null) {
                session.removeAttribute("error");
        %>
        <div class="toast-container position-fixed start-50 translate-middle-x p-3">
            <div class="toast show align-items-center text-bg-danger border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-exclamation-circle me-2"></i> <%= errorMsg%>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        </div>
        <% }%>

        <div class="career-header">

            <div class="career-content-wrapper">
                <div class="career-icon-box">
                    <i class="fas fa-briefcase" style="font-size: 32px; color: #a5b4fc;"></i>
                </div>
                <h1 class="career-title"><fmt:message key="hero.banner.big.text"/></h1>
                <p class="career-sub">
                    <fmt:message key="hero.banner.small.text"/>
                </p>
            </div>

            <a href="#positions" class="scroll-down-btn">
                <span>View Openings</span>
                <i class="fas fa-chevron-down"></i>
            </a>
        </div>

        <div id="positions" class="jobs-container mb-5">

            <c:choose>

                <%-- CASE 1: JOBS EXIST --%>
                <c:when test="${not empty requestScope.recruitList}">
                    <div class="d-flex justify-content-between align-items-end mb-5 px-2">
                        <h3 class="fw-bold m-0 text-dark" style="font-size: 2rem;"><fmt:message key="position.noti"/></h3>
                        <span class="text-muted fw-bold">${requestScope.recruitList.size()} <fmt:message key="position.available"/></span>
                    </div>

                    <div class="job-list">
                        <c:forEach var="j" items="${requestScope.recruitList}">
                            <div class="job-card">
                                <div class="job-header">
                                    <div class="job-info">
                                        <h4>${j.title}</h4>
                                    </div>
                                </div>

                                <div class="job-desc">
                                    ${j.description}
                                </div>

                                <div class="job-footer">
                                    <div class="date-badge">
                                        <i class="far fa-calendar-alt"></i>
                                        <span>Apply by: ${j.closeDate}</span>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/apply?id=${j.id}" class="btn-apply">
                                        View & Apply <i class="fas fa-arrow-right" style="font-size: 0.9em;"></i>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <%-- CASE 2: NO JOBS (EMPTY LIST) --%>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3 class="empty-title">No openings right now</h3>
                        <p class="empty-desc">
                            We don't have any open positions at the moment, but we are always 
                            looking for talent. Check back soon!
                        </p>
                        <a href="home" class="btn-empty-back">Back to Home</a>
                    </div>
                </c:otherwise>

            </c:choose>

        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const navbar = document.querySelector('.navbar');

                // Function to toggle navbar based on scroll
                function toggleNavbar() {
                    if (window.scrollY > 100) {
                        navbar.classList.add('visible');
                    } else {
                        navbar.classList.remove('visible');
                    }
                }

                // Initial check in case page is refreshed halfway down
                toggleNavbar();

                // Listen for scroll events
                window.addEventListener('scroll', toggleNavbar);
            });
        </script>
    </body>
</html>