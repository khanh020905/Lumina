<%@page import="Model.Recruitment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Apply Now - Lumina Learning</title>

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

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-light);
                color: var(--text-dark);
            }

            /* --- HEADER --- */
            .apply-header {
                background: radial-gradient(70% 90% at 50% 0%, #1e1b4b 0%, #0f172a 100%);
                color: white;
                padding: 80px 0 120px 0; /* Extra bottom padding for overlap */
                text-align: center;
                position: relative;
            }

            .back-link {
                position: absolute;
                top: 30px;
                left: 30px;
                color: rgba(255,255,255,0.7);
                text-decoration: none;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: color 0.2s;
            }
            .back-link:hover {
                color: white;
            }

            .job-title-small {
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #a5b4fc;
                font-weight: 700;
                margin-bottom: 10px;
            }
            .page-title {
                font-family: 'Inter', serif;
                font-size: 2.5rem;
                font-weight: 800;
            }

            /* --- FORM CARD --- */
            .form-container {
                max-width: 700px;
                margin: -80px auto 60px auto; /* Negative margin to overlap header */
                background: white;
                border-radius: 20px;
                padding: 40px;
                box-shadow: 0 20px 40px -10px rgba(0,0,0,0.1);
                position: relative;
                z-index: 10;
            }

            /* --- INPUTS --- */
            .form-floating > .form-control {
                border-radius: 12px;
                border: 1px solid #e5e7eb;
                height: 56px;
            }
            .form-floating > .form-control:focus {
                border-color: var(--primary-purple);
                box-shadow: 0 0 0 4px rgba(93, 63, 211, 0.1);
            }
            .form-floating > label {
                color: var(--text-muted);
            }

            .section-label {
                font-size: 0.9rem;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 15px;
                margin-top: 10px;
                display: block;
            }

            .btn-submit {
                background: linear-gradient(135deg, #5d3fd3 0%, #4338ca 100%);
                color: white;
                width: 100%;
                padding: 16px;
                border-radius: 12px;
                font-weight: 700;
                border: none;
                font-size: 1.1rem;
                transition: transform 0.2s;
                margin-top: 20px;
            }
            .btn-submit:hover {
                transform: translateY(-2px);
                color: white;
                box-shadow: 0 10px 20px rgba(93, 63, 211, 0.3);
            }

            /* File/Link Switcher */
            .cv-tip {
                font-size: 0.85rem;
                color: var(--text-muted);
                margin-top: 6px;
                margin-left: 4px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" />
        
        <div class="apply-header">
            <a href="careers" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Careers
            </a>
            <div class="container">
                <div class="job-title-small">Application Form</div>
                <h1 class="page-title">
                    Apply for <span style="color: #a5b4fc;">${job.title}</span>
                </h1>
            </div>
        </div>

        <div class="container">
            <div class="form-container">
                <form action="apply" method="POST">

                    <input type="hidden" name="jobId" value="${job.id}">
                    <input type="hidden" name="action" value="submit">

                    <span class="section-label">Personal Information</span>

                    <div class="row g-3 mb-3">
                        <div class="col-md-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="John Doe" required 
                                       value="${sessionScope.user != null ? sessionScope.user.name : ''}">
                                <label for="fullName">Full Name</label>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required
                                       value="${sessionScope.user != null ? sessionScope.user.email : ''}">
                                <label for="email">Email Address</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="tel" class="form-control" id="phone" name="phone" placeholder="+1234567890" required
                                       value="${sessionScope.user != null ? sessionScope.user.phoneNumber : ''}">
                                <label for="phone">Phone Number</label>
                            </div>
                        </div>
                    </div>

                    <hr style="opacity: 0.1; margin: 30px 0;">

                    <span class="section-label">Resume / CV</span>
                    <div class="mb-4">
                        <div class="form-floating">
                            <input type="url" class="form-control" id="cvUrl" name="cvUrl" placeholder="https://" required>
                            <label for="cvUrl"><i class="fas fa-link me-2"></i>Link to Resume (Google Drive, LinkedIn, etc.)</label>
                        </div>
                        <div class="cv-tip">
                            <i class="fas fa-info-circle me-1"></i> Please make sure the link is accessible (set permissions to "Anyone with the link").
                        </div>
                    </div>

                    <span class="section-label">Cover Letter (Optional)</span>
                    <div class="form-floating mb-3">
                        <textarea class="form-control" placeholder="Leave a comment here" id="coverLetter" name="coverLetter" style="height: 150px"></textarea>
                        <label for="coverLetter">Tell us why you're a great fit...</label>
                    </div>

                    <button type="submit" class="btn-submit">
                        Submit Application <i class="fas fa-paper-plane ms-2"></i>
                    </button>

                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>