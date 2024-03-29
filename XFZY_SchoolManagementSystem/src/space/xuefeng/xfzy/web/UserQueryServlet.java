package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import com.sun.deploy.net.HttpResponse;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;
import space.xuefeng.xfzy.dao.UserInfoDao;
import space.xuefeng.xfzy.model.User;
import space.xuefeng.xfzy.model.UserInfo;
import space.xuefeng.xfzy.util.DatabaseUtil;
import space.xuefeng.xfzy.util.ResponseUtil;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;

@WebServlet(name="UserQueryServlet", urlPatterns ={ "/queryUser" })
public class UserQueryServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    UserInfoDao userInfoDao = new UserInfoDao();
    Gson gson = new Gson();

    private void queryAllExsitingUsers(HttpServletResponse response, boolean queryStudentOnly){
        Connection dbConnection = null;
        Collection<User> usersList = new ArrayList<User>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet usersQueryResult = userInfoDao.listAllUsers(dbConnection);
            while (usersQueryResult.next())
            {
                User singleUser = new User();
                singleUser.setUserRole(usersQueryResult.getString("role"));
                if(queryStudentOnly && !singleUser.getUserRole().equals("student"))
                {
                    continue;
                }

                singleUser.setUserId(usersQueryResult.getString("id"));
                singleUser.setUserName(usersQueryResult.getString("username"));
                singleUser.setUserPassword(usersQueryResult.getString("password"));
                singleUser.setUserRealname(usersQueryResult.getString("realname"));
                singleUser.setUserEmail(usersQueryResult.getString("email"));
                singleUser.setUserRemarks(usersQueryResult.getString("remarks"));
                usersList.add(singleUser);
            }

            String resultJson = gson.toJson(usersList);
            ResponseUtil.writeResponseData(response, resultJson);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if(null != dbConnection)
            {
                try {
                    dbUtil.closeDatabaseConnection(dbConnection);
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
    }
    private void querySingleExistingUser(HttpServletResponse response, String userId) {
        Connection dbConnection = null;
        User singleUser = new User();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet usersQueryResult = userInfoDao.queryExistingUserByUserId(dbConnection, userId);
            if (usersQueryResult.next())
            {
                UserInfo singleUserInfo = new UserInfo();
                singleUser.setUserId(usersQueryResult.getString("id"));
                singleUser.setUserName(usersQueryResult.getString("username"));
                singleUser.setUserPassword(usersQueryResult.getString("password"));
                singleUser.setUserRealname(usersQueryResult.getString("realname"));
                singleUser.setUserEmail(usersQueryResult.getString("email"));
                singleUser.setUserRole(usersQueryResult.getString("role"));
                singleUser.setUserRemarks(usersQueryResult.getString("remarks"));

                singleUserInfo.setUserinfo_Sex(usersQueryResult.getString("sex"));
                singleUserInfo.setUserinfo_Idcard_number(usersQueryResult.getString("idcard_number"));
                singleUserInfo.setUserinfo_Department(usersQueryResult.getString("department"));
                singleUserInfo.setUserinfo_Class(usersQueryResult.getString("class"));
                singleUserInfo.setUserinfo_Home_address(usersQueryResult.getString("home_address"));
                singleUserInfo.setUserinfo_Train_station(usersQueryResult.getString("train_station"));
                singleUser.setUser_Info(singleUserInfo);
            }
            else {
                throw new ServletException("User Not Found");
            }

            String resultJson = gson.toJson(singleUser);
            ResponseUtil.writeResponseData(response, resultJson);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if(null != dbConnection)
            {
                try {
                    dbUtil.closeDatabaseConnection(dbConnection);
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // super.doGet(req, resp);
        // Not handled
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession currentSession = request.getSession();
        if(! currentSession.getAttribute("currentRole").toString().equals("admin"))
        {
//            throw new ServletException("Access Denied!");
        }

        String userId = request.getParameter("userId");
        if(null != userId && !userId.isEmpty())
        {
            this.querySingleExistingUser(response, userId);
            return;
        }

        String studentOnly = request.getParameter("studentOnly");
        if(studentOnly != null && !studentOnly.isEmpty())
        {
            queryAllExsitingUsers(response, true);
        }
        else
        {
            queryAllExsitingUsers(response, false);
        }
    }
}
