package space.xuefeng.xfzy.web;

import space.xuefeng.xfzy.dao.UserInfoDao;
import space.xuefeng.xfzy.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name="UserDeleteServlet", urlPatterns ={ "/deleteUser" })
public class UserDeleteServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    UserInfoDao userInfoDao = new UserInfoDao();

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

        String receivedClientData = request.getParameter("userToDelete");
        if(receivedClientData == null || receivedClientData.isEmpty())
        {
            throw new ServletException("Parameter userToDelete is null");
        }

        Connection dbConnection = null;
        try {
            String idOfUserToDelete = receivedClientData;
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bSuccess = userInfoDao.deleteExistingUser(dbConnection, idOfUserToDelete);
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
