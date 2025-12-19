<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Application Sent - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root { --primary-purple: #5d3fd3; --bg-light: #f8f9fa; }
            body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #111827; }

            .success-container {
                min-height: 80vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            .success-card {
                background: white;
                border-radius: 24px;
                padding: 60px 40px;
                text-align: center;
                max-width: 500px;
                width: 100%;
                box-shadow: 0 20px 40px -10px rgba(0,0,0,0.08);
                position: relative;
                overflow: hidden;
            }
            
            /* Success Icon Animation */
            .icon-circle {
                width: 100px; height: 100px;
                background-color: #d1fae5;
                border-radius: 50%;
                display: flex; align-items: center; justify-content: center;
                margin: 0 auto 30px auto;
                animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            }
            .icon-circle i {
                font-size: 50px; color: #10b981;
            }

            h1 { font-weight: 800; color: #111827; margin-bottom: 15px; }
            p { color: #6b7280; font-size: 1.1rem; line-height: 1.6; margin-bottom: 40px; }

            .btn-home {
                background-color: var(--primary-purple); color: white;
                padding: 14px 35px; border-radius: 50px; font-weight: 600;
                text-decoration: none; transition: 0.3s; display: inline-block;
            }
            .btn-home:hover { background-color: #4338ca; transform: translateY(-2px); color: white; }

            @keyframes popIn {
                0% { transform: scale(0); opacity: 0; }
                100% { transform: scale(1); opacity: 1; }
            }
        </style>
    </head>
    <body>

        <jsp:include page="nav-bar.jsp" />

        <div class="success-container">
            <div class="success-card">
                <div class="icon-circle">
                    <i class="fas fa-check"></i>
                </div>
                
                <h1>Application Sent!</h1>
                <p>
                    Thank you for applying to Lumina Learning. <br>
                    We have received your application and will get back to you shortly via email.
                </p>

                <a href="home" class="btn-home">
                    <i class="fas fa-home me-2"></i> Back to Home
                </a>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>