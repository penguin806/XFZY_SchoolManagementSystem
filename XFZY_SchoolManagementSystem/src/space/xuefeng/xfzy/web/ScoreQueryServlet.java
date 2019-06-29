package space.xuefeng.xfzy.web;

import com.google.gson.Gson;
import space.xuefeng.xfzy.dao.ScoreDao;
import space.xuefeng.xfzy.model.Score;
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

@WebServlet(name="ScoreQueryServlet", urlPatterns ={ "/queryScore" })
public class ScoreQueryServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    ScoreDao scoreInfoDao = new ScoreDao();
    Gson gson = new Gson();

    private void queryAllScoreOfOneStudent(HttpServletResponse response, String studentId) {
        Connection dbConnection = null;
        Collection<Score> scoreList = new ArrayList<Score>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet coursesQueryResult = scoreInfoDao.listAllScoreOfOneStudent(dbConnection, studentId);
            while (coursesQueryResult.next())
            {
                Score singleScore = new Score();
                singleScore.setStudentId(coursesQueryResult.getString("student_id"));
                singleScore.setStudentCourseId(coursesQueryResult.getString("student_course_id"));
                singleScore.setStudentCourseName(coursesQueryResult.getString("course_name"));
                singleScore.setStudentCourseScore(coursesQueryResult.getString("score"));
                scoreList.add(singleScore);
            }

            String resultJson = gson.toJson(scoreList);
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

    private void queryAllScoreOfOneCourse(HttpServletResponse response, String courseId) {
        Connection dbConnection = null;
        Collection<Score> studentAndScoreList = new ArrayList<Score>();

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            ResultSet coursesQueryResult = scoreInfoDao.queryAllStudentScoreOfOneCourse(dbConnection, courseId);
            while (coursesQueryResult.next())
            {
                Score singleStudentAndScore = new Score();
                singleStudentAndScore.setStudentId(coursesQueryResult.getString("id"));
                singleStudentAndScore.setStudentUsername(coursesQueryResult.getString("username"));
                singleStudentAndScore.setStudentRealname(coursesQueryResult.getString("realname"));
                singleStudentAndScore.setStudentCourseId(coursesQueryResult.getString("course_id"));
                singleStudentAndScore.setStudentCourseName(null);
                singleStudentAndScore.setStudentCourseScore(coursesQueryResult.getString("score"));
                studentAndScoreList.add(singleStudentAndScore);
            }

            String resultJson = gson.toJson(studentAndScoreList);
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
        if (!currentSession.getAttribute("currentRole").toString().equals("admin")) {
//            throw new ServletException("Access Denied!");
        }

        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");
        if (null != studentId && !studentId.isEmpty()) {
            this.queryAllScoreOfOneStudent(response, studentId);

        } else if (null != courseId && !courseId.isEmpty()) {
            this.queryAllScoreOfOneCourse(response, courseId);

        }
        else {
            throw new ServletException("Parameter studentId invalid!");
        }
    }

}
