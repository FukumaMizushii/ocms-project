<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brilliantacademy.dao.CourseDAO, com.brilliantacademy.model.User, com.brilliantacademy.model.Course, java.util.List" %>
<%
	// prevent back button after logout 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    // Check if user is logged in and is student
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    CourseDAO courseDAO = new CourseDAO();
    List<Course> allCourses = courseDAO.getAllCourses();
    List<Course> enrolledCourses = courseDAO.getEnrolledCourses(user.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Panel</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' style='vertical-align: text-top; width: 2rem; fill: %23FFD700'>
                            <path d='M368.5 18.3l-50.1 50.1 125.3 125.3 50.1-50.1c21.9-21.9 21.9-57.3 0-79.2L447.7 18.3c-21.9-21.9-57.3-21.9-79.2 0zM279.3 97.2l-.5 .1-144.1 43.2c-19.9 6-35.7 21.2-42.3 41L3.8 445.8c-2.9 8.7-1.9 18.2 2.5 26L161.7 316.4c-1.1-4-1.6-8.1-1.6-12.4 0-26.5 21.5-48 48-48s48 21.5 48 48-21.5 48-48 48c-4.3 0-8.5-.6-12.4-1.6L40.3 505.7c7.8 4.4 17.2 5.4 26 2.5l264.3-88.6c19.7-6.6 35-22.4 41-42.3l43.2-144.1 .1-.5-135.5-135.5z' />
                        </svg>" type="image/svg+xml">
    <link rel="stylesheet" href="css/student.css" />
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const regBtn = document.getElementById("reg-courses-btn");
            const newBtn = document.getElementById("new-courses-btn");

            const newCourses = document.getElementById("new-courses");
            const registeredCourses = document.getElementById("registered-courses");

            regBtn.addEventListener("click", () => {
                registeredCourses.classList.remove("not-active");
                newCourses.classList.add("not-active");

                regBtn.classList.add("active");
                newBtn.classList.remove("active");
            });

            newBtn.addEventListener("click", () => {
                newCourses.classList.remove("not-active");
                registeredCourses.classList.add("not-active");

                newBtn.classList.add("active");
                regBtn.classList.remove("active");
            });
        });

        function enrollCourse(courseId) {
            if (confirm('Are you sure you want to enroll in this course?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'courses';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'enroll';
                form.appendChild(actionInput);
                
                const studentInput = document.createElement('input');
                studentInput.type = 'hidden';
                studentInput.name = 'studentId';
                studentInput.value = '<%= user.getId() %>';
                form.appendChild(studentInput);
                
                const courseInput = document.createElement('input');
                courseInput.type = 'hidden';
                courseInput.name = 'courseId';
                courseInput.value = courseId;
                form.appendChild(courseInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>

<body>
    <div class="container">
        <header>
            <div class="nav-container">
                <div class="nav-panel">
                    <h2>Student Panel</h2>
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
                <h2>Welcome to the Student Panel</h2>
                <p>Here you can access your courses, and register for new courses</p>
                
                <!-- Display messages -->
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
            
            <div class="body-button">
                <button class="btn-tab" id="reg-courses-btn">Registered Courses</button>
                <button class="btn-tab active" id="new-courses-btn">Available Courses</button>
            </div>
            
            <div class="body-courses" id="new-courses">
                <ul>
                    <% for (Course course : allCourses) { 
                        boolean isEnrolled = courseDAO.isStudentEnrolled(user.getId(), course.getId());
                    %>
                    <li>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="vertical-align: text-top; width: 1.8rem;">
                                <path d="M384 512L96 512c-53 0-96-43-96-96L0 96C0 43 43 0 96 0L400 0c26.5 0 48 21.5 48 48l0 288c0 20.9-13.4 38.7-32 45.3l0 66.7c17.7 0 32 14.3 32 32s-14.3 32-32 32l-32 0zM96 384c-17.7 0-32 14.3-32 32s14.3 32 32 32l256 0 0-64-256 0zm32-232c0 13.3 10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0c-13.3 0-24 10.7-24 24zm24 72c-13.3 0-24 10.7-24 24s10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0z" />
                            </svg>
                        </span>
                        <div class="course-info">
                            <p><%= course.getCourseName() %> (<%= course.getCourseCode() %>)</p>
                            <p>Teacher: <%= course.getTeacherName() %></p>
                        </div>
                        <% if (isEnrolled) { %>
                            <span id="book-btn" style="background-color: #6c757d; cursor: not-allowed;">
                                Booked
                            </span>
                        <% } else { %>
                            <span id="book-btn" onclick="enrollCourse(<%= course.getId() %>)">
                                Book Now
                            </span>
                        <% } %>
                    </li>
                    <% } %>
                </ul>
            </div>

            <div class="body-courses not-active" id="registered-courses">
                <ul>
                    <% if (enrolledCourses.isEmpty()) { %>
                    <li>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="vertical-align: text-top; width: 1.8rem;">
                                <path d="M384 512L96 512c-53 0-96-43-96-96L0 96C0 43 43 0 96 0L400 0c26.5 0 48 21.5 48 48l0 288c0 20.9-13.4 38.7-32 45.3l0 66.7c17.7 0 32 14.3 32 32s-14.3 32-32 32l-32 0zM96 384c-17.7 0-32 14.3-32 32s14.3 32 32 32l256 0 0-64-256 0zm32-232c0 13.3 10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0c-13.3 0-24 10.7-24 24zm24 72c-13.3 0-24 10.7-24 24s10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0z" />
                            </svg>
                        </span>
                        <div class="course-info">
                            <p>Your Registered Courses Will Appear Here</p>
                            <p>(Enroll in courses from Available Courses tab)</p>
                        </div>
                    </li>
                    <% } else { 
                        for (Course course : enrolledCourses) { %>
                    <li>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="vertical-align: text-top; width: 1.8rem;">
                                <path d="M384 512L96 512c-53 0-96-43-96-96L0 96C0 43 43 0 96 0L400 0c26.5 0 48 21.5 48 48l0 288c0 20.9-13.4 38.7-32 45.3l0 66.7c17.7 0 32 14.3 32 32s-14.3 32-32 32l-32 0zM96 384c-17.7 0-32 14.3-32 32s14.3 32 32 32l256 0 0-64-256 0zm32-232c0 13.3 10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0c-13.3 0-24 10.7-24 24zm24 72c-13.3 0-24 10.7-24 24s10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0z" />
                            </svg>
                        </span>
                        <div class="course-info">
                            <p><%= course.getCourseName() %> (<%= course.getCourseCode() %>)</p>
                            <p>Teacher: <%= course.getTeacherName() %></p>
                        </div>
                        <span id="book-btn" style="background-color: #28a745;">
                            Enrolled
                        </span>
                    </li>
                    <% } 
                    } %>
                </ul>
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