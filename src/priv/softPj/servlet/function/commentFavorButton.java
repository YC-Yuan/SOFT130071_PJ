package priv.softPj.servlet.function;

import priv.softPj.dao.impl.CommentFavorDaoImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/commentFavorButton")
public class commentFavorButton extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long commentId = Long.parseLong(request.getParameter("commentId"));
        long uid = (long) request.getSession().getAttribute("UID");

        CommentFavorDaoImpl commentFavorDao = new CommentFavorDaoImpl();
        long favored = commentFavorDao.isFavored(commentId, uid);
        if (favored == 0) {
            commentFavorDao.doFavor(commentId, uid);
        } else {
            commentFavorDao.unFavor(commentId, uid);
        }

        tools.detailsBack(request,response);
    }
}
