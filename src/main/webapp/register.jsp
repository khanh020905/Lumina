<%@page import="Model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            /* --- Your existing CSS styles remain here --- */
            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-container {
                display: flex;
                height: 100vh;
                width: 100%;
            }

            /* --- LEFT SIDE (Purple Branding) --- */
            .left-panel {
                flex: 1;
                background-color: #2e1a5b;
                /* Background image similar to your design */
                background-image: linear-gradient(rgba(46, 26, 91, 0.85), rgba(46, 26, 91, 0.85)), url('https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 60px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                position: relative;
            }

            .brand-logo {
                position: absolute;
                top: 40px;
                left: 60px;
                font-size: 20px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .hero-text h1 {
                font-size: 3.5rem;
                font-weight: 700;
                line-height: 1.1;
                margin-bottom: 20px;
            }

            .hero-text p {
                font-size: 1.1rem;
                opacity: 0.9;
                max-width: 500px;
                margin-bottom: 40px;
                line-height: 1.6;
            }

            .social-proof {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .avatars {
                display: flex;
            }
            .avatars img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid #2e1a5b;
                margin-left: -10px;
            }
            .avatars img:first-child {
                margin-left: 0;
            }

            /* --- RIGHT SIDE (Register Form) --- */
            .right-panel {
                flex: 1;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px;
                overflow-y: auto; /* Allow scrolling on small screens */
            }

            .login-wrapper {
                width: 100%;
                max-width: 420px;
            }

            .login-wrapper h2 {
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 5px;
            }

            .login-wrapper p.subtitle {
                color: #666;
                margin-bottom: 25px;
            }

            /* Google Button */
            .btn-google {
                width: 100%;
                background: white;
                border: 1px solid #ddd;
                color: #333;
                font-weight: 500;
                padding: 10px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                transition: all 0.2s;
                cursor: pointer;
            }
            .btn-google:hover {
                background-color: #f8f9fa;
                border-color: #c1c1c1;
            }
            .google-icon {
                width: 20px;
                height: 20px;
            }

            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 20px 0;
                color: #aaa;
                font-size: 14px;
            }
            .divider::before, .divider::after {
                content: '';
                flex: 1;
                border-bottom: 1px solid #eee;
            }
            .divider span {
                padding: 0 10px;
            }

            /* Custom Dark Inputs */
            .form-label {
                font-weight: 500;
                font-size: 14px;
                color: #333;
                margin-bottom: 5px;
            }

            .input-group-text {
                background-color: #333; /* Dark background matching input */
                border: 1px solid #444;
                border-right: none;
                color: #888;
            }

            .form-control.custom-input {
                padding: 12px;
                background-color: #333; /* Dark grey background */
                color: white;
                border: 1px solid #444;
                border-left: none; /* Merge with icon */
            }
            .form-control.custom-input:focus {
                background-color: #333;
                color: white;
                border-color: #666;
                box-shadow: none;
            }
            .form-control.custom-input::placeholder {
                color: #777;
            }

            /* Fix border radius for input groups */
            .input-group .input-group-text {
                border-radius: 8px 0 0 8px;
            }
            .input-group .form-control {
                border-radius: 0 8px 8px 0;
            }

            .btn-signup {
                width: 100%;
                background-color: #5d3fd3; /* Bright Purple */
                color: white;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                border: none;
                margin-top: 20px;
            }
            .btn-signup:hover {
                background-color: #4b2ebd;
            }

            .footer-link {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }
            .footer-link a {
                color: #5d3fd3;
                text-decoration: none;
                font-weight: 600;
            }

            /* Checkbox styling */
            .form-check-label {
                font-size: 14px;
                color: #555;
            }

            /* Mobile Responsive */
            @media (max-width: 900px) {
                .left-panel {
                    display: none;
                }
                .right-panel {
                    flex: 1;
                }
            }
        </style>
    </head>
    <body>

        <div class="main-container">

            <%
                User user = (User) session.getAttribute("createdUser");
                if (user != null) {
            %>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const successMessage = document.getElementById('success-message');
                    if (successMessage) {
                        successMessage.style.display = 'block';
                    }

                    setTimeout(function () {
                        window.location.href = 'login.jsp';
                    }, 1000);
                });
            </script>
            <%
                    session.removeAttribute("createdUser");
                }
            %>
            <div class="left-panel">
                <div class="brand-logo">
                    <i class="fas fa-book-open"></i> Lumina Learning
                </div>

                <div class="hero-text">
                    <h1>Start your journey of lifelong learning.</h1>
                    <p>Create an account to access thousands of courses, track your progress, and earn certificates.</p>
                </div>

                <div class="social-proof">
                    <div class="avatars">
                        <img src="https://i.pravatar.cc/100?img=12" alt="Student">
                        <img src="https://i.pravatar.cc/100?img=25" alt="Student">
                        <img src="https://i.pravatar.cc/100?img=33" alt="Student">
                    </div>
                    <span>Join 40,000+ students today</span>
                </div>
            </div>

            <div class="right-panel">
                <div class="login-wrapper">
                    <h2>Create an account</h2>
                    <p class="subtitle">Join thousands of learners today.</p>

                    <div id="success-message" class="alert alert-success" role="alert" style="display:none; font-size: 14px;">
                        Account created successfully! Redirecting to login...
                    </div>

                    <button class="btn btn-google">
                        <img src="https://fonts.gstatic.com/s/i/productlogos/googleg/v6/24px.svg" alt="Google Logo" class="google-icon">
                        <span>Sign up with Google</span>
                    </button>

                    <div class="divider">
                        <span>or</span>
                    </div>

                    <form action="register" method="post">
                        <% if (request.getAttribute("error") != null) {%>
                        <div class="alert alert-danger p-2" role="alert" style="font-size: 14px;">
                            <%= request.getAttribute("error")%>
                        </div>
                        <% }%>

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="far fa-user"></i></span>
                                <input type="text" class="form-control custom-input" name="username" placeholder="Jane Doe" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="far fa-envelope"></i></span>
                                <input type="email" class="form-control custom-input" name="email" placeholder="you@example.com" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="text" class="form-control custom-input" name="phone" placeholder="0123 456 789">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control custom-input" id="password" name="password" placeholder="••••••••" required>
                                <span class="input-group-text" style="cursor: pointer; border-left: none; border-radius: 0 8px 8px 0;" onclick="togglePassword('password')">
                                    <i class="far fa-eye"></i>
                                </span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-signup">Create account</button>
                    </form>

                    <div class="footer-link">
                        Already have an account? <a href="login.jsp">Log in</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function togglePassword(fieldId) {
                var input = document.getElementById(fieldId);
                var icon = input.nextElementSibling.querySelector('i');

                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    input.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>

    </body>
</html>