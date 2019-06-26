package space.xuefeng.xfzy.util;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class ResponseUtil {

    public static void writeResponseData (HttpServletResponse response, String responseData) throws Exception {
        response.setContentType("application/json;charset=utf-8");
        PrintWriter responseWriter = response.getWriter();
        responseWriter.write(responseData);
        responseWriter.flush();
        responseWriter.close();
    }
}
