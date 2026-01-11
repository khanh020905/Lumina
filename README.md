# 🎓 Lumina Learning - Course Management System

![Java](https://img.shields.io/badge/Java-17%2B-orange) ![JSP](https://img.shields.io/badge/JSP-2.3-blue) ![SupaBase](https://img.shields.io/badge/SupaBase-8.0-lightgrey) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen)

**Lumina Learning** is a comprehensive Course Management System designed to streamline the interaction between students and instructors. Built on the robust **Java Servlet** architecture, it features secure authentication, media management, and dynamic course content delivery.

## 🚀 Features

### Core Functionality
* **User Authentication:** Secure login system supporting **Google OAuth 2.0** integration for one-click sign-in.
* **Course Management:** Instructors can create, update, and manage course materials.
* **Media Management:** Seamless file and image uploads powered by **Cloudinary API**.
* **Dynamic Home Page:** Personalized dashboard views for students and admins.
* **Database Integration:** Robust data persistence using **JDBC** and **SupaBase**.

## 🛠️ Tech Stack

**Backend**
* **Language:** Java (JDK 17+)
* **Core Framework:** Java Servlets, Jakarta EE
* **Templating:** JavaServer Pages (JSP), JSTL
* **Database:** SupaBase / PostgreSQL
* **Connectivity:** JDBC (Java Database Connectivity)

**Integrations**
* **Auth:** Google Identity Platform (OAuth 2.0)
* **Storage:** Cloudinary (Image & Video Management)

**Frontend**
* HTML5, CSS3, JavaScript
* Bootstrap (v5.3) for responsive design

## ⚙️ Installation & Setup

### Prerequisites
* [Java Development Kit (JDK) 17+](https://adoptium.net/)
* [Apache Tomcat 9/10](https://tomcat.apache.org/)
* [SupaBase Server](https://dev.SupaBase.com/downloads/installer/)

### 1. Database Configuration
Create a local database named `lumina_db` and import the schema:
```sql
CREATE DATABASE lumina_db;
USE lumina_db;
-- Import schema.sql here
```


2. Environment Variables
Create a src/main/resources/application.properties file (or set system env vars) to configure sensitive keys. Do not commit this file.

Properties
```
# Database
db.url=jdbc:mysql://localhost:3306/lumina_db
db.user=root
db.password=your_password

# Google OAuth
google.client.id=YOUR_GOOGLE_CLIENT_ID
google.client.secret=YOUR_GOOGLE_CLIENT_SECRET
google.redirect.uri=http://localhost:8080/lumina/callback

# Cloudinary
cloudinary.cloud_name=YOUR_CLOUD_NAME
cloudinary.api_key=YOUR_API_KEY
cloudinary.api_secret=YOUR_API_SECRET

```
3. Build and Run
Clone the repository:

Bash
```
git clone [https://github.com/yourusername/lumina-learning.git](https://github.com/yourusername/lumina-learning.git)
Open the project in IntelliJ IDEA or Eclipse.
```
Add the Tomcat Server configuration.

Run the application. Access it at: http://localhost:8080/lumina-learning

📂 Project Structure

```
lumina-learning/
├── src/
│   ├── main/
│   │   ├── java/com/lumina/
│   │   │   ├── controller/   # Servlet controllers (LoginServlet, CourseServlet)
│   │   │   ├── dao/          # Database Access Objects (JDBC logic)
│   │   │   ├── model/        # Java Beans (User, Course)
│   │   │   └── util/         # Helpers (CloudinaryUtil, GoogleAuthUtil)
│   │   └── resources/        # SQL scripts and props
│   └── webapp/
│       ├── WEB-INF/          # Protected views (JSP files)
│       ├── assets/           # CSS, JS, Images
│       └── index.jsp         # Entry point
└── pom.xml                   # Maven dependencies
```
