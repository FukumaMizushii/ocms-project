package com.brilliantacademy.servlets;

import com.brilliantacademy.dao.CourseDAO;
import com.brilliantacademy.model.Course;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        CourseDAO courseDAO = new CourseDAO();
        HttpSession session = request.getSession();
        
        if ("add".equals(action)) {
            // Add new course (admin panel)
            String courseName = request.getParameter("course-name");
            String courseCode = request.getParameter("course-code");
            int teacherId = Integer.parseInt(request.getParameter("teacher"));
            
            Course course = new Course(courseCode, courseName, teacherId);
            
            if (courseDAO.addCourse(course)) {
                session.setAttribute("success", "Course added successfully!");
            } else {
                session.setAttribute("error", "Failed to add course!");
            }
            response.sendRedirect("admin.jsp");
            
        } else if ("enroll".equals(action)) {
            // Enroll student in course (student panel booking)
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            
            if (courseDAO.enrollStudent(studentId, courseId)) {
                session.setAttribute("success", "Enrolled in course successfully!");
            } else {
                session.setAttribute("error", "Failed to enroll in course!");
            }
            response.sendRedirect("student.jsp");
        }
    }
}