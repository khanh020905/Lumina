<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Lumina Learning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Shared CSS from Forgot Password Page */
        body, html { height: 100%; margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .main-container { display: flex; height: 100vh; width: 100%; }
        
        /* Left Panel */
        .left-panel {
            flex: 1;
            background-color: #2e1a5b;
            /* Changed image to something security related */
            background-image: linear-gradient(rgba(46, 26, 91, 0.9), rgba(46, 26, 91, 0.9)), url('https://images.unsplash.com/photo-1614064641938-3bbee52942c7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80');
            background-size: cover; background-position: center;
            color: white; padding: 60px;
            display: flex; flex-direction: column; justify-content: center; position: relative;
        }
        .brand-logo { position: absolute; top: 40px; left: 60px; font-size: 20px; font-weight: 600; display: flex; align-items: center; gap: 10px; }
        .hero-text h1 { font-size: 3.5rem; font-weight: 700; line-height: 1.1; margin-bottom: 20px; }
        .hero-text p { font-size: 1.1rem; opacity: 0.9; max-width: 500px; line-height: 1.6; }

        /* Right Panel */
        .right-panel { flex: 1; background: white; display: flex; align-items: center; justify-content: center; padding: 40px; }
        .auth-wrapper { width: 100%; max-width: 400px; }
        
        .icon-circle {
            width: 60px; height: 60px; background-color: #f0f2f5; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #5d3fd3; font-size: 24px; margin-bottom: 20px;
        }
        
        h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 10px; }
        p.subtitle { color: #666; margin-bottom: 30px; font-size: 15px; line-height: 1.5; }
        .highlight-email { color: #5d3fd3; font-weight: 600; }

        .form-label { font-weight: 500; font-size: 14px; color: #333; }
        
        /* Dark Input Style from your design */
        .form-control { 
            padding: 12px; border-radius: 8px; border: 1px solid #444; 
            background-color: #333; color: white; 
        }
        .form-control::placeholder { color: #888; }
        .form-control:focus { background-color: #333; color: white; border-color: #666; box-shadow: none; }

        /* Specific OTP Styling */
        .otp-input {
            text-align: center;
            letter-spacing: 0.5em;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .btn-primary-custom {
            width: 100%; background-color: #5d3fd3; color: white;
            padding: 12px; border-radius: 8px; font-weight: 600; border: none; margin-top: 10px;
        }
        .btn-primary-custom:hover { background-color: #4b2ebd; }

        .resend-link { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }
        .resend-link a { color: #5d3fd3; text-decoration: none; font-weight: 600; }
        .resend-link a:hover { text-decoration: underline; }

        .back-link { text-align: center; margin-top: 15px; }
        .back-link a { color: #666; text-decoration: none; font-size: 14px; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .back-link a:hover { color: #333; }

        /* Alert Styles */
        .alert-custom {
            font-size: 14px; padding: 10px 15px; border-radius: 8px; margin-bottom: 20px; border: none;
        }
        .alert-danger { background-color: #fee2e2; color: #991b1b; }
        .alert-success { background-color: #dcfce7; color: #166534; }

        @media (max-width: 900px) { .left-panel { display: none; } }
    </style>
</head>
<body>

    <%
        // Logic to check session
        String email = (String) session.getAttribute("email");
        String errorMsg = (String) request.getAttribute("error");
        String successMsg = (String) request.getAttribute("success");
        
        if(email == null || email.trim().isEmpty()){
            response.sendRedirect("forgot.jsp");
            return;
        }
    %>

    <div class="main-container">
        <div class="left-panel">
            <div class="brand-logo"><i class="fas fa-book-open"></i> Lumina Learning</div>
            <div class="hero-text">
                <h1>Security comes first.</h1>
                <p>We've sent a secure verification code to your email. Enter it to prove it's really you and regain access to your account.</p>
            </div>
        </div>

        <div class="right-panel">
            <div class="auth-wrapper">
                <div class="icon-circle"><i class="fas fa-envelope-open-text"></i></div>
                <h2>Verify your email</h2>
                <p class="subtitle">
                    We sent a 6-digit code to <br>
                    <span class="highlight-email"><%= email %></span>
                </p>
                
                <% if (errorMsg != null) { %>
                    <div class="alert alert-custom alert-danger d-flex align-items-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <div><%= errorMsg %></div>
                    </div>
                <% } %>
                
                <% if (successMsg != null) { %>
                    <div class="alert alert-custom alert-success d-flex align-items-center" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <div><%= successMsg %></div>
                    </div>
                <% } %>

                <form action="verifyOtp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Verification Code</label>
                        <input type="text" 
                               class="form-control otp-input" 
                               name="otp" 
                               maxlength="6" 
                               placeholder="000000" 
                               pattern="\d{6}"
                               title="Please enter exactly 6 digits"
                               required 
                               autofocus
                               autocomplete="off">
                    </div>
                    <button type="submit" class="btn btn-primary-custom">Verify Code</button>
                </form>
                
                <div class="resend-link">
                    Didn't receive the email? <a href="resendOtp">Click to resend</a>
                </div>

                <div class="back-link">
                    <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to log in</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>