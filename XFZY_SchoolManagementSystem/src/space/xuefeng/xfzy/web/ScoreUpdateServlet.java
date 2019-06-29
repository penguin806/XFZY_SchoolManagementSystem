package space.xuefeng.xfzy.web;

import space.xuefeng.xfzy.dao.ScoreDao;
import space.xuefeng.xfzy.model.Score;
import space.xuefeng.xfzy.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name="ScoreUpdateServlet", urlPatterns ={ "/updateScore" })
public class ScoreUpdateServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    ScoreDao scoreInfoDao = new ScoreDao();

    private void updateScoreOfOneStudentOneCourse(HttpServletResponse response, String studentId, String courseId, String studentCourseScore) {
        Connection dbConnection = null;
        Score scoreOfOneStudentOneCourse = new Score();
        scoreOfOneStudentOneCourse.setStudentId(studentId);
        scoreOfOneStudentOneCourse.setStudentCourseId(courseId);
        scoreOfOneStudentOneCourse.setStudentCourseScore(studentCourseScore);

        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bResult = scoreInfoDao.updateExistingScore(dbConnection, scoreOfOneStudentOneCourse);
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
        String studentCourseScore = request.getParameter("studentCourseScore");
        if (studentId != null && !studentId.isEmpty() && courseId != null && !courseId.isEmpty()
                && studentCourseScore != null && !studentCourseScore.isEmpty())
        {
            this.updateScoreOfOneStudentOneCourse(response, studentId, courseId, studentCourseScore);
        }
        else {
            throw new ServletException("Parameter studentId/courseId/studentCourseScore invalid!");
        }
    }

}
