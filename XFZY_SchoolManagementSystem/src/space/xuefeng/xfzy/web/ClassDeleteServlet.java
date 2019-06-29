package space.xuefeng.xfzy.web;

import space.xuefeng.xfzy.dao.ClassDao;
import space.xuefeng.xfzy.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name="ClassDeleteServlet", urlPatterns ={ "/deleteClass" })
public class ClassDeleteServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    ClassDao classInfoDao = new ClassDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession currentSession = request.getSession();
        if(! currentSession.getAttribute("currentRole").toString().equals("admin"))
        {
//            throw new ServletException("Access Denied!");
        }

        String receivedClientData = request.getParameter("classToDelete");
        if(receivedClientData == null || receivedClientData.isEmpty())
        {
            throw new ServletException("Parameter classToDelete is null");
        }

        Connection dbConnection = null;
        try {
            String idOfClassToDelete = receivedClientData;
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bSuccess = classInfoDao.deleteExistingClass(dbConnection, idOfClassToDelete);
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
