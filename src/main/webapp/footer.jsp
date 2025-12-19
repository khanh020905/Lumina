<%-- footer.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="messages"/>

<style>
    /* --- FOOTER STYLES --- */
    .site-footer {
        background-color: #ffffff;
        padding: 60px 0 30px 0;
        border-top: 1px solid #e5e7eb;
        font-family: 'Segoe UI', 'Roboto', sans-serif;
        color: #6b7280;
        font-size: 14px;
        margin-top: auto;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .footer-top {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr 1fr;
        gap: 40px;
        margin-bottom: 40px;
    }

    .footer-brand-logo {
        display: flex;
        align-items: center;
        font-size: 22px;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 16px;
        text-decoration: none;
    }

    .footer-desc {
        line-height: 1.6;
        max-width: 300px;
        color: #6b7280;
    }

    .footer-col h5 {
        font-size: 14px;
        font-weight: 600;
        color: #111827;
        margin-bottom: 20px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links a {
        color: #6b7280;
        text-decoration: none;
        transition: color 0.2s;
    }

    .footer-links a:hover {
        color: #6a1b9a; /* Lumina Purple */
    }

    .footer-bottom {
        border-top: 1px solid #f3f4f6;
        padding-top: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .social-icons {
        display: flex;
        gap: 20px;
    }

    .social-icons a {
        color: #9ca3af;
        font-size: 18px;
        transition: color 0.2s;
    }

    .social-icons a:hover {
        color: #6a1b9a;
    }

    @media (max-width: 768px) {
        .footer-top {
            grid-template-columns: 1fr;
            gap: 30px;
        }
        .footer-bottom {
            flex-direction: column-reverse;
            gap: 20px;
            text-align: center;
        }
    }

    /* --- MODERN CHATBOT UI --- */
    :root {
        --chat-primary: #6a1b9a;       /* Lumina Purple */
        --chat-primary-dark: #4a148c;  /* Darker Purple */
        --chat-gradient: linear-gradient(135deg, #6a1b9a, #4a148c);
        --chat-bg: #ffffff;
        --chat-font: 'Segoe UI', 'Roboto', sans-serif;
    }

    /* 1. Toggle Button */
    .chat-widget-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background: var(--chat-gradient);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 26px;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(106, 27, 154, 0.4);
        transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        z-index: 9999;
    }
    .chat-widget-btn:hover {
        transform: scale(1.1) rotate(-10deg);
    }

    /* 2. Main Chat Container */
    .chat-box-container {
        position: fixed;
        bottom: 100px;
        right: 30px;
        width: 380px;
        height: 500px;       /* Fixed height */
        max-height: 70vh;    /* Responsive max-height */
        background: var(--chat-bg);
        border-radius: 20px;
        box-shadow: 0 12px 40px rgba(0,0,0,0.15);
        display: none; 
        flex-direction: column;
        z-index: 9999;
        overflow: hidden;
        border: 1px solid rgba(0,0,0,0.08);
        font-family: var(--chat-font);
        transform-origin: bottom right;
        animation: chatPopup 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    }

    @keyframes chatPopup {
        from { opacity: 0; transform: scale(0.9) translateY(20px); }
        to { opacity: 1; transform: scale(1) translateY(0); }
    }

    /* 3. Header */
    .chat-header {
        background: var(--chat-gradient);
        color: white;
        padding: 18px 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }
    .chat-header h6 {
        margin: 0;
        font-weight: 700;
        font-size: 1.1rem;
        letter-spacing: 0.5px;
    }
    .btn-close-chat {
        background: rgba(255,255,255,0.2);
        border: none;
        color: white;
        width: 32px;
        height: 32px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-close-chat:hover { background: rgba(255,255,255,0.4); }

    /* 4. Chat Body */
    .chat-body {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        background-color: #f4f6f9;
        display: flex;
        flex-direction: column;
        gap: 15px;
        scroll-behavior: smooth;
    }
    .chat-body::-webkit-scrollbar { width: 5px; }
    .chat-body::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }

    /* 5. Messages */
    .chat-message {
        max-width: 85%;
        padding: 12px 16px;
        border-radius: 18px;
        font-size: 0.95rem;
        line-height: 1.6;
        position: relative;
        word-wrap: break-word;
        animation: messageSlide 0.3s ease-out;
    }
    @keyframes messageSlide {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .bot-message {
        align-self: flex-start;
        background-color: white;
        color: #333;
        border-bottom-left-radius: 4px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        border: 1px solid #eee;
    }

    .user-message {
        align-self: flex-end;
        background: var(--chat-gradient);
        color: white;
        border-bottom-right-radius: 4px;
        box-shadow: 0 4px 12px rgba(106, 27, 154, 0.2);
    }

    /* Code Blocks & Tables */
    .bot-message pre {
        background: #1e1e1e;
        color: #e0e0e0;
        padding: 40px 15px 15px 15px;
        border-radius: 8px;
        overflow-x: auto;
        position: relative;
        margin: 10px 0;
        font-family: 'Consolas', 'Monaco', monospace;
        font-size: 0.85em;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    }
    .bot-message pre::before {
        content: "● ● ●";
        position: absolute;
        top: 12px;
        left: 15px;
        color: #ff5f56;
        font-size: 14px;
        letter-spacing: 4px;
        text-shadow: 18px 0 #ffbd2e, 36px 0 #27c93f;
    }
    .bot-message :not(pre) > code {
        background: rgba(106, 27, 154, 0.1);
        color: #6a1b9a;
        padding: 2px 6px;
        border-radius: 4px;
        font-family: monospace;
        font-weight: 700;
        font-size: 0.9em;
    }
    .user-message code { background: rgba(255,255,255,0.2); color: white; }
    .table-wrapper { width: 100%; overflow-x: auto; margin: 10px 0; border: 1px solid #eee; border-radius: 8px; }
    .bot-message table { width: 100%; border-collapse: collapse; background: white; font-size: 0.9em; }
    .bot-message th { background: #f3e5f5; color: #4a148c; padding: 10px; text-align: left; }
    .bot-message td { padding: 8px; border-top: 1px solid #eee; }

    /* 6. Footer & Input */
    .chat-footer {
        padding: 15px 20px;
        background: white;
        border-top: 1px solid #f0f0f0;
    }
    .input-group-pill {
        background: #f0f2f5;
        border-radius: 30px;
        padding: 5px 8px 5px 20px;
        display: flex;
        align-items: center;
        border: 1px solid transparent;
        transition: all 0.2s;
    }
    .input-group-pill:focus-within {
        background: white;
        border-color: #6a1b9a;
        box-shadow: 0 0 0 4px rgba(106, 27, 154, 0.1);
    }
    .chat-input {
        flex: 1;
        background: transparent;
        border: none;
        outline: none;
        font-size: 14px;
        color: #333;
        padding-right: 10px;
    }
    .btn-send-pill {
        width: 40px;
        height: 40px;
        background: var(--chat-primary);
        border: none;
        border-radius: 50%;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: transform 0.2s, background 0.2s;
    }
    .btn-send-pill:hover {
        background: var(--chat-primary-dark);
        transform: scale(1.1);
    }

    /* 7. Typing Indicator */
    .typing-indicator {
        display: none; /* Changed via JS to flex */
        align-items: center;
        padding: 12px 18px;
        background: white;
        border-radius: 18px;
        border-bottom-left-radius: 4px;
        width: fit-content;
        margin-bottom: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    .dot {
        display: inline-block;
        width: 6px; 
        height: 6px; 
        background: #bbb; 
        border-radius: 50%;
        margin: 0 2px;
        animation: typing 1.4s infinite ease-in-out both;
    }
    .dot:nth-child(1){animation-delay: -0.32s;}
    .dot:nth-child(2){animation-delay: -0.16s;}
    @keyframes typing { 
        0%, 80%, 100% { transform: scale(0); } 
        40% { transform: scale(1); } 
    }
</style>

<footer class="site-footer">
    <div class="footer-container">
        
        <div class="footer-top">
            <div class="footer-col">
                <a style="font-size: 25px; color: #5d3fd3" href="#" class="footer-brand-logo">
                    <i class="fas fa-book-open me-2"></i> Lumina
                </a>
                <p class="footer-desc">
                    Empowering learners worldwide with accessible, high-quality education. Join our community today.
                </p>
            </div>

            <div class="footer-col">
                <h5>Platform</h5>
                <ul class="footer-links">
                    <li><a href="#">Browse Courses</a></li>
                    <li><a href="#">Mentorship</a></li>
                    <li><a href="#">Pricing</a></li>
                    <li><a href="#">For Business</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h5>Company</h5>
                <ul class="footer-links">
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h5>Legal</h5>
                <ul class="footer-links">
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                    <li><a href="#">Accessibility</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="copyright">
                &copy; 2024 Lumina Learning Inc. All rights reserved.
            </div>
            <div class="social-icons">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            </div>
        </div>

    </div>

    <div class="chat-widget-btn" id="chatToggleBtn" onclick="toggleChat()">
        <i class="fas fa-comment-dots"></i>
    </div>

    <div class="chat-box-container" id="chatBox">
        <div class="chat-header">
            <div class="d-flex align-items-center gap-2">
                <i class="fas fa-robot fa-lg"></i>
                <h6>Lumina AI</h6>
            </div>
            <button onclick="toggleChat()" class="btn-close-chat">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="chat-message bot-message">
                <fmt:message key="chatbot.helloMessage"/>
            </div>
        </div>

        <div class="typing-indicator" id="typingIndicator">
            <div class="dot"></div><div class="dot"></div><div class="dot"></div>
        </div>

        <div class="chat-footer">
            <div class="input-group-pill">
                <input type="text" id="userMessage" class="chat-input" 
                       placeholder="Type a message..." autocomplete="off"
                       onkeypress="handleEnter(event)">
                <button onclick="sendMessage()" class="btn-send-pill">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script>
    const chatBox = document.getElementById('chatBox');
    const toggleBtn = document.getElementById('chatToggleBtn');
    const inputField = document.getElementById('userMessage');
    const chatBody = document.getElementById('chatBody');
    const typingIndicator = document.getElementById('typingIndicator');

    function toggleChat() {
        if (chatBox.style.display === 'none' || chatBox.style.display === '') {
            chatBox.style.display = 'flex';
            toggleBtn.style.transform = 'scale(0)';
            setTimeout(() => inputField.focus(), 100);
        } else {
            chatBox.style.display = 'none';
            toggleBtn.style.transform = 'scale(1)';
        }
    }

    document.addEventListener('click', function (e) {
        if (chatBox.style.display === 'flex' && 
            !chatBox.contains(e.target) && 
            !toggleBtn.contains(e.target)) {
            toggleChat();
        }
    });

    function handleEnter(e) {
        if (e.key === 'Enter') sendMessage();
    }

    async function sendMessage() {
        const text = inputField.value.trim();
        if (!text) return;

        addMessage(text, 'user-message');
        inputField.value = '';
        scrollToBottom();

        // Show Loading (Using flex to ensure horizontal alignment)
        chatBody.appendChild(typingIndicator);
        typingIndicator.style.display = 'flex'; 
        scrollToBottom();

        try {
            const response = await fetch('api/chat', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'message=' + encodeURIComponent(text)
            });

            const data = await response.text();
            
            typingIndicator.style.display = 'none';
            addMessage(data, 'bot-message');

        } catch (error) {
            typingIndicator.style.display = 'none';
            addMessage("**System Error:** Unable to connect to Lumina Server.", 'bot-message');
            console.error(error);
        }
    }

    function addMessage(text, className) {
        const div = document.createElement('div');
        div.className = 'chat-message ' + className;
        
        let htmlContent = marked.parse(text);
        htmlContent = htmlContent.replace(/<table/g, '<div class="table-wrapper"><table');
        htmlContent = htmlContent.replace(/<\/table>/g, '</table></div>');

        div.innerHTML = htmlContent;
        chatBody.appendChild(div);
        scrollToBottom();
    }

    function scrollToBottom() {
        chatBody.scrollTo({
            top: chatBody.scrollHeight,
            behavior: 'smooth'
        });
    }
</script>