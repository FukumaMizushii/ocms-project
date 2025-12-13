<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brilliantacademy.dao.UserDAO, com.brilliantacademy.dao.CourseDAO, com.brilliantacademy.model.User, com.brilliantacademy.model.Course, java.util.List" %>
<%
	// prevent back button after logout 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    // Check if user is logged in and is admin
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' style='vertical-align: text-top; width: 2rem; fill: %23FFD700'>
                            <path d='M368.5 18.3l-50.1 50.1 125.3 125.3 50.1-50.1c21.9-21.9 21.9-57.3 0-79.2L447.7 18.3c-21.9-21.9-57.3-21.9-79.2 0zM279.3 97.2l-.5 .1-144.1 43.2c-19.9 6-35.7 21.2-42.3 41L3.8 445.8c-2.9 8.7-1.9 18.2 2.5 26L161.7 316.4c-1.1-4-1.6-8.1-1.6-12.4 0-26.5 21.5-48 48-48s48 21.5 48 48-21.5 48-48 48c-4.3 0-8.5-.6-12.4-1.6L40.3 505.7c7.8 4.4 17.2 5.4 26 2.5l264.3-88.6c19.7-6.6 35-22.4 41-42.3l43.2-144.1 .1-.5-135.5-135.5z' />
                        </svg>" type="image/svg+xml">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="nav-container">
                <div class="nav-panel">
                    <h2>Admin Panel</h2>
                </div>
                <div class="nav-title">
                    <h1>
                        Brilliant Academy
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="vertical-align: text-top; width: 2rem;fill: #FFD700">
                            <path d="M368.5 18.3l-50.1 50.1 125.3 125.3 50.1-50.1c21.9-21.9 21.9-57.3 0-79.2L447.7 18.3c-21.9-21.9-57.3-21.9-79.2 0zM279.3 97.2l-.5 .1-144.1 43.2c-19.9 6-35.7 21.2-42.3 41L3.8 445.8c-2.9 8.7-1.9 18.2 2.5 26L161.7 316.4c-1.1-4-1.6-8.1-1.6-12.4 0-26.5 21.5-48 48-48s48 21.5 48 48-21.5 48-48 48c-4.3 0-8.5-.6-12.4-1.6L40.3 505.7c7.8 4.4 17.2 5.4 26 2.5l264.3-88.6c19.7-6.6 35-22.4 41-42.3l43.2-144.1 .1-.5-135.5-135.5z" />
                        </svg>
                    </h1>
                </div>
                <div class="nav-info">
                    <span><%= user.getFullName() %></span>
                    <form action="logout" method="get">
                        <button type="submit">Logout</button>
                    </form>
                </div>
            </div>
        </header>

        <main>
            <div class="body-info">
                <h2>Welcome to the Admin Panel</h2>
                <p>Manage courses and teachers registrations</p>
                
                <!-- Display success/error messages -->
                <% if (session.getAttribute("success") != null) { %>
                    <div class="success-message" style="color: green; margin: 10px 0;">
                        <%= session.getAttribute("success") %>
                    </div>
                    <% session.removeAttribute("success"); %>
                <% } %>
                <% if (session.getAttribute("error") != null) { %>
                    <div class="error-message" style="color: red; margin: 10px 0;">
                        <%= session.getAttribute("error") %>
                    </div>
                    <% session.removeAttribute("error"); %>
                <% } %>
            </div>

            <div class="form-container">
                <h1>Add New Course</h1>

                <form action="courses" method="post">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="input-group">
                        <label for="course-name">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="width: 30px; height: auto;vertical-align: text-top;">
                                <path d="M384 512L96 512c-53 0-96-43-96-96L0 96C0 43 43 0 96 0L400 0c26.5 0 48 21.5 48 48l0 288c0 20.9-13.4 38.7-32 45.3l0 66.7c17.7 0 32 14.3 32 32s-14.3 32-32 32l-32 0zM96 384c-17.7 0-32 14.3-32 32s14.3 32 32 32l256 0 0-64-256 0zm32-232c0 13.3 10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0c-13.3 0-24 10.7-24 24zm24 72c-13.3 0-24 10.7-24 24s10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0z" />
                            </svg>
                            Course Name
                        </label>
                        <input type="text" id="course-name" name="course-name" placeholder="Enter course name" required />
                    </div>

                    <div class="input-group">
                        <label for="course-code">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" style="width: 30px; height: auto;vertical-align: text-top;">
                                <path d="M392.8 1.2c-17-4.9-34.7 5-39.6 22l-128 448c-4.9 17 5 34.7 22 39.6s34.7-5 39.6-22l128-448c4.9-17-5-34.7-22-39.6zm80.6 120.1c-12.5 12.5-12.5 32.8 0 45.3L562.7 256l-89.4 89.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l112-112c12.5-12.5 12.5-32.8 0-45.3l-112-112c-12.5-12.5-32.8-12.5-45.3 0zm-306.7 0c-12.5-12.5-32.8-12.5-45.3 0l-112 112c-12.5 12.5-12.5 32.8 0 45.3l112 112c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256l89.4-89.4c12.5-12.5 12.5-32.8 0-45.3z" />
                            </svg>
                            Course Code
                        </label>
                        <input type="text" id="course-code" name="course-code" placeholder="Enter course code" required />
                    </div>

                    <div class="input-group">
                        <label for="teacher">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" style="width: 30px; height: auto;vertical-align: text-top;">
                                <path d="M320 16a104 104 0 1 1 0 208 104 104 0 1 1 0-208zM96 88a72 72 0 1 1 0 144 72 72 0 1 1 0-144zM0 416c0-70.7 57.3-128 128-128 12.8 0 25.2 1.9 36.9 5.4-32.9 36.8-52.9 85.4-52.9 138.6l0 16c0 11.4 2.4 22.2 6.7 32L32 480c-17.7 0-32-14.3-32-32l0-32zm521.3 64c4.3-9.8 6.7-20.6 6.7-32l0-16c0-53.2-20-101.8-52.9-138.6 11.7-3.5 24.1-5.4 36.9-5.4 70.7 0 128 57.3 128 128l0 32c0 17.7-14.3 32-32 32l-86.7 0zM472 160a72 72 0 1 1 144 0 72 72 0 1 1 -144 0zM160 432c0-88.4 71.6-160 160-160s160 71.6 160 160l0 16c0 17.7-14.3 32-32 32l-256 0c-17.7 0-32-14.3-32-32l0-16z" />
                            </svg>
                            Select Teacher
                        </label>
                        <select name="teacher" id="teacher" required>
                            <option value="" disabled selected>Select a teacher</option>
                            <%
                                UserDAO userDAO = new UserDAO();
                                List<User> teachers = userDAO.getTeachers();
                                for (User teacher : teachers) {
                            %>
                                <option value="<%= teacher.getId() %>"><%= teacher.getFullName() %></option>
                            <% } %>
                        </select>
                    </div>

                    <button id="submit-btn" type="submit">
                        Add Course
                    </button>
                </form>
            </div>
        </main>

        <footer>
            <div class="footer-container">
                <p>&copy; 2025 Brilliant Academy. All rights reserved.</p>
            </div>
        </footer>
    </div>
</body>
</html>