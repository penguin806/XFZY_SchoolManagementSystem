package space.xuefeng.xfzy.web;

import space.xuefeng.xfzy.dao.UserLoginDao;
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

@WebServlet(name = "loginServlet", urlPatterns = { "/loginServlet" })
public class LoginServlet extends HttpServlet {
    DatabaseUtil dbUtil = new DatabaseUtil();
    UserLoginDao userLoginDao = new UserLoginDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // super.doGet(req, resp);
        // Not handled
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        request.setAttribute("username", username);
        request.setAttribute("password", password);

        if(username.isEmpty() || password.isEmpty())
        {
            request.setAttribute("error", "Username or password is empty!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User loginUser = new User(username, password);
        Connection dbConnection = null;
        try {
            dbConnection = dbUtil.getDatabaseConnection();
            boolean bResult = userLoginDao.isUserLoginVerificationSuccess(dbConnection, loginUser);
            if(!bResult)
            {
                request.setAttribute("error","Username or password incorrect!");
                request.getRequestDispatcher("login.jsp").forward(request, response);

            } else {
                HttpSession currentHttpSession = request.getSession();
                currentHttpSession.setAttribute("LoginSuccessUser", loginUser.getUserName());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            try {
                dbUtil.closeDatabaseConnection(dbConnection);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }

}
