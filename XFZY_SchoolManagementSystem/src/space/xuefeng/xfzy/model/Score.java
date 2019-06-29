package space.xuefeng.xfzy.model;

public class Score {
    private String studentId;
    private String studentUsername;
    private String studentRealname;
    private String studentCourseId;
    private String studentCourseName;
    private String studentCourseScore;

    public Score() {
    }

    public Score(String studentId, String studentUsername, String studentRealname, String studentCourseId, String studentCourseName, String studentCourseScore) {
        this.studentId = studentId;
        this.studentUsername = studentUsername;
        this.studentRealname = studentRealname;
        this.studentCourseId = studentCourseId;
        this.studentCourseName = studentCourseName;
        this.studentCourseScore = studentCourseScore;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentUsername() {
        return studentUsername;
    }

    public void setStudentUsername(String studentUsername) {
        this.studentUsername = studentUsername;
    }

    public String getStudentRealname() {
        return studentRealname;
    }

    public void setStudentRealname(String studentRealname) {
        this.studentRealname = studentRealname;
    }

    public String getStudentCourseId() {
        return studentCourseId;
    }

    public void setStudentCourseId(String studentCourseId) {
        this.studentCourseId = studentCourseId;
    }

    public String getStudentCourseName() {
        return studentCourseName;
    }

    public void setStudentCourseName(String studentCourseName) {
        this.studentCourseName = studentCourseName;
    }

    public String getStudentCourseScore() {
        return studentCourseScore;
    }

    public void setStudentCourseScore(String studentCourseScore) {
        this.studentCourseScore = studentCourseScore;
    }
}
