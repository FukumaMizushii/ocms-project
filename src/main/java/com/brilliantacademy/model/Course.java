package com.brilliantacademy.model;

// class object for courses
public class Course {
    private int id;
    private String courseCode;
    private String courseName;
    private int teacherId;
    private String teacherName;
    
    public Course() {}
    
    public Course(String courseCode, String courseName, int teacherId) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.teacherId = teacherId;
    }
    
    // Getters and setters...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
}