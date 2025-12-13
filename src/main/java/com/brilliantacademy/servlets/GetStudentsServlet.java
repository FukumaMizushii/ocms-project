package com.brilliantacademy.servlets;

import com.brilliantacademy.dao.CourseDAO;
import com.brilliantacademy.model.Enrollment;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/getStudents")
public class GetStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // registered students for a course (teacher panel)
        String courseIdStr = request.getParameter("courseId");
        
        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdStr);
                CourseDAO courseDAO = new CourseDAO();
                List<Enrollment> enrollments = courseDAO.getStudentsByCourse(courseId);
                
                // Build JSON manually
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < enrollments.size(); i++) {
                    Enrollment e = enrollments.get(i);
                    json.append("{");
                    json.append("\"name\":\"").append(escapeJson(e.getStudentName())).append("\",");
                    json.append("\"email\":\"").append(escapeJson(e.getStudentEmail())).append("\"");
                    json.append("}");
                    if (i < enrollments.size() - 1) {
                        json.append(",");
                    }
                }
                json.append("]");
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json.toString());
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Invalid course ID\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Course ID is required\"}");
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r");
    }
}
