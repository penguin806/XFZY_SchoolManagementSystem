package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.CourseDao;
import space.xuefeng.xfzy.model.Course;
import space.xuefeng.xfzy.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name="CourseUpdateServlet", urlPatterns ={ "/updateCourse" })
public class CourseUpdateServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    CourseDao courseInfoDao = new CourseDao();
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
//            throw new ServletException("Access Denied!");
        }

        String receivedClientData = request.getParameter("courseToUpdate");
        if(receivedClientData == null || receivedClientData.isEmpty())
        {
            throw new ServletException("Parameter courseToUpdate is null");
        }

        Course courseToUpdate = gson.fromJson(receivedClientData, Course.class);
        Connection dbConnection = null;
        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bSuccess = courseInfoDao.updateExistingCourse(dbConnection, courseToUpdate);
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
