package space.xuefeng.xfzy.dao;

import space.xuefeng.xfzy.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserLoginDao {

    public boolean isUserLoginVerificationSuccess(Connection databaseConnection, User loginUser) throws Exception {
        String sqlStatement = "SELECT * FROM user WHERE username=? AND password=?";
        PreparedStatement preparedStatement = databaseConnection.prepareStatement(sqlStatement);
        preparedStatement.setString(1, loginUser.getUserName());
        preparedStatement.setString(2, loginUser.getUserPassword());

        ResultSet resultSet = preparedStatement.executeQuery();
        if(resultSet.next())
        {
            loginUser.setUserId(resultSet.getString("id"));
            loginUser.setUserEmail(resultSet.getString("email"));
            loginUser.setUserRole(resultSet.getString("role"));
            loginUser.setUserRemarks(resultSet.getString("remarks"));
            return true;
        }

        return false;
    }
}
