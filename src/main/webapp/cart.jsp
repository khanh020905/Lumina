<%@page import="Model.Course"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Cart - Lumina Learning</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            /* --- Global Styles --- */
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }
            :root {
                --primary-purple: #5d3fd3;
                --primary-dark: #1e1b4b;
                --text-dark: #111827;
                --text-muted: #6b7280;
            }

            /* --- Navbar (Same as Home) --- */
            .navbar-custom { background-color: white; border-bottom: 1px solid #e5e7eb; padding: 0.8rem 2.5rem; z-index: 1020; }
            .brand-logo-nav { font-size: 1.3rem; font-weight: 700; color: var(--primary-purple) !important; }
            .nav-link-custom { color: var(--text-muted) !important; font-weight: 500; margin-right: 15px; }
            .nav-link-custom:hover, .nav-link-custom.active { color: var(--primary-purple) !important; }
            .search-input { border-radius: 20px; background-color: #f3f4f6; border: none; padding-left: 40px; width: 300px; }
            .search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); z-index: 5; pointer-events: none; }
            .img-avt { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary-purple); }
            .avatar-dropdown-toggle { border: none; background: none; padding: 0; }

            /* --- PREMIUM DROPDOWN STYLES (Copied from Home) --- */
            .dropdown-menu { border: none; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 10px; min-width: 260px; margin-top: 10px !important; animation: fadeIn 0.2s ease-out; }
            .dropdown-user-info { display: flex; align-items: center; padding: 12px; margin-bottom: 10px; background-color: #f9fafb; border-radius: 10px; border: 1px solid #f3f4f6; }
            .dropdown-user-info img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 12px; border: 2px solid var(--primary-purple); }
            .dropdown-user-details h6 { margin: 0; font-size: 0.95rem; font-weight: 700; color: var(--text-main); }
            .dropdown-user-details span { font-size: 0.8rem; color: var(--text-secondary); }
            .dropdown-item { padding: 10px 15px; font-size: 0.95rem; color: #4b5563; font-weight: 500; border-radius: 8px; margin-bottom: 4px; transition: all 0.2s ease; display: flex; align-items: center; }
            .dropdown-item i { width: 25px; font-size: 1rem; color: #9ca3af; transition: color 0.2s; }
            .dropdown-item:hover { background-color: #f5f3ff; color: var(--primary-purple); transform: translateX(4px); }
            .dropdown-item:hover i { color: var(--primary-purple); }
            .dropdown-item.text-danger:hover { background-color: #fef2f2; color: #dc2626 !important; }
            .dropdown-item.text-danger:hover i { color: #dc2626 !important; }
            .dropdown-divider { margin: 8px 0; border-color: #f3f4f6; }
            @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

            /* --- Cart Specific Styles --- */
            .cart-container { max-width: 1200px; margin: 40px auto; padding: 0 15px; }
            .cart-item-card { background: white; border: 1px solid #e5e7eb; border-radius: 12px; padding: 20px; margin-bottom: 20px; display: flex; align-items: center; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); transform-origin: top; }
            .cart-item-card.removing { opacity: 0; transform: scale(0.95) translateY(-10px); margin-bottom: 0; padding-top: 0; padding-bottom: 0; height: 0; border: none; overflow: hidden; }
            .cart-item-card:hover { box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-color: #d1d5db; }
            .cart-img-wrapper { width: 160px; height: 100px; border-radius: 8px; overflow: hidden; flex-shrink: 0; margin-right: 20px; }
            .cart-img { width: 100%; height: 100%; object-fit: cover; }
            .item-details { flex-grow: 1; }
            .item-title { font-weight: 700; font-size: 1.1rem; color: var(--text-dark); margin-bottom: 5px; text-decoration: none; }
            .item-meta { font-size: 0.9rem; color: var(--text-muted); }
            .item-price { font-weight: 700; font-size: 1.2rem; color: var(--primary-purple); }
            .btn-remove { color: #ef4444; background: #fee2e2; border: none; width: 35px; height: 35px; border-radius: 8px; display: flex; align-items: center; justify-content: center; transition: 0.2s; }
            .btn-remove:hover { background: #ef4444; color: white; }

            /* Right Column: Summary */
            .summary-card { background: white; border: 1px solid #e5e7eb; border-radius: 12px; padding: 25px; position: sticky; top: 100px; }
            .summary-title { font-weight: 700; font-size: 1.2rem; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #f3f4f6; }
            .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; color: var(--text-muted); }
            .summary-total { display: flex; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 2px dashed #e5e7eb; font-weight: 800; font-size: 1.4rem; color: var(--text-dark); }
            .btn-checkout { width: 100%; background-color: var(--primary-purple); color: white; font-weight: 600; padding: 12px; border-radius: 30px; border: none; margin-top: 25px; transition: 0.2s; }
            .btn-checkout:hover { background-color: #4a32a8; transform: translateY(-2px); }
            .empty-cart-state { text-align: center;    padding: 100px 20px;
    margin-bottom: 115px; }
            .empty-icon { font-size: 4rem; color: #e5e7eb; margin-bottom: 20px; }
            .qr-img { max-width: 47%; height: auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
            
            /* --- UPDATED TOAST CSS (Middle Top) --- */
            .toast-container { z-index: 1090 !important; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); min-width: 300px; }
            .toast { font-size: 1rem; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        </style>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String displayName = "Guest";
            String avatarUrl = "https://res.cloudinary.com/drbm6gikx/image/upload/v1765421864/user-account-black-and-white-symbol-microsoft_ghl36j.jpg";

            boolean isLoggedIn = (user != null);
            if (isLoggedIn) {
                if (user.getUsername() != null) displayName = user.getUsername();
                if (user.getUserAvt() != null) avatarUrl = user.getUserAvt();
            }

            List<Course> cartItems = (List<Course>) session.getAttribute("cart");
            if (cartItems == null) cartItems = new ArrayList<>();

            double totalAmount = 0;
            for (Course c : cartItems) {
                totalAmount += c.getPrice();
            }
        %>

        <nav class="navbar navbar-expand-lg navbar-custom sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand brand-logo-nav" href="home"><i class="fas fa-book-open me-2"></i> Lumina</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="courses">Courses</a></li>
                        <li class="nav-item"><a class="nav-link nav-link-custom" href="community.jsp">Community</a></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <div class="position-relative me-4">
                            <i class="fas fa-search search-icon"></i>
                            <form action="courses" method="get">
                                <input class="form-control search-input" type="search" name="search" placeholder="Search courses..." value="<%= (request.getAttribute("searchKeyword") != null) ? request.getAttribute("searchKeyword") : "" %>">
                            </form>
                        </div>
                        
                        <% if (isLoggedIn) {%>
                        <a href="cart.jsp" class="me-4 text-decoration-none position-relative" style="color: #666;">
                            <i class="fas fa-shopping-cart" style="font-size:1.2rem;"></i>
                            <% if(cartItems.size() > 0) { %>
                            <span id="nav-cart-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                                <%= cartItems.size()%>
                            </span>
                            <% } %>
                        </a>

                        <i class="far fa-bell me-4" style="font-size:1.2rem; color:#666; cursor:pointer;"></i>

                        <div class="dropdown">
                            <button class="avatar-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                <img class="img-avt" src="<%=avatarUrl%>" alt="User">
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                
                                <li>
                                    <div class="dropdown-user-info">
                                        <img src="<%=avatarUrl%>" alt="Avatar">
                                        <div class="dropdown-user-details">
                                            <h6><%= displayName%></h6>
                                            <span>Student</span>
                                        </div>
                                    </div>
                                </li>

                                <li><a class="dropdown-item" href="userInfor.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                                <li><a class="dropdown-item" href="myCourses"><i class="fas fa-book"></i> My Learning</a></li>
                                <li><a class="dropdown-item" href="accountSetting.jsp"><i class="fas fa-cog"></i> Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </ul>
                        </div>
                        <% } else { %>
                        <a href="login.jsp" class="btn-login">Login</a>
                        <a href="register.jsp" class="btn-signup">Sign Up</a>
                        <% }%>
                    </div>
                </div>
            </div>
        </nav>

        <div class="cart-container">
            <h2 class="mb-4 fw-bold">Shopping Cart (<span id="cart-count"><%= cartItems.size()%></span>)</h2>

            <% if (cartItems.isEmpty()) { %>
            <div class="empty-cart-state">
                <div class="empty-icon"><i class="fas fa-shopping-basket"></i></div>
                <h3>Your cart is empty</h3>
                <p class="text-muted">Looks like you haven't added any courses yet.</p>
                <a href="courses" style="padding: 12px; background-color: #5D3FD3; border-color: #5D3FD3;" class="btn btn-primary rounded-pill mt-3 px-4">Browse Courses</a>
            </div>
            <% } else { %>

            <div class="row">
                <div class="col-lg-8" id="cart-items-list">
                    <%
                        int index = 0;
                        for (Course c : cartItems) {
                            String img = (c.getImg_url() != null && c.getImg_url().startsWith("http")) ? c.getImg_url() : "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500";
                    %>
                    <div class="cart-item-card" id="item-<%=index%>">
                        <div class="cart-img-wrapper">
                            <img src="<%= img%>" class="cart-img" alt="Course">
                        </div>
                        <div class="item-details">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="badge bg-light text-primary mb-2"><%= c.getCategory()%></div>
                                    <h5 class="item-title"><%= c.getTitle()%></h5>
                                    <div class="item-meta">By Lumina Team • Lifetime Access</div>
                                </div>
                                <button class="btn-remove" onclick="showRemoveModal(<%=index%>, <%= c.getPrice()%>)" title="Remove">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="text-warning small">
                                    <i class="fas fa-star"></i> 4.8
                                </div>
                                <div class="item-price">
                                    <%= String.format("%,.0f", c.getPrice()).replace(',', '.') + ".000"%>đ
                                </div>
                            </div>
                        </div>
                    </div>
                    <% index++; } %>
                </div>

                <div class="col-lg-4">
                    <div class="summary-card">
                        <div class="summary-title">Order Summary</div>
                        <div class="summary-row">
                            <span>Original Price</span>
                            <span id="subtotal"><%= String.format("%,.0f", totalAmount).replace(',', '.') + ".000"%>đ</span>
                        </div>
                        <div class="summary-row">
                            <span>Discounts</span>
                            <span class="text-success">-0đ</span>
                        </div>
                        <div class="input-group mt-4 mb-3">
                            <input type="text" class="form-control" placeholder="Coupon code">
                            <button class="btn btn-outline-secondary" type="button">Apply</button>
                        </div>
                        <div class="summary-total">
                            <span>Total</span>
                            <span class="text-primary" id="final-total"><%= String.format("%,.0f", totalAmount).replace(',', '.') + ".000"%>đ</span>
                        </div>
                        <button type="button" class="btn-checkout d-block w-100 text-center text-decoration-none" data-bs-toggle="modal" data-bs-target="#paymentModal">
                            Checkout Now
                        </button>
                        <div class="text-center mt-3 small text-muted">
                            <i class="fas fa-lock me-1"></i> Secure Checkout
                        </div>
                    </div>
                </div>
            </div>
            <% }%>
        </div>

        <div class="modal fade" id="removeModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold">Remove Course?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center py-4">
                        <i class="fas fa-exclamation-circle text-warning mb-3" style="font-size: 3rem;"></i>
                        <p class="text-muted">Are you sure you want to remove this course from your cart?</p>
                    </div>
                    <div class="modal-footer border-0 justify-content-center pb-4">
                        <button type="button" class="btn btn-light px-4 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger px-4 rounded-pill" id="confirmRemoveBtn">Remove</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="paymentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold text-center w-100">Scan to Pay</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center pb-5">
                        <p class="text-muted mb-4">Please scan the QR code below using your banking app to complete the transaction.</p>
                        <img src="https://res.cloudinary.com/drbm6gikx/image/upload/v1765814030/598127518_715290791264147_169247380268756466_n_haipkm.jpg" alt="Payment QR Code" class="qr-img img-fluid">
                        <div class="mt-4">
                            <h4 class="fw-bold text-primary"><%= String.format("%,.0f", totalAmount).replace(',', '.') + ".000"%>đ</h4>
                            <span class="badge bg-success rounded-pill px-3 py-2">Transfer Content: Lumina Payment</span>
                        </div>
                    </div>
                    <div class="modal-footer border-0 justify-content-center">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button name="paid" onclick="window.location.href='${pageContext.request.contextPath}/paid'" type="button" class="btn btn-primary rounded-pill px-4">I have paid</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="toast-container">
            <div id="liveToast" class="toast align-items-center text-white border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            let itemToRemoveIndex = -1;
            let removeModal;

            document.addEventListener('DOMContentLoaded', function () {
                removeModal = new bootstrap.Modal(document.getElementById('removeModal'));
                document.getElementById('confirmRemoveBtn').addEventListener('click', function () {
                    if (itemToRemoveIndex !== -1) {
                        performRemoval(itemToRemoveIndex);
                        removeModal.hide();
                    }
                });
            });

            function showRemoveModal(index, price) {
                itemToRemoveIndex = index;
                removeModal.show();
            }

            function performRemoval(index) {
                const card = document.getElementById('item-' + index);
                card.classList.add('removing');
                setTimeout(() => {
                    window.location.href = "removeFromCart?index=" + index;
                }, 300);
            }

            // --- TOAST NOTIFICATION LOGIC ---
            window.onload = function () {
                <%
                    String successMsg = (String) session.getAttribute("success");
                    String errorMsg = (String) session.getAttribute("error");
                    if (successMsg != null) session.removeAttribute("success");
                    if (errorMsg != null) session.removeAttribute("error");
                %>
                var successMsg = "<%= (successMsg != null) ? successMsg : ""%>";
                var errorMsg = "<%= (errorMsg != null) ? errorMsg : ""%>";

                var toastEl = document.getElementById('liveToast');
                var toastBody = toastEl.querySelector('.toast-body');
                var toastOptions = {delay: 3000};

                if (successMsg.trim() !== "") {
                    toastEl.classList.remove('bg-danger');
                    toastEl.classList.add('bg-success');
                    toastBody.innerText = successMsg;
                    var toast = new bootstrap.Toast(toastEl, toastOptions);
                    toast.show();
                } else if (errorMsg.trim() !== "") {
                    toastEl.classList.remove('bg-success');
                    toastEl.classList.add('bg-danger');
                    toastBody.innerText = errorMsg;
                    var toast = new bootstrap.Toast(toastEl, toastOptions);
                    toast.show();
                }
            };
        </script>
    </body>
</html>