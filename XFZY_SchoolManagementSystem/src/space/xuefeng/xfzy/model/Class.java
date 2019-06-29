package space.xuefeng.xfzy.model;

public class Class {
    private String classId;
    private String className;
    private String classStudentsNum;

    public Class() {
    }

    public Class(String classId, String className, String classStudentsNum) {
        this.classId = classId;
        this.className = className;
        this.classStudentsNum = classStudentsNum;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassStudentsNum() {
        return classStudentsNum;
    }

    public void setClassStudentsNum(String classStudentsNum) {
        this.classStudentsNum = classStudentsNum;
    }
}
