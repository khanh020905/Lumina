<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Path - Lumina Learning</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #5d3fd3;
            --primary-dark: #1e1b4b;
            --text-dark: #111827;
            --bg-light: #f8f9fa;
            --card-bg: #0f172a;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #020617;
            color: white;
            padding-top: 0 !important;
            overflow-x: hidden;
        }

        /* --- NAVBAR --- */
        .navbar {
            position: fixed !important; top: 0; left: 0; width: 100%; z-index: 1050;
            transform: translateY(-100%);
            transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            background-color: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.08) !important;
            padding-top: 10px !important; padding-bottom: 10px !important;
        }
        .navbar.visible { transform: translateY(0); }

        /* --- HERO --- */
        .path-hero {
            height: 100vh; width: 100%;
            background: radial-gradient(circle at top center, #2e1065 0%, #020617 80%);
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            position: relative; text-align: center; padding: 20px;
        }
        .path-hero::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background-image: radial-gradient(white 1px, transparent 1px);
            background-size: 50px 50px; opacity: 0.1; pointer-events: none;
        }
        .hero-content { z-index: 2; max-width: 900px; animation: fadeUp 1s ease-out; }
        .hero-title {
            font-family: 'Inter', serif; font-size: 3.5rem; font-weight: 800;
            margin-bottom: 20px; line-height: 1.2; text-transform: uppercase;
            background: linear-gradient(to right, #fff, #a5b4fc);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .hero-desc {
            font-size: 1.2rem; color: #cbd5e1; font-weight: 300;
            margin-bottom: 40px; max-width: 700px; margin-left: auto; margin-right: auto;
        }
        .scroll-indicator {
            position: absolute; bottom: 40px; left: 50%; transform: translateX(-50%);
            display: flex; flex-direction: column; align-items: center; gap: 10px;
            cursor: pointer; opacity: 0.7; transition: opacity 0.3s; color: white;
        }
        .scroll-indicator:hover { opacity: 1; }
        .scroll-arrow { font-size: 1.5rem; animation: bounce 2s infinite; }

        @keyframes bounce { 0%, 20%, 50%, 80%, 100% { transform: translateY(0); } 40% { transform: translateY(-10px); } 60% { transform: translateY(-5px); } }
        @keyframes fadeUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }

        /* --- FORM SECTION --- */
        .creator-section { padding: 80px 20px; background-color: #020617; position: relative; }
        .creator-card {
            max-width: 900px; margin: 0 auto;
            background: #0f172a; border: 1px solid #1e293b;
            border-radius: 24px; padding: 40px;
            box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.5);
            position: relative; overflow: visible; /* Changed to visible for dropdowns */
        }
        .form-header { text-align: center; margin-bottom: 40px; position: relative; z-index: 2; }
        .form-title { font-size: 2rem; font-weight: 700; color: white; margin-bottom: 10px; }
        .form-desc { color: #94a3b8; font-size: 1rem; }
        .divider { height: 1px; background: #334155; width: 100%; margin: 20px 0 30px 0; opacity: 0.5; }
        .form-label { color: #e2e8f0; font-weight: 500; margin-bottom: 10px; display: block; }

        /* --- CUSTOM DROPDOWN UI --- */
        .custom-dropdown {
            position: relative;
            width: 100%;
        }

        .dropdown-btn {
            width: 100%;
            padding: 14px 20px;
            background-color: #1e293b;
            border: 1px solid #334155;
            border-radius: 12px;
            color: #94a3b8; /* Placeholder color */
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
            user-select: none;
        }

        /* State when an item is selected */
        .dropdown-btn.has-value {
            color: white;
            border-color: #6366f1; /* Purple border */
            background-color: rgba(30, 41, 59, 0.8);
        }

        .dropdown-btn:hover {
            border-color: #64748b;
        }

        /* The Dropdown Menu List */
        .dropdown-menu-custom {
            position: absolute;
            top: 110%; /* Spacing below button */
            left: 0;
            width: 100%;
            background-color: #1e293b;
            border: 1px solid #334155;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            z-index: 100;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
            max-height: 250px;
            overflow-y: auto;
        }

        /* Show menu when active */
        .custom-dropdown.active .dropdown-menu-custom {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .custom-dropdown.active .dropdown-btn {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        .custom-dropdown.active .chevron-icon {
            transform: rotate(180deg);
        }

        .chevron-icon { transition: transform 0.3s ease; }

        /* Option Items */
        .dropdown-option {
            padding: 12px 20px;
            cursor: pointer;
            color: #cbd5e1;
            transition: background 0.2s;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        .dropdown-option:last-child { border-bottom: none; }

        .dropdown-option:hover {
            background-color: #334155;
            color: white;
        }

        .dropdown-option.selected {
            background-color: #312e81;
            color: #a5b4fc;
            font-weight: 600;
        }

        /* Custom Scrollbar for menu */
        .dropdown-menu-custom::-webkit-scrollbar { width: 6px; }
        .dropdown-menu-custom::-webkit-scrollbar-track { background: #1e293b; border-radius: 10px; }
        .dropdown-menu-custom::-webkit-scrollbar-thumb { background-color: #475569; border-radius: 10px; }

        /* Skills */
        .skills-grid {
            display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            gap: 15px; margin-top: 20px;
        }
        .skill-checkbox { display: none; }
        .skill-pill {
            display: flex; align-items: center; justify-content: center;
            text-align: center; padding: 12px 10px;
            background-color: #1e293b; /* Dark bg */
            color: #cbd5e1; border: 1px solid #334155;
            border-radius: 12px; font-weight: 500; font-size: 0.9rem;
            cursor: pointer; transition: all 0.2s ease; user-select: none;
        }
        .skill-pill:hover { border-color: #64748b; background-color: #334155; color: white; }
        .skill-checkbox:checked + .skill-pill {
            background-color: #4338ca; color: white; border-color: #6366f1;
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.4);
        }

        .btn-create {
            width: 100%; padding: 16px; margin-top: 40px;
            background: linear-gradient(135deg, #1e3a8a 0%, #312e81 100%);
            color: white; font-size: 1.1rem; font-weight: 700;
            border: none; border-radius: 50px;
            cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;
            display: flex; align-items: center; justify-content: center; gap: 10px;
        }
        .btn-create:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(30, 58, 138, 0.4); }

        @media (max-width: 768px) {
            .hero-title { font-size: 2.5rem; }
            .creator-card { padding: 25px; }
            .skills-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body>

<jsp:include page="nav-bar.jsp" />

<div class="path-hero">
    <div class="hero-content">
        <h1 class="hero-title">
            <fmt:message key="hero.banner.big.text1"/><br> <fmt:message key="hero.banner.big.text2"/>
        </h1>
        <p class="hero-desc">
            <fmt:message key="hero.banner.small.text"/>
        </p>
    </div>
    <div class="scroll-indicator" onclick="scrollToCreator()">
        <span>View Path</span>
        <i class="fas fa-chevron-down scroll-arrow"></i>
    </div>
</div>

<div id="creator-section" class="creator-section">
    <div class="creator-card">

        <div class="form-header">
            <h2 class="form-title"><fmt:message key="big.text"/></h2>
            <p class="form-desc"><fmt:message key="small.text"/></p>
            <div class="divider"></div>
        </div>

        <form action="createPath" method="POST">

            <div class="row g-4 mb-4">

                <div class="col-md-6">
                    <label class="form-label"><fmt:message key="semester"/></label>
                    <div class="custom-dropdown" id="dd-semester">
                        <input type="hidden" name="semester" id="input-semester" required>

                        <div class="dropdown-btn" onclick="toggleDropdown('dd-semester')">
                            <span class="selected-text">Select semester...</span>
                            <i class="fas fa-chevron-down chevron-icon"></i>
                        </div>

                        <div class="dropdown-menu-custom">
                            <div name="semester1" class="dropdown-option" onclick="selectOption('dd-semester', '1', 'Semester 1')">Semester 1</div>
                            <div name="semester2" class="dropdown-option" onclick="selectOption('dd-semester', '2', 'Semester 2')">Semester 2</div>
                            <div name="semester3" class="dropdown-option" onclick="selectOption('dd-semester', '3', 'Semester 3')">Semester 3</div>
                            <div name="semester4" class="dropdown-option" onclick="selectOption('dd-semester', '4', 'Semester 4')">Semester 4</div>
                            <div name="semester5" class="dropdown-option" onclick="selectOption('dd-semester', '5', 'Semester 5+')">Semester 5+</div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <label class="form-label"><fmt:message key="targetSpecialization"/></label>
                    <div class="custom-dropdown" id="dd-spec">
                        <input type="hidden" name="specialization" id="input-spec" required>

                        <div class="dropdown-btn" onclick="toggleDropdown('dd-spec')">
                            <span class="selected-text">Select specialization...</span>
                            <i class="fas fa-chevron-down chevron-icon"></i>
                        </div>

                        <div class="dropdown-menu-custom">
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'se', 'Software Engineering')">Software Engineering</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'ai', 'Artificial Intelligence')">Artificial Intelligence</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'web-front', 'Front-end Development')">Front-end Development</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'web-back', 'Back-end Development')">Back-end Development</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'java', 'Deep Java')">Deep Java</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'mobile', 'Mobile App Dev')">Mobile App Dev</div>
                            <div class="dropdown-option" onclick="selectOption('dd-spec', 'data', 'Data Science')">Data Science</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-2">
                <label class="form-label"><fmt:message key="skill"/><span id="skill-count">(0)</span></label>
            </div>

            <div class="skills-grid">
                <%
                    String[] skills = {"C programming", "Java OOP", "Python", "JavaScript", "HTML & CSS",
                            "SQL", "Data Structures", "Algorithms", "Web Development", "Mobile Dev",
                            "Machine Learning", "Database Design", "Git", "Docker", "CI/CD"};
                    for(int i=0; i<skills.length; i++) {
                %>
                <label>
                    <input type="checkbox" name="skills" value="<%= skills[i] %>" class="skill-checkbox" onchange="updateCount()">
                    <div class="skill-pill"><%= skills[i] %></div>
                </label>
                <% } %>
            </div>

            <button type="submit" class="btn-create">
                <i class="fas fa-bolt"></i> Create Path Now
            </button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // --- CUSTOM DROPDOWN LOGIC ---

    function toggleDropdown(id) {
        // Close other dropdowns first
        const allDropdowns = document.querySelectorAll('.custom-dropdown');
        allDropdowns.forEach(dd => {
            if(dd.id !== id) dd.classList.remove('active');
        });

        // Toggle current
        const dropdown = document.getElementById(id);
        dropdown.classList.toggle('active');
    }

    function selectOption(dropdownId, value, text) {
        const dropdown = document.getElementById(dropdownId);
        const input = dropdown.querySelector('input[type="hidden"]');
        const displayText = dropdown.querySelector('.selected-text');
        const btn = dropdown.querySelector('.dropdown-btn');

        // Set values
        input.value = value;
        displayText.innerText = text;

        // Visual Updates
        btn.classList.add('has-value');

        // Remove 'selected' class from all options
        const options = dropdown.querySelectorAll('.dropdown-option');
        options.forEach(opt => opt.classList.remove('selected'));

        // Add 'selected' to clicked option (via event target logic, simplified here)
        event.target.classList.add('selected');

        // Close dropdown
        dropdown.classList.remove('active');
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.custom-dropdown')) {
            document.querySelectorAll('.custom-dropdown').forEach(dd => {
                dd.classList.remove('active');
            });
        }
    });

    // --- EXISTING LOGIC ---
    function scrollToCreator() {
        document.getElementById('creator-section').scrollIntoView({ behavior: 'smooth' });
    }

    function updateCount() {
        const checkboxes = document.querySelectorAll('.skill-checkbox:checked');
        document.getElementById('skill-count').innerText = '(' + checkboxes.length + ')';
    }

    document.addEventListener("DOMContentLoaded", function () {
        const navbar = document.querySelector('.navbar');
        function toggleNavbar() {
            if (window.scrollY > 100) {
                navbar.classList.add('visible');
            } else {
                navbar.classList.remove('visible');
            }
        }
        toggleNavbar();
        window.addEventListener('scroll', toggleNavbar);
    });
</script>
</body>
</html>