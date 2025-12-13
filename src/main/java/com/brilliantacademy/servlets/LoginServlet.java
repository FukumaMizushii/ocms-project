package com.brilliantacademy.servlets;

import com.brilliantacademy.dao.UserDAO;
import com.brilliantacademy.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Login (all panels)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password, role);
        
        HttpSession session = request.getSession();
        
        if (user != null) {
            session.setAttribute("user", user);
            
            switch (role) {
                case "admin": 
                    response.sendRedirect("admin.jsp"); 
                    break;
                case "teacher": 
                    response.sendRedirect("teacher.jsp"); 
                    break;
                case "student": 
                    response.sendRedirect("student.jsp"); 
                    break;
                default: 
                    response.sendRedirect("login.jsp"); 
            }
        } else {
            session.setAttribute("error", "Invalid login credentials");
            response.sendRedirect("login.jsp"); 
        }
    }
}