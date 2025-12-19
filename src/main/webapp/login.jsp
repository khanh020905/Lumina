<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f7f7f7; /* Ensures background is white/light when purple is hidden */
            }

            .main-container {
                display: flex;
                height: 100vh;
                width: 100%;
            }

            /* --- LEFT SIDE (Purple Branding) - Desktop View --- */
            .left-panel {
                flex: 1;
                background-color: #2e1a5b; /* Deep purple base */
                background-image: linear-gradient(rgba(46, 26, 91, 0.9), rgba(46, 26, 91, 0.9)), url('https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80');
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

            /* Hide the social proof element on mobile */
            .social-proof { display: flex; align-items: center; gap: 15px; }
            .avatars { display: flex; }
            .avatars img {
                width: 40px; height: 40px; border-radius: 50%;
                border: 2px solid #2e1a5b; margin-left: -10px;
            }
            .avatars img:first-child { margin-left: 0; }

            /* --- RIGHT SIDE (Login Form) --- */
            .right-panel {
                flex: 1;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px;
                overflow-y: auto; /* Allows scrolling on smaller screens */
            }

            .login-wrapper {
                width: 100%;
                max-width: 420px;
            }

            .login-wrapper h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 10px; }
            .login-wrapper p.subtitle { color: #666; margin-bottom: 30px; }

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
                gap: 10px;
                transition: all 0.2s;
                cursor: pointer;
            }
            .btn-google:hover {
                background-color: #f8f9fa;
                border-color: #ccc;
            }
            .google-icon {
                width: 20px;
                height: 20px;
            }

            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 25px 0;
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

            /* Form Controls */
            .form-label {
                font-weight: 500;
                font-size: 14px;
                color: #333;
            }

            /* Specific tweak for the dark inputs shown in image */
            .custom-input {
                background-color: #333;
                color: white;
                border: 1px solid #444;
                padding: 12px;
                border-radius: 8px;
                width: 100%;
            }

            /* --- START OF PLACEHOLDER COLOR CHANGE --- */
            .custom-input::placeholder {
                color: #fff; 
                opacity: 0.8; 
            }
            /* Cross-browser compatibility for placeholder text */
            .custom-input::-webkit-input-placeholder { color: #fff; opacity: 0.8; } /* Chrome, Safari, Opera */
            .custom-input:-moz-placeholder { color: #fff; opacity: 0.8; } /* Firefox 18- */
            .custom-input::-moz-placeholder { color: #fff; opacity: 0.8; } /* Firefox 19+ */
            .custom-input:-ms-input-placeholder { color: #fff; opacity: 0.8; } /* IE 10+ */
            /* --- END OF PLACEHOLDER COLOR CHANGE --- */

            .custom-input:focus {
                background-color: #333;
                color: white;
                border-color: #666;
                box-shadow: none;
            }

            .password-group { position: relative; }
            .toggle-password {
                position: absolute; right: 15px; top: 50%;
                transform: translateY(-50%); cursor: pointer; color: #888;
            }

            .btn-signin {
                width: 100%;
                background-color: #5d3fd3; /* Bright Purple */
                color: white;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                border: none;
                margin-top: 10px;
            }
            .btn-signin:hover {
                background-color: #4b2ebd;
            }
            .footer-link {
                text-align: center;
                margin-top: 25px;
                font-size: 14px;
                color: #666;
            }
            .footer-link a {
                color: #5d3fd3;
                text-decoration: none;
                font-weight: 600;
            }
            .form-check-label { font-size: 14px; }


            /* --- NEW: MOBILE BANNER (for top of the screen) --- */
            .mobile-banner {
                display: none; /* Hide by default on desktop */
                background-color: #2e1a5b;
                color: white;
                padding: 30px 25px;
            }
            .mobile-banner .brand-logo-mobile {
                font-size: 16px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 10px;
                opacity: 0.8;
            }
            .mobile-banner h1 {
                font-size: 1.8rem;
                font-weight: 700;
                line-height: 1.2;
                margin-bottom: 0;
            }
            .mobile-banner p {
                font-size: 0.9rem;
                opacity: 0.8;
                margin-top: 10px;
            }


            /* 💻 Responsive adjustments: Stack panels vertically on smaller screens (e.g., tablet/mobile) */
            @media (max-width: 900px) {
                .main-container {
                    flex-direction: column; /* Stack vertically */
                    height: auto; /* Allow content to dictate height */
                }

                /* Hide the full left panel */
                .left-panel {
                    display: none;
                }

                /* Show the condensed mobile banner */
                .mobile-banner {
                    display: block;
                }

                .right-panel {
                    flex: none; /* Reset flex */
                    padding: 25px;
                    padding-top: 40px; /* Space between form and top */
                    min-height: calc(100vh - 200px); /* Ensures it takes up min 100vh on mobile */
                }
                
                .login-wrapper {
                    max-width: 100%; /* Use full width on small screens */
                }
            }
        </style>
    </head>
    <body>
        <%
            // Initialize variable to store cookie value
            String rememberedUserKey = "";

            // Get cookies from the request
            Cookie[] cookies = request.getCookies();

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    // Check for the cookie name set in your loginPost method ("rememberme")
                    // If you changed the name to "userCookie", use "userCookie" here.
                    if (cookie.getName().equals("rememberme")) {
                        rememberedUserKey = cookie.getValue();
                        break;
                    }
                }
            }

            String formSubmittedKey = (String) request.getAttribute("userKey");
            if (formSubmittedKey != null) {
                rememberedUserKey = formSubmittedKey;
            }
        %>
        

        <div class="mobile-banner">
            <div class="brand-logo-mobile">
                <i class="fas fa-book-open"></i> Lumina Learning
            </div>
            <h1>Unlock your potential with expert-led courses.</h1>
            <p>Join a community of lifelong learners and master new skills. The journey of a thousand miles begins with a single step.</p>
        </div>

        <div class="main-container">

            <div class="left-panel">
                <div class="brand-logo">
                    <i class="fas fa-book-open"></i> Lumina Learning
                </div>

                <div class="hero-text">
                    <h1>Unlock your potential with expert-led courses.</h1>
                    <p>Join a community of lifelong learners and master new skills. The journey of a thousand miles begins with a single step.</p>
                </div>

                <div class="social-proof">
                    <div class="avatars">
                        <img src="https://i.pravatar.cc/100?img=1" alt="Student">
                        <img src="https://i.pravatar.cc/100?img=5" alt="Student">
                        <img src="https://i.pravatar.cc/100?img=8" alt="Student">
                    </div>
                    <span>Join 40,000+ students today</span>
                </div>
            </div>

            <div class="right-panel">
                <div class="login-wrapper">
                    <h2>Welcome back</h2>
                    <p class="subtitle">Please enter your details to sign in.</p>

                    <button class="btn btn-google" onclick="window.location.href = '<%= request.getContextPath()%>/auth/google'">
                        <img src="https://fonts.gstatic.com/s/i/productlogos/googleg/v6/24px.svg" alt="Google Logo" class="google-icon">
                        <span>Continue with Google</span>
                    </button>


                    <div class="divider">
                        <span>or</span>
                    </div>

                    <form action="login" method="post">
                        <% if (request.getAttribute("error") != null) {%>
                        <div class="alert alert-danger p-2" role="alert" style="font-size: 14px;">
                            <%= request.getAttribute("error")%>
                        </div>
                        <% }%>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control custom-input" id="email" name="userKey" placeholder="you@example.com" required value="<%= rememberedUserKey%>">
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="password-group">
                                <input type="password" class="form-control custom-input" id="password" name="password" placeholder="••••••••" required>
                                <i class="far fa-eye toggle-password" onclick="togglePassword()"></i>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input name="rememberme" class="form-check-input" type="checkbox" id="rememberMe" 
                                    <%= rememberedUserKey != null && !rememberedUserKey.isEmpty() ? "checked" : ""%> >
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <a href="forgot" style="text-decoration: none; font-size: 14px; color: #5d3fd3;">Forgot password?</a>
                        </div>

                        <button type="submit" class="btn btn-signin">Sign in</button>
                    </form>

                    <div class="footer-link">
                        Don't have an account? <a href="register.jsp">Sign up for free</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function togglePassword() {
                var passwordInput = document.getElementById("password");
                var icon = document.querySelector(".toggle-password");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordInput.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>

    </body>
</html>