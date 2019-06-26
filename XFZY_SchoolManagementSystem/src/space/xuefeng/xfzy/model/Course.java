package space.xuefeng.xfzy.model;

public class Course {
    private String courseId;
    private String courseName;
    private String courseTeacherUsername;

    public Course() {
    }

    public Course(String courseId, String courseName, String courseTeacherUsername) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseTeacherUsername = courseTeacherUsername;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseTeacherUsername() {
        return courseTeacherUsername;
    }

    public void setCourseTeacherUsername(String courseTeacherUsername) {
        this.courseTeacherUsername = courseTeacherUsername;
    }
}
