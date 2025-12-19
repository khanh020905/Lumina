<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Lumina Learning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Shared CSS for all Auth Pages */
        body, html { height: 100%; margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .main-container { display: flex; height: 100vh; width: 100%; }
        
        /* Left Panel */
        .left-panel {
            flex: 1;
            background-color: #2e1a5b;
            background-image: linear-gradient(rgba(46, 26, 91, 0.9), rgba(46, 26, 91, 0.9)), url('https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80');
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
            width: 50px; height: 50px; background-color: #f0f2f5; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #5d3fd3; font-size: 20px; margin-bottom: 20px;
        }
        
        h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 10px; }
        p.subtitle { color: #666; margin-bottom: 30px; font-size: 15px; }

        .form-label { font-weight: 500; font-size: 14px; color: #333; }
        .form-control { padding: 12px; border-radius: 8px; border: 1px solid #444; background-color: #333; color: white; }
        .form-control::placeholder { color: #888; }
        .form-control:focus { background-color: #333; color: white; border-color: #666; box-shadow: none; }

        .btn-primary-custom {
            width: 100%; background-color: #5d3fd3; color: white;
            padding: 12px; border-radius: 8px; font-weight: 600; border: none; margin-top: 10px;
        }
        .btn-primary-custom:hover { background-color: #4b2ebd; }

        .back-link { text-align: center; margin-top: 25px; }
        .back-link a { color: #666; text-decoration: none; font-size: 14px; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .back-link a:hover { color: #333; }

        /* Error Box Style Override */
        .alert-custom {
            font-size: 14px;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        @media (max-width: 900px) { .left-panel { display: none; } }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="left-panel">
            <div class="brand-logo"><i class="fas fa-book-open"></i> Lumina Learning</div>
            <div class="hero-text">
                <h1>Don't worry, it happens to the best of us.</h1>
                <p>We'll help you recover your account so you can continue learning where you left off.</p>
            </div>
        </div>
        <div class="right-panel">
            <div class="auth-wrapper">
                <div class="icon-circle"><i class="fas fa-key"></i></div>
                <h2>Forgot password?</h2>
                <p class="subtitle">No worries, we'll send you reset instructions.</p>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-custom d-flex align-items-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <div>
                            <%= request.getAttribute("error") %>
                        </div>
                    </div>
                <% } %>
                <form action="forgot" method="post">
                    <div class="mb-3">
                        <label class="form-label">Email address</label>
                        <div class="input-group">
                            <span class="input-group-text" style="background:#333; border-color:#444; color:#888;"><i class="far fa-envelope"></i></span>
                            <input type="email" class="form-control" name="email" placeholder="you@example.com" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary-custom">Send Code</button>
                </form>
                
                <div class="back-link">
                    <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to log in</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>