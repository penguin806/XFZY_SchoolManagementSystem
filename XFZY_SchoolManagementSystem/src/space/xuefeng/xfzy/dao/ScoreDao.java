package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.Course;
import space.xuefeng.xfzy.model.CourseSelection;
import space.xuefeng.xfzy.model.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ScoreDao {

    public ResultSet listAllScoreOfOneStudent(Connection databaseConnection, String studentId) throws Exception
    {
//        SELECT
//        `score`.`student_id`,
//            `score`.`student_course_id`,
//            `course`.`course_name`,
//            `score`.`score`
//        FROM
//        `score`,
//                `course_selection`,
//                `course`
//        WHERE
//        `score`.`student_id` = 18 AND `course_selection`.`student_id` = 18 AND `score`.`student_course_id` = `course_selection`.`course_id` AND `course`.`course_id` = `course_selection`.`course_id`
//        RETURN RESULT:
//        student_id	student_course_id	course_name	score
//        18 	1 	Web应用系统设计 	85
//        18 	2 	JAVA程序开发 	90
        String selectStatement = "SELECT `score`.`student_id`, `score`.`student_course_id`, `course`.`course_name`, `score`.`score` " +
                "FROM `score`, `course_selection`, `course` " +
                "WHERE `score`.`student_id` = ? AND `course_selection`.`student_id` = `score`.`student_id` " +
                "AND `score`.`student_course_id` = `course_selection`.`course_id` AND `course`.`course_id` = `course_selection`.`course_id` ";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        selectPrepared.setString(1, studentId);
        return selectPrepared.executeQuery();
    }

    public boolean updateExistingCourse(Connection databaseConnection, Score scoreToUpdate) throws Exception
    {
        // First we delete the record of the specific score
        String deleteStatement = "DELETE FROM `score` WHERE `student_id` = ? AND `student_course_id` = ?";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        int affectedRows;
        deletePrepared.setString(1, scoreToUpdate.getStudentId());
        deletePrepared.setString(2, scoreToUpdate.getStudentCourseId());
        affectedRows = deletePrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("DELETE FROM TABLE `score` FAIL");
        }

        String insertStatement = "INSERT INTO `score`(`student_id`, `student_course_id`, `score`) VALUES (?,?,?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        insertPrepared.setString(1, scoreToUpdate.getStudentId());
        insertPrepared.setString(2, scoreToUpdate.getStudentCourseId());
        insertPrepared.setString(3, scoreToUpdate.getStudentCourseScore());
        affectedRows = insertPrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("INSERT INTO `score` FAIL");
        }

        return true;
    }

}
