package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.UserInfoDao;
import space.xuefeng.xfzy.model.User;
import space.xuefeng.xfzy.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name="UserUpdateServlet", urlPatterns ={ "/updateUser" })
public class UserUpdateServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    UserInfoDao userInfoDao = new UserInfoDao();
    Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession currentSession = request.getSession();
        if(! currentSession.getAttribute("currentRole").toString().equals("admin"))
        {
            throw new ServletException("Access Denied!");
        }

        String receivedClientData = request.getParameter("userToUpdate");
        if(receivedClientData == null || receivedClientData.isEmpty())
        {
            throw new ServletException("Parameter userToUpdate is null");
        }

        User userToUpdate = gson.fromJson(receivedClientData, User.class);
        Connection dbConnection = null;
        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bSuccess = userInfoDao.updateExistingUser(dbConnection, userToUpdate);
            response.getWriter().write("success");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(null != dbConnection)
            {
                try {
                    dbUtil.closeDatabaseConnection(dbConnection);
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
    }
}
