package com.brilliantacademy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Connecting with database
public class DBConnection {
    
    // statically load driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load MySQL JDBC Driver");
            e.printStackTrace();
            throw new ExceptionInInitializerError("MySQL JDBC Driver not found");
        }
    }
    
    // get connection method to connect with database
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/brilliant_academy";
        String username = "example_user";
        String password = "password";
        
        System.out.println("\nAttempting to connect to database...");
        System.out.println("URL: " + url);
        System.out.println("Username: " + username);
        
        try {
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Database connection established successfully");
            return connection;
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection");
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            throw e;
        }
    }
}