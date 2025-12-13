<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brilliantacademy.dao.CourseDAO, com.brilliantacademy.model.User, com.brilliantacademy.model.Course, com.brilliantacademy.model.Enrollment, java.util.List" %>
<%
	// prevent back button after logout 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    // Check if user is logged in and is teacher
    User user = (User) session.getAttribute("user");
    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    CourseDAO courseDAO = new CourseDAO();
    List<Course> teacherCourses = courseDAO.getCoursesByTeacher(user.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Panel</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' style='vertical-align: text-top; width: 2rem; fill: %23FFD700'>
                            <path d='M368.5 18.3l-50.1 50.1 125.3 125.3 50.1-50.1c21.9-21.9 21.9-57.3 0-79.2L447.7 18.3c-21.9-21.9-57.3-21.9-79.2 0zM279.3 97.2l-.5 .1-144.1 43.2c-19.9 6-35.7 21.2-42.3 41L3.8 445.8c-2.9 8.7-1.9 18.2 2.5 26L161.7 316.4c-1.1-4-1.6-8.1-1.6-12.4 0-26.5 21.5-48 48-48s48 21.5 48 48-21.5 48-48 48c-4.3 0-8.5-.6-12.4-1.6L40.3 505.7c7.8 4.4 17.2 5.4 26 2.5l264.3-88.6c19.7-6.6 35-22.4 41-42.3l43.2-144.1 .1-.5-135.5-135.5z' />
                        </svg>" type="image/svg+xml">
    <link rel="stylesheet" href="css/teacher.css" />
</head>

<body>
    <div class="container">
        <header>
            <div class="nav-container">
                <div class="nav-panel">
                    <h2>Teacher Panel</h2>
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
                <h2>Welcome to the Teacher Panel</h2>
                <p>View your assigned courses and manage student registrations</p>
            </div>

            <div class="body-button">
                <button class="btn-tab active" id="courses-tab">View Students</button>
                <button class="btn-tab" id="students-tab">My Courses</button>
            </div>

            <!-- My Courses Section -->
            <div class="body-courses" id="courses-section">
                <ul>
                    <% for (Course course : teacherCourses) { %>
                    <li>
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="vertical-align: text-top; width: 1.8rem;">
                                <path d="M384 512L96 512c-53 0-96-43-96-96L0 96C0 43 43 0 96 0L400 0c26.5 0 48 21.5 48 48l0 288c0 20.9-13.4 38.7-32 45.3l0 66.7c17.7 0 32 14.3 32 32s-14.3 32-32 32l-32 0zM96 384c-17.7 0-32 14.3-32 32s14.3 32 32 32l256 0 0-64-256 0zm32-232c0 13.3 10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0c-13.3 0-24 10.7-24 24zm24 72c-13.3 0-24 10.7-24 24s10.7 24 24 24l176 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-176 0z" />
                            </svg>
                        </span>
                        <div class="course-info">
                            <p><%= course.getCourseName() %></p>
                            <p>Course Code: <%= course.getCourseCode() %></p>
                        </div>
                        <button class="view-students-btn" data-course="<%= course.getId() %>" onclick="showStudents(<%= course.getId() %>, '<%= course.getCourseCode() %>')">
                            View Students
                        </button> 
                    </li>
                    <% } %>
                </ul>
            </div>

            <!-- View Students Section -->
            <div class="body-courses not-active" id="students-section">
                <button class="back-btn" id="back-to-courses">← Back to Courses</button>
                <div class="students-list">
                    <h3 id="course-title">Students in <span id="selected-course">Select a course</span></h3>
                    <ul id="students-list">
                        <li>Select a course to view students</li>
                    </ul>
                </div>
            </div>
        </main>

        <footer>
            <div class="footer-container">
                <p>&copy; 2025 Brilliant Academy. All rights reserved.</p>
            </div>
        </footer>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const coursesTab = document.getElementById("courses-tab");
            const studentsTab = document.getElementById("students-tab");
            const coursesSection = document.getElementById("courses-section");
            const studentsSection = document.getElementById("students-section");
            const backToCoursesBtn = document.getElementById("back-to-courses");

            // Tab switching functionality
            coursesTab.addEventListener("click", () => {
                coursesSection.classList.remove("not-active");
                studentsSection.classList.add("not-active");
                coursesTab.classList.add("active");
                studentsTab.classList.remove("active");
            });

            studentsTab.addEventListener("click", () => {
                coursesTab.click();
            });

            // Back to courses button
            backToCoursesBtn.addEventListener("click", () => {
                coursesTab.click();
            });
        });

        function showStudents(courseId, courseCode) {
            document.getElementById('selected-course').textContent = courseCode;
            const studentsList = document.getElementById('students-list');
            studentsList.innerHTML = '<li>Loading...</li>';
            
            // Fetch real student data from server
            fetch('getStudents?courseId=' + courseId)
                .then(response => response.json())
                .then(students => {
                    studentsList.innerHTML = '';
                    
                    if (students.length === 0) {
                        studentsList.innerHTML = '<li>No students registered for this course yet.</li>';
                        return;
                    }
                    
                    students.forEach(student => {
                        const li = document.createElement('li');
                        
                        const avatar = document.createElement('div');
                        avatar.className = 'student-avatar';
                        avatar.textContent = student.name.charAt(0);
                        
                        const studentInfo = document.createElement('div');
                        studentInfo.className = 'student-info';
                        
                        const name = document.createElement('div');
                        name.className = 'student-name';
                        name.textContent = student.name;
                        
                        const email = document.createElement('div');
                        email.className = 'student-email';
                        email.textContent = student.email;
                        
                        studentInfo.appendChild(name);
                        studentInfo.appendChild(email);
                        
                        li.appendChild(avatar);
                        li.appendChild(studentInfo);
                        
                        studentsList.appendChild(li);
                    });
                })
                .catch(error => {
                    console.error('Error fetching students:', error);
                    studentsList.innerHTML = '<li>Error loading students. Please try again.</li>';
                });
            
            // Switch to students view
            document.getElementById('students-section').classList.remove('not-active');
            document.getElementById('courses-section').classList.add('not-active');
            document.getElementById('students-tab').classList.add('active');
            document.getElementById('courses-tab').classList.remove('active');
        }
    </script>
</body>
</html>