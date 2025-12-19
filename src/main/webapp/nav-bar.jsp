<%-- navbar.jsp --%>
<%@page import="Model.User"%>
<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<style>
    /* NAVBAR & GLOBAL VARIABLES */
:root {
    --primary-purple: #5d3fd3;
    --primary-dark: #1e1b4b;
    --text-dark: #111827;
    --text-muted: #6b7280;
    --toggle-bg: #e0e0e0;
    --toggle-knob-bg: #f0f0f0;
    --toggle-text: #666;
    --toggle-active-text: #333;
}

.navbar-custom { background-color: white; border-bottom: 1px solid #e5e7eb; padding: 0.8rem 2.5rem; z-index: 1020; }
.brand-logo-nav { font-size: 1.3rem; font-weight: 700; color: var(--primary-purple) !important; }
.nav-link-custom { color: var(--text-muted) !important; font-weight: 500; margin-right: 15px; }
.nav-link-custom:hover, .nav-link-custom.active { color: var(--primary-purple) !important; }

.search-input { border-radius: 20px; background-color: #f3f4f6; border: none; padding-left: 40px; width: 300px; }
.search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); z-index: 5; pointer-events: none; }

/* LANGUAGE TOGGLE */
.lang-toggle-container { display: flex; align-items: center; background-color: var(--toggle-bg); border-radius: 30px; padding: 3px; position: relative; cursor: pointer; width: 72px; height: 30px; box-shadow: inset 0 1px 3px rgba(0,0,0,0.1); margin-right: 20px; }
.lang-toggle-knob { position: absolute; top: 3px; left: 3px; width: 24px; height: 24px; background-color: var(--toggle-knob-bg); border-radius: 50%; box-shadow: 0 1px 3px rgba(0,0,0,0.2); transition: transform 0.3s cubic-bezier(0.4, 0.0, 0.2, 1); display: flex; align-items: center; justify-content: center; z-index: 2; }
.lang-toggle-knob .fi { font-size: 0.9rem; line-height: 1; border-radius: 50%; width: 1em; height: 1em; object-fit: cover; }
.lang-option { flex: 1; text-align: center; font-weight: 700; color: var(--toggle-text); font-size: 0.7rem; z-index: 1; transition: color 0.3s; padding: 0 2px; line-height: 1; }
.lang-option.active { color: var(--primary-purple); }
.lang-toggle-container.vi-active .lang-toggle-knob { transform: translateX(42px); }
.lang-toggle-container.vi-active .lang-option-en { color: var(--toggle-text); }
.lang-toggle-container.vi-active .lang-option-vi { color: var(--primary-purple); }
#langSwitch { display: none; }

/* DROPDOWN & BUTTONS */
.dropdown-menu { border: none; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 10px; min-width: 260px; margin-top: 10px !important; animation: fadeIn 0.2s ease-out; }
.dropdown-user-info { display: flex; align-items: center; padding: 12px; margin-bottom: 10px; background-color: #f9fafb; border-radius: 10px; border: 1px solid #f3f4f6; }
.dropdown-user-info img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 12px; border: 2px solid var(--primary-purple); }
.dropdown-user-details h6 { margin: 0; font-size: 0.95rem; font-weight: 700; color: var(--text-dark); }
.dropdown-user-details span { font-size: 0.8rem; color: var(--text-muted); }
.dropdown-item { padding: 10px 15px; font-size: 0.95rem; color: #4b5563; font-weight: 500; border-radius: 8px; margin-bottom: 4px; transition: all 0.2s ease; display: flex; align-items: center; }
.dropdown-item i { width: 25px; font-size: 1rem; color: #9ca3af; transition: color 0.2s; }
.dropdown-item:hover { background-color: #f5f3ff; color: var(--primary-purple); transform: translateX(4px); }
.dropdown-item:hover i { color: var(--primary-purple); }
.dropdown-item.text-danger:hover { background-color: #fef2f2; color: #dc2626 !important; }
.dropdown-item.text-danger:hover i { color: #dc2626 !important; }
.dropdown-divider { margin: 8px 0; border-color: #f3f4f6; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

.btn-login { color: var(--primary-purple); border: 1px solid var(--primary-purple); border-radius: 20px; padding: 5px 20px; text-decoration: none; font-weight: 600; transition: 0.2s; }
.btn-login:hover { background-color: #f0f0ff; }
.btn-signup { background-color: var(--primary-purple); color: white; border-radius: 20px; padding: 6px 20px; text-decoration: none; font-weight: 600; margin-left: 10px; transition: 0.2s; }
.btn-signup:hover { background-color: #4a32a8; color: white; }
.img-avt { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary-purple); }
.avatar-dropdown-toggle { border: none; background: none; padding: 0; }
</style>

<%
    // 1. User Session Logic
    User navUser = (User) session.getAttribute("user"); // Renamed to navUser to avoid conflict
    boolean navIsLoggedIn = (navUser != null);
    String navDisplayName = "Guest";
    String navAvatarUrl = "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";

    if (navIsLoggedIn) {
        if (navUser.getUsername() != null) {
            navDisplayName = navUser.getUsername();
        }
        if (navUser.getUserAvt() != null) {
            navAvatarUrl = navUser.getUserAvt();
        }
    }

    // 2. Language Session Logic
    String navCurrentLang = (String) session.getAttribute("lang");
    if(navCurrentLang == null) navCurrentLang = "en"; 
    boolean navIsVi = "vi".equals(navCurrentLang);

    // 3. Cart Logic
    List<Course> navCartItems = (List<Course>) session.getAttribute("cart");
    int navCartCount = (navCartItems != null) ? navCartItems.size() : 0;
%>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand brand-logo-nav" href="home"><i class="fas fa-book-open me-2"></i> Lumina</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="dashboard.jsp">
                        <fmt:message key="nav.dashboard" />
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="courses">
                        <fmt:message key="nav.courses" />
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="community.jsp">
                        <fmt:message key="nav.community" />
                    </a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <div class="position-relative me-4">
                    <i class="fas fa-search search-icon"></i>
                    <form action="courses" method="get">
                        <input class="form-control search-input" type="search" name="search" placeholder="Search courses..." value="<%= (request.getAttribute("searchKeyword") != null) ? request.getAttribute("searchKeyword") : ""%>">
                    </form>
                </div>

                <div class="lang-toggle-container <%= navIsVi ? "vi-active" : "" %>" onclick="toggleLanguage('<%= navIsVi ? "en" : "vi" %>')">
                    <div class="lang-toggle-knob">
                        <span class="fi fi-<%= navIsVi ? "vn" : "us" %>"></span>
                    </div>
                    <span class="lang-option lang-option-en <%= !navIsVi ? "active" : "" %>">EN</span>
                    <span class="lang-option lang-option-vi <%= navIsVi ? "active" : "" %>">VI</span>
                    <input type="checkbox" id="langSwitch" <%= navIsVi ? "checked" : "" %>>
                </div>

                <% if (navIsLoggedIn) { %>
                <a href="cart.jsp" class="me-4 text-decoration-none position-relative" style="color: #666;">
                    <i class="fas fa-shopping-cart" style="font-size:1.2rem;"></i>
                    <% if (navCartCount > 0) { %>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                        <%= navCartCount %>
                    </span>
                    <% } %>
                </a>

                <i class="far fa-bell me-4" style="font-size:1.2rem; color:#666; cursor:pointer;"></i>
                <div class="dropdown">
                    <button class="avatar-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <img class="img-avt" src="<%= navAvatarUrl %>" alt="User">
                    </button>

                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <div class="dropdown-user-info">
                                <img src="<%= navAvatarUrl %>" alt="Avatar">
                                <div class="dropdown-user-details">
                                    <h6><%= navDisplayName %></h6>
                                    <span>Student</span>
                                </div>
                            </div>
                        </li>
                        <li><a class="dropdown-item" href="userInfor.jsp"><i class="far fa-user"></i> <fmt:message key="nav.myProfile"/></a></li>
                        <li><a class="dropdown-item" href="myCourses"><i class="fas fa-book me-2"></i> <fmt:message key="nav.myLearning"/></a></li>
                        <li><a class="dropdown-item" href="accountSetting.jsp"><i class="fas fa-cog"></i> <fmt:message key="nav.setting"/></a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> <fmt:message key="nav.logout"/></a></li>
                    </ul>
                </div>
                <% } else { %>
                <a href="login.jsp" class="btn-login"><fmt:message key="nav.login" /></a>
                <a href="register.jsp" class="btn-signup"><fmt:message key="nav.signup" /></a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<script>
    function toggleLanguage(lang) {
        window.location.href = 'language?lang=' + lang;
    }
</script>