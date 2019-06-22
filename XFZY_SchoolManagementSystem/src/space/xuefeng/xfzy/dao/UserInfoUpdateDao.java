package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserInfoUpdateDao {

    public boolean updateExistingUserInfo(Connection databaseConnection, User userToUpdateInfo) throws Exception {
        String sqlStatement = "UPDATE `user` SET `username`=?,`password`=?,`email`=?,`role`=?,`remarks`=? WHERE id=?";
        PreparedStatement preparedStatement = databaseConnection.prepareStatement(sqlStatement);
        preparedStatement.setString(1, userToUpdateInfo.getUserId());
        preparedStatement.setString(2, userToUpdateInfo.getUserPassword());
        preparedStatement.setString(3, userToUpdateInfo.getUserEmail());
        preparedStatement.setString(4, userToUpdateInfo.getUserRole());
        preparedStatement.setString(5, userToUpdateInfo.getUserRemarks());
        preparedStatement.setString(6, userToUpdateInfo.getUserId());
        preparedStatement.executeUpdate();

        if(null != userToUpdateInfo.getUser_Info())
        {
            sqlStatement = "UPDATE `user_info` SET `sex`=?,`idcard_number`=?,`department`=?,`class`=?,`home_address`=?,`train_station`=? WHERE `user_id`=?";
            preparedStatement = databaseConnection.prepareStatement(sqlStatement);
            preparedStatement.setString(1,userToUpdateInfo.getUser_Info().getUserinfo_Sex());
            preparedStatement.setString(2,userToUpdateInfo.getUser_Info().getUserinfo_Idcard_number());
            preparedStatement.setString(3,userToUpdateInfo.getUser_Info().getUserinfo_Department());
            preparedStatement.setString(4,userToUpdateInfo.getUser_Info().getUserinfo_Class());
            preparedStatement.setString(5,userToUpdateInfo.getUser_Info().getUserinfo_Home_address());
            preparedStatement.setString(6,userToUpdateInfo.getUser_Info().getUserinfo_Train_station());
            preparedStatement.executeUpdate();
        }

        return true;
    }
}
