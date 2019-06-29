package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.ClassDao;
import space.xuefeng.xfzy.model.Class;
import space.xuefeng.xfzy.util.DatabaseUtil;
import space.xuefeng.xfzy.util.ResponseUtil;

import javax.servlet.ServletException;
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

@WebServlet(name="ClassQueryServlet", urlPatterns ={ "/queryClass" })
public class ClassQueryServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    ClassDao classInfoDao = new ClassDao();
    Gson gson = new Gson();

    private void queryAllExistingClass(HttpServletResponse response) {
        Connection dbConnection = null;
        Collection<Class> coursesList = new ArrayList<Class>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet classesQueryResult = classInfoDao.listAllClasses(dbConnection);
            while (classesQueryResult.next())
            {
                Class singleClass = new Class();
                singleClass.setClassId(classesQueryResult.getString("class_id"));
                singleClass.setClassName(classesQueryResult.getString("class_name"));
                singleClass.setClassStudentsNum(classesQueryResult.getString("class_student_num"));
                coursesList.add(singleClass);
            }

            String resultJson = gson.toJson(coursesList);
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

        this.queryAllExistingClass(response);

    }

}
