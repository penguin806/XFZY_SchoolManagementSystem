package space.xuefeng.xfzy.model;

public class CourseSelection {
    private String studentId;
    private String courseId;
    private String courseName;
    private String courseTeacherUsername;

    public CourseSelection() {
    }

    public CourseSelection(String studentId, String courseId, String courseName, String courseTeacherUsername) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseTeacherUsername = courseTeacherUsername;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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
