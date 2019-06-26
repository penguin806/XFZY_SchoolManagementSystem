package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.CourseDao;
import space.xuefeng.xfzy.model.Course;
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

@WebServlet(name="CourseQueryServlet", urlPatterns ={ "/queryCourse" })
public class CourseQueryServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    CourseDao courseInfoDao = new CourseDao();
    Gson gson = new Gson();

    private void querySingleExistingCourse(HttpServletResponse response, String courseId) {
        Connection dbConnection = null;
        Course singleCourse = new Course();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet courseQueryResult = courseInfoDao.queryExistingCourseByCourseId(dbConnection, courseId);
            if (courseQueryResult.next())
            {
                singleCourse.setCourseId(courseQueryResult.getString("course_id"));
                singleCourse.setCourseName(courseQueryResult.getString("course_name"));
                singleCourse.setCourseTeacherUsername(courseQueryResult.getString("course_teacher_username"));
            }
            else {
                throw new ServletException("Course Not Found");
            }

            String resultJson = gson.toJson(singleCourse);
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

        String courseId = request.getParameter("courseId");
        if(null != courseId && !courseId.isEmpty())
        {
            this.querySingleExistingCourse(response, courseId);
            return;
        }


        Connection dbConnection = null;
        Collection<Course> coursesList = new ArrayList<Course>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet coursesQueryResult = courseInfoDao.listAllCourses(dbConnection);
            while (coursesQueryResult.next())
            {
                Course singleCourse = new Course();
                singleCourse.setCourseId(coursesQueryResult.getString("course_id"));
                singleCourse.setCourseName(coursesQueryResult.getString("course_name"));
                singleCourse.setCourseTeacherUsername(coursesQueryResult.getString("course_teacher_username"));
                coursesList.add(singleCourse);
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
}
