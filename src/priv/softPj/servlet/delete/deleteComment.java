package priv.softPj.servlet.delete;

import priv.softPj.dao.impl.CommentDaoImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteComment")
public class deleteComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long commentId = Long.parseLong(request.getParameter("commentId"));

        CommentDaoImpl commentDao = new CommentDaoImpl();
        commentDao.delete(commentId);

        tools.detailsBack(request, response);
    }
}
