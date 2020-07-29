package priv.softPj.servlet.function;

import priv.softPj.dao.impl.CommentDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/postComment")
public class postComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postComment = request.getParameter("postComment");
        String userName = request.getParameter("userName");
        long imgId = Long.parseLong(request.getParameter("imgId"));
        long uid = (long) request.getSession().getAttribute("UID");


        CommentDaoImpl commentDao = new CommentDaoImpl();

        commentDao.insert(imgId, uid, postComment, userName);

        response.sendRedirect("html/details.jsp?imgId=" + imgId);
    }
}
