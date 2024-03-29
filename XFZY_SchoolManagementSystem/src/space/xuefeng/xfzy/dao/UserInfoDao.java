package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserInfoDao {

    public ResultSet listAllUsers(Connection databaseConnection) throws Exception
    {
        String selectStatement = "SELECT `id`, `username`, `password`, `realname`, `email`, `role`, `remarks` FROM `user`";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        return selectPrepared.executeQuery();
    }


    public ResultSet queryExistingUserByUserId(Connection databaseConnection, String userId) throws Exception
    {
        String selectStatement = "SELECT * FROM `user`,`user_info` WHERE `id` = ? AND `user`.`username` = `user_info`.`username` ";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
//        String usernamePattern = "%" + username + '%';
        selectPrepared.setString(1, userId);
        return selectPrepared.executeQuery();
    }


    public boolean addNewUser(Connection databaseConnection, User userToAdd) throws Exception
    {
        String insertStatement = "INSERT INTO `user` (`username`, `password`, `realname`, `email`, `role`, `remarks`) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        int affectedRows;
        insertPrepared.setString(1, userToAdd.getUserName());
        insertPrepared.setString(2, userToAdd.getUserPassword());
        insertPrepared.setString(3, userToAdd.getUserRealname());
        insertPrepared.setString(4, userToAdd.getUserEmail());
        insertPrepared.setString(5, userToAdd.getUserRole());
        insertPrepared.setString(6, userToAdd.getUserRemarks());
        affectedRows = insertPrepared.executeUpdate();

        if(affectedRows == 1)
        {
            String insertStatement2 = "INSERT INTO `user_info`(`username`, `sex`, `idcard_number`, `department`, `class`, `home_address`, `train_station`) VALUES (?,?,?,?,?,?,?)";
            insertPrepared = databaseConnection.prepareStatement(insertStatement2);
            insertPrepared.setString(1,userToAdd.getUserName());
            insertPrepared.setString(2,userToAdd.getUser_Info().getUserinfo_Sex());
            insertPrepared.setString(3,userToAdd.getUser_Info().getUserinfo_Idcard_number());
            insertPrepared.setString(4,userToAdd.getUser_Info().getUserinfo_Department());
            insertPrepared.setString(5,userToAdd.getUser_Info().getUserinfo_Class());
            insertPrepared.setString(6,userToAdd.getUser_Info().getUserinfo_Home_address());
            insertPrepared.setString(7,userToAdd.getUser_Info().getUserinfo_Train_station());
            affectedRows = insertPrepared.executeUpdate();
            if(affectedRows != 1)
            {
                throw new SQLException("INSERT INTO `user_info` FAIL");
            }
        }
        else {
            throw new SQLException("INSERT INTO `user` FAIL");
        }

        return true;
    }


    public boolean deleteExistingUser(Connection databaseConnection, String idOfUserToDelete) throws Exception
    {

        String deleteStatement = "DELETE FROM `user`,`user_info` USING `user`,`user_info` WHERE `user`.`id`=? AND `user`.`username` = `user_info`.`username`";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        deletePrepared.setString(1, idOfUserToDelete);
        int affectedRows = deletePrepared.executeUpdate();
        if(affectedRows != 1)
        {
            throw new SQLException("DELETE FROM TABLE `user`,`user_info` FAIL");
        }

        return true;
    }


    public boolean updateExistingUser(Connection databaseConnection, User userToUpdateInfo) throws Exception
    {
        // Dump username before update
        String originalUsername;
        String selectUsernameStatement = "SELECT `username` FROM `user` WHERE `id` = ?";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectUsernameStatement);
        selectPrepared.setString(1, userToUpdateInfo.getUserId());
        ResultSet userQueryResult = selectPrepared.executeQuery();
        if(userQueryResult.next())
        {
            originalUsername = userQueryResult.getString("username");
            if(originalUsername == null || originalUsername.isEmpty())
            {
                throw new SQLException("updateExistingUser -> User not exist");
            }
        }
        else {
            throw new SQLException("updateExistingUser -> User not exist");
        }

        String updateStatement = "UPDATE `user` SET `username`=?,`password`=?,`realname`=?,`email`=?,`role`=?,`remarks`=? WHERE id=?";
        PreparedStatement updatePrepared = databaseConnection.prepareStatement(updateStatement);
        int affectedRows;
        updatePrepared.setString(1, userToUpdateInfo.getUserName());
        updatePrepared.setString(2, userToUpdateInfo.getUserPassword());
        updatePrepared.setString(3, userToUpdateInfo.getUserRealname());
        updatePrepared.setString(4, userToUpdateInfo.getUserEmail());
        updatePrepared.setString(5, userToUpdateInfo.getUserRole());
        updatePrepared.setString(6, userToUpdateInfo.getUserRemarks());
        updatePrepared.setString(7, userToUpdateInfo.getUserId());
        affectedRows = updatePrepared.executeUpdate();

        if(affectedRows == 1)
        {
            String updateStatement2 = "UPDATE `user_info` SET `sex`=?,`idcard_number`=?,`department`=?,`class`=?,`home_address`=?,`train_station`=? WHERE `username`=?";
            updatePrepared = databaseConnection.prepareStatement(updateStatement2);
            updatePrepared.setString(1,userToUpdateInfo.getUser_Info().getUserinfo_Sex());
            updatePrepared.setString(2,userToUpdateInfo.getUser_Info().getUserinfo_Idcard_number());
            updatePrepared.setString(3,userToUpdateInfo.getUser_Info().getUserinfo_Department());
            updatePrepared.setString(4,userToUpdateInfo.getUser_Info().getUserinfo_Class());
            updatePrepared.setString(5,userToUpdateInfo.getUser_Info().getUserinfo_Home_address());
            updatePrepared.setString(6,userToUpdateInfo.getUser_Info().getUserinfo_Train_station());
            updatePrepared.setString(7,originalUsername);
            affectedRows = updatePrepared.executeUpdate();
            if(affectedRows != 1)
            {
                throw new SQLException("UPDATE TABLE `user_info` FAIL");
            }
        }
        else {
            throw new SQLException("UPDATE TABLE `user` FAIL");
        }

        return true;
    }
}
