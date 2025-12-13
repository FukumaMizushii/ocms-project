package com.brilliantacademy.servlets;

import com.brilliantacademy.dao.UserDAO;
import com.brilliantacademy.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Signup (all panels)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        User user = new User(fullName, email, password, role);
        UserDAO userDAO = new UserDAO();
        
        HttpSession session = request.getSession();
        
        if (userDAO.signup(user)) {
            session.setAttribute("success", "Registration successful! Please login.");
            response.sendRedirect("login.jsp"); 
        } else {
            session.setAttribute("error", "Registration failed. Email might be taken.");
            response.sendRedirect("signup.jsp");
        }
    }
}