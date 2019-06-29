package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClassDao {

    public ResultSet listAllClasses(Connection databaseConnection) throws Exception
    {
        String selectStatement = "SELECT `class_id`, `class_name`, COUNT(`class_name`) AS `class_student_num` FROM `class`,`user_info` WHERE `class`.`class_name` = `user_info`.`class` ";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        return selectPrepared.executeQuery();
    }


    public boolean addNewClass(Connection databaseConnection, Class classToAdd) throws Exception
    {
        String insertStatement = "INSERT INTO `class`(`class_name`) VALUES (?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        int affectedRows;
        insertPrepared.setString(1, classToAdd.getClassName());
        affectedRows = insertPrepared.executeUpdate();

        if(affectedRows != 1)
        {
            throw new SQLException("INSERT INTO `class` FAIL");
        }

        return true;
    }


    public boolean deleteExistingClass(Connection databaseConnection, String idOfClassToDelete) throws Exception
    {

        String deleteStatement = "DELETE FROM `class` WHERE `class_id` = ?";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        deletePrepared.setString(1, idOfClassToDelete);
        int affectedRows = deletePrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("DELETE FROM TABLE `class` FAIL");
        }

        return true;
    }


    public boolean updateExistingClass(Connection databaseConnection, Class classToUpdate) throws Exception
    {

        String updateStatement = "UPDATE `class` SET`class_name`=? WHERE `class_id`=?";
        PreparedStatement updatePrepared = databaseConnection.prepareStatement(updateStatement);
        int affectedRows;
        updatePrepared.setString(1, classToUpdate.getClassName());
        updatePrepared.setString(2, classToUpdate.getClassId());
        affectedRows = updatePrepared.executeUpdate();

        if(affectedRows != 1)
        {
            throw new SQLException("UPDATE TABLE `class` FAIL");
        }

        return true;

    }
}
