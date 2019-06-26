package space.xuefeng.xfzy.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    private final String dbUrl = "jdbc:mysql://localhost:3306/xfzy_school_mng_sys?characterEncoding=utf8";
    private final String dbUsername = "xfzy";
    private final String dbPassword = "20190621";
    private final String jdbcName = "com.mysql.jdbc.Driver";

    public Connection getDatabaseConnection() throws Exception {
        Class.forName(jdbcName);
        Connection databaseConnection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        return databaseConnection;
    }

    public void closeDatabaseConnection(Connection dbConnection) throws Exception {
        if(null != dbConnection)
        {
            dbConnection.close();
        }
    }
}
