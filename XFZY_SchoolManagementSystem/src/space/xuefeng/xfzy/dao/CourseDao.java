package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.Course;
import space.xuefeng.xfzy.model.CourseSelection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CourseDao {

    public ResultSet listAllCourses(Connection databaseConnection) throws Exception
    {
        String selectStatement = "SELECT * FROM `course`";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        return selectPrepared.executeQuery();
    }


    public ResultSet queryExistingCourseByCourseId(Connection databaseConnection, String courseId) throws Exception
    {
        String selectStatement = "SELECT * FROM `course` WHERE `course_id` = ? ";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
//        String usernamePattern = "%" + username + '%';
        selectPrepared.setString(1, courseId);
        return selectPrepared.executeQuery();
    }


    public boolean addNewCourse(Connection databaseConnection, Course courseToAdd) throws Exception
    {
        String insertStatement = "INSERT INTO `course`(`course_name`, `course_teacher_username`) VALUES (?,?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        int affectedRows;
        insertPrepared.setString(1, courseToAdd.getCourseName());
        insertPrepared.setString(2, courseToAdd.getCourseTeacherUsername());
        affectedRows = insertPrepared.executeUpdate();

        if(affectedRows != 1)
        {
            throw new SQLException("INSERT INTO `course` FAIL");
        }

        return true;
    }


    public boolean deleteExistingCourse(Connection databaseConnection, String idOfCourseToDelete) throws Exception
    {

        String deleteStatement = "DELETE FROM `course` WHERE `course_id` = ?";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        deletePrepared.setString(1, idOfCourseToDelete);
        int affectedRows = deletePrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("DELETE FROM TABLE `course` FAIL");
        }

        return true;
    }


    public boolean updateExistingCourse(Connection databaseConnection, Course courseToUpdateInfo) throws Exception
    {
        String updateStatement = "UPDATE `course` SET `course_name`=?,`course_teacher_username`=? WHERE `course_id`=?";
        PreparedStatement updatePrepared = databaseConnection.prepareStatement(updateStatement);
        int affectedRows;
        updatePrepared.setString(1, courseToUpdateInfo.getCourseName());
        updatePrepared.setString(2, courseToUpdateInfo.getCourseTeacherUsername());
        updatePrepared.setString(3, courseToUpdateInfo.getCourseId());
        affectedRows = updatePrepared.executeUpdate();

        if(affectedRows != 1)
        {
            throw new SQLException("UPDATE TABLE `course` FAIL");
        }

        return true;
    }

    public boolean studentAddNewCourseSelection(Connection databaseConnection, CourseSelection courseSelectionToAdd) throws Exception
    {
        String insertStatement = "INSERT INTO `course_selection`(`student_id`, `course_id`) VALUES (?,?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        int affectedRows;
        insertPrepared.setString(1, courseSelectionToAdd.getStudentId());
        insertPrepared.setString(2, courseSelectionToAdd.getCourseId());
        affectedRows = insertPrepared.executeUpdate();

        if(affectedRows != 1)
        {
            throw new SQLException("INSERT INTO `course_selection` FAIL");
        }

        return true;
    }

    public ResultSet studentQueryCourseSelection(Connection databaseConnection, String studentId) throws Exception
    {
        String selectStatement = "SELECT `course_selection`.`student_id`, `course_selection`.`course_id`, `course`.`course_name`, `course`.`course_teacher_username` " +
                "FROM `course_selection`, `course` WHERE student_id = ? AND `course`.`course_id` = `course_selection`.`course_id`";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        selectPrepared.setString(1, studentId);
        return selectPrepared.executeQuery();
    }

    public boolean studentDeleteCourseSelection(Connection databaseConnection, CourseSelection courseSelectionToDelete) throws Exception
    {

        String deleteStatement = "DELETE FROM `course_selection` WHERE `student_id`=? AND `course_id`=?";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        deletePrepared.setString(1, courseSelectionToDelete.getStudentId());
        deletePrepared.setString(2, courseSelectionToDelete.getCourseId());
        int affectedRows = deletePrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("DELETE FROM TABLE `course_selection` FAIL");
        }

        return true;
    }
}
