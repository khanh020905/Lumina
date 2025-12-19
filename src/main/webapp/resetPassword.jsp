<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Lumina Learning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reusing exact styles */
        body, html { height: 100%; margin: 0; font-family: 'Segoe UI', sans-serif; }
        .main-container { display: flex; height: 100vh; }
        .left-panel { flex: 1; background-color: #2e1a5b; color: white; padding: 60px; display: flex; flex-direction: column; justify-content: center;
                      background-image: linear-gradient(rgba(46, 26, 91, 0.9), rgba(46, 26, 91, 0.9)), url('https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80'); background-size: cover; }
        .right-panel { flex: 1; display: flex; align-items: center; justify-content: center; background: white; padding: 40px; }
        .auth-wrapper { width: 100%; max-width: 400px; }
        .icon-circle { width: 50px; height: 50px; background: #f0f2f5; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #5d3fd3; font-size: 20px; margin-bottom: 20px; }
        .form-control { background-color: #333; border: 1px solid #444; color: white; padding: 12px; border-radius: 8px; border-left: none; }
        .input-group-text { background:#333; border-color:#444; color:#888; border-right: none; border-radius: 8px 0 0 8px; }
        .btn-primary-custom { width: 100%; background-color: #5d3fd3; color: white; padding: 12px; border-radius: 8px; border: none; margin-top: 20px; font-weight: 600; }
        
        /* Custom Error Alert Styles */
        .alert-danger-custom { 
            background-color: #f8d7da; 
            color: #721c24; 
            border-color: #f5c6cb;
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px; /* Space below the alert */
        }
        
        @media (max-width: 900px) { .left-panel { display: none; } }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="left-panel">
            <div class="brand-logo" style="position:absolute; top:40px; left:60px; font-weight:600; font-size:20px;">
                <i class="fas fa-book-open"></i> Lumina Learning
            </div>
            <div style="font-size: 3.5rem; font-weight: 700; line-height: 1.1; margin-bottom: 20px;">Secure your account.</div>
            <p style="font-size: 1.1rem; opacity: 0.9; line-height: 1.6;">Create a strong new password to protect your learning progress and account details.</p>
        </div>
        
        <div class="right-panel">
            <div class="auth-wrapper">
                <div class="icon-circle"><i class="fas fa-key"></i></div>
                <h2 style="font-weight: 700; color: #1a1a1a;">Reset Password</h2>
                <p style="color: #666; margin-bottom: 30px;">Enter your new password below.</p>
                
                <% 
                    String errorMessage = (String) request.getAttribute("error");
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                    <div class="alert alert-danger-custom" role="alert" id="error-message">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <%= errorMessage %>
                    </div>
                <% } %>
                <form action="resetPassword" method="post">
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 500; font-size: 14px;">New Password</label>
                        <div class="input-group">
                            <span class="input-group-text" style="background:#333; border-color:#444; color:#888;"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" name="newPassword" placeholder="••••••••" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 500; font-size: 14px;">Confirm Password</label>
                        <div class="input-group">
                            <span class="input-group-text" style="background:#333; border-color:#444; color:#888;"><i class="far fa-check-circle"></i></span>
                            <input type="password" class="form-control" name="confirmPassword" placeholder="••••••••" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary-custom">Reset Password</button>
                </form>
                
                <div style="text-align: center; margin-top: 25px;">
                    <a href="login.jsp" style="color: #666; text-decoration: none; font-size: 14px;"><i class="fas fa-arrow-left"></i> Go back</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>