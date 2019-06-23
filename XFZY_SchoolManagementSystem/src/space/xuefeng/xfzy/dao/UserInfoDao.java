package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserInfoDao {

    public ResultSet listAllUsers(Connection databaseConnection) throws Exception
    {
        String selectStatement = "SELECT `id`, `username`, `password`, `email`, `role`, `remarks` FROM `user`";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        return selectPrepared.executeQuery();
    }


    public ResultSet queryExistingUserByUserName(Connection databaseConnection, String username) throws Exception
    {
        String selectStatement = "SELECT `id`, `username`, `password`, `email`, `role`, `remarks` FROM `user` WHERE `username` LIKE ?";
        PreparedStatement selectPrepared = databaseConnection.prepareStatement(selectStatement);
        String usernamePattern = "%" + username + '%';
        selectPrepared.setString(1, usernamePattern);
        return selectPrepared.executeQuery();
    }


    public boolean addNewUser(Connection databaseConnection, User userToAdd) throws Exception
    {
        String insertStatement = "INSERT INTO `user` (`username`, `password`, `email`, `role`, `remarks`) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement insertPrepared = databaseConnection.prepareStatement(insertStatement);
        insertPrepared.setString(1, userToAdd.getUserName());
        insertPrepared.setString(2, userToAdd.getUserPassword());
        insertPrepared.setString(3, userToAdd.getUserEmail());
        insertPrepared.setString(4, userToAdd.getUserRole());
        insertPrepared.setString(5, userToAdd.getUserRemarks());
        insertPrepared.executeUpdate();

        if(null != userToAdd.getUser_Info())
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
            insertPrepared.executeUpdate();
        }

        return true;
    }


    public boolean deleteExistingUser(Connection databaseConnection, User userToDelete) throws Exception
    {
        String deleteStatement = "DELETE FROM `user` WHERE `username`=?";
        PreparedStatement deletePrepared = databaseConnection.prepareStatement(deleteStatement);
        deletePrepared.setString(1, userToDelete.getUserName());
        deletePrepared.executeUpdate();


        String insertStatement2 = "DELETE FROM `user_info` WHERE `username`=?";
        deletePrepared = databaseConnection.prepareStatement(insertStatement2);
        deletePrepared.setString(1,userToDelete.getUserName());
        deletePrepared.executeUpdate();

        return true;
    }


    public boolean updateExistingUser(Connection databaseConnection, User userToUpdateInfo) throws Exception
    {
        String updateStatement = "UPDATE `user` SET `username`=?,`password`=?,`email`=?,`role`=?,`remarks`=? WHERE id=?";
        PreparedStatement updatePrepared = databaseConnection.prepareStatement(updateStatement);
        updatePrepared.setString(1, userToUpdateInfo.getUserName());
        updatePrepared.setString(2, userToUpdateInfo.getUserPassword());
        updatePrepared.setString(3, userToUpdateInfo.getUserEmail());
        updatePrepared.setString(4, userToUpdateInfo.getUserRole());
        updatePrepared.setString(5, userToUpdateInfo.getUserRemarks());
        updatePrepared.setString(6, userToUpdateInfo.getUserId());
        updatePrepared.executeUpdate();

        if(null != userToUpdateInfo.getUser_Info())
        {
            String updateStatement2 = "UPDATE `user_info` SET `sex`=?,`idcard_number`=?,`department`=?,`class`=?,`home_address`=?,`train_station`=? WHERE `username`=?";
            updatePrepared = databaseConnection.prepareStatement(updateStatement2);
            updatePrepared.setString(1,userToUpdateInfo.getUser_Info().getUserinfo_Sex());
            updatePrepared.setString(2,userToUpdateInfo.getUser_Info().getUserinfo_Idcard_number());
            updatePrepared.setString(3,userToUpdateInfo.getUser_Info().getUserinfo_Department());
            updatePrepared.setString(4,userToUpdateInfo.getUser_Info().getUserinfo_Class());
            updatePrepared.setString(5,userToUpdateInfo.getUser_Info().getUserinfo_Home_address());
            updatePrepared.setString(6,userToUpdateInfo.getUser_Info().getUserinfo_Train_station());
            updatePrepared.setString(7,userToUpdateInfo.getUserName());
            updatePrepared.executeUpdate();
        }

        return true;
    }
}
