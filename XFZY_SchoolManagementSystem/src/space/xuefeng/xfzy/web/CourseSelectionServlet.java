package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.CourseDao;
import space.xuefeng.xfzy.model.Course;
import space.xuefeng.xfzy.model.CourseSelection;
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

@WebServlet(name="CourseSelectionServlet", urlPatterns ={ "/courseSelection" })
public class CourseSelectionServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    CourseDao courseInfoDao = new CourseDao();
    Gson gson = new Gson();

    private void addCourseSelection(HttpServletResponse response, CourseSelection courseSelectionToAdd) throws ServletException {
        Connection dbConnection = null;

        if(courseSelectionToAdd == null || courseSelectionToAdd.getStudentId().isEmpty() || courseSelectionToAdd.getCourseId().isEmpty())
        {
            throw new ServletException("addCourseSelection: studentId or courseId invalid");
        }

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bResult = courseInfoDao.studentAddNewCourseSelection(dbConnection, courseSelectionToAdd);
            response.getWriter().write("success");

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
    private void deleteCourseSelection(HttpServletResponse response, CourseSelection courseSelectionToDelete) throws ServletException {
        Connection dbConnection = null;

        if(courseSelectionToDelete == null || courseSelectionToDelete.getStudentId().isEmpty() || courseSelectionToDelete.getCourseId().isEmpty())
        {
            throw new ServletException("deleteCourseSelection: studentId or courseId invalid");
        }

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bResult = courseInfoDao.studentDeleteCourseSelection(dbConnection, courseSelectionToDelete);
            response.getWriter().write("success");

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
    private void queryCourseSelection(HttpServletResponse response, String currentStudentId) throws ServletException {
        Connection dbConnection = null;
        Collection<CourseSelection> courseSelectionsList = new ArrayList<CourseSelection>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet courseSelectionsQueryResult = courseInfoDao.studentQueryCourseSelection(dbConnection, currentStudentId);
            while (courseSelectionsQueryResult.next())
            {
                CourseSelection singleCourseSelection = new CourseSelection();
                singleCourseSelection.setStudentId(courseSelectionsQueryResult.getString("student_id"));
                singleCourseSelection.setCourseId(courseSelectionsQueryResult.getString("course_id"));
                singleCourseSelection.setCourseName(courseSelectionsQueryResult.getString("course_name"));
                singleCourseSelection.setCourseTeacherUsername(courseSelectionsQueryResult.getString("course_teacher_username"));
                courseSelectionsList.add(singleCourseSelection);
            }

            String resultJson = gson.toJson(courseSelectionsList);
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

        String currentUserId = currentSession.getAttribute("currentUserId").toString();
        if(currentUserId == null || currentUserId.isEmpty())
        {
            throw new ServletException("Student userId invalid!");
        }
        String courseSelectionOperation = request.getParameter("courseSelectionOperation");
        if(courseSelectionOperation == null || courseSelectionOperation.isEmpty())
        {
            throw new ServletException("Parameter courseSelectionOperation is null");
        }

        if(courseSelectionOperation.equals("add")) {
            CourseSelection courseSelectionToAdd = gson.fromJson(request.getParameter("courseSelectionToAdd"), CourseSelection.class);
            courseSelectionToAdd.setStudentId(currentUserId);
            this.addCourseSelection(response, courseSelectionToAdd);

        } else if (courseSelectionOperation.equals("delete")) {
            CourseSelection courseSelectionToDelete = gson.fromJson(request.getParameter("courseSelectionToDelete"), CourseSelection.class);
            courseSelectionToDelete.setStudentId(currentUserId);
            this.deleteCourseSelection(response, courseSelectionToDelete);

        } else {
            // Default: list all courses that student selected
            this.queryCourseSelection(response, currentUserId);
        }

    }
}
