package priv.softPj.servlet;

import com.sun.deploy.net.HttpResponse;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class tools {
    public static void back(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        String prePage = (String) session.getAttribute("prePage");
        if (prePage == null) response.sendRedirect("html/home.jsp");
        else response.sendRedirect(prePage);
    }

    public static void back(HttpSession session, HttpServletResponse response) throws IOException {
        String prePage = (String) session.getAttribute("prePage");
        if (prePage == null) response.sendRedirect("html/home.jsp");
        else response.sendRedirect(prePage);
    }
}
