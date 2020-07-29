package priv.softPj.servlet.pages;

import priv.softPj.dao.impl.*;
import priv.softPj.pojo.Comment;
import priv.softPj.pojo.Img;
import priv.softPj.pojo.combination.ImgFull;
import priv.softPj.service.impl.ImgFullImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.server.UID;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/details")
public class details extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImgFullImpl imgFullImpl = new ImgFullImpl();
        ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();
        CommentDaoImpl commentDao = new CommentDaoImpl();
        CommentFavorDaoImpl commentFavorDao = new CommentFavorDaoImpl();

        long imgId = Long.parseLong(request.getParameter("imgId"));
        ImgFull imgFull = imgFullImpl.queryImgFull(imgId);
        request.setAttribute("imgFull", imgFull);

        //查询图片关联评论（根据参数给定方式）
        String orderMethod = request.getParameter("orderMethod");
        if (orderMethod == null) orderMethod = "byTime";
        List<Comment> comments;
        if (orderMethod.equals("byTime")) {
            comments = commentDao.queryByTime(imgId);
        } else {
            comments = commentDao.queryByHeat(imgId);
        }
        request.setAttribute("comments", comments);

        if (request.getSession().getAttribute("UID") != null) {
            long uid = (long) request.getSession().getAttribute("UID");
            long isFavored = imgfavorDao.queryIsFavored(uid, imgId);
            request.setAttribute("isFavored", isFavored);

            //记录足迹
            HistoryDaoImpl historyDao = new HistoryDaoImpl();
            historyDao.insertHistory(uid, imgId);

            //查询是否是自己的图片
            long author = imgFull.getUser().getUid();
            boolean isMine = author == uid;
            request.setAttribute("isMine", isMine);

            //根据uid查看是否收藏各个评论
            List<Long> commentFavors = new ArrayList<Long>();
            comments.forEach(comment -> {
                commentFavors.add(commentFavorDao.isFavored(comment.getCommentId(), uid));
            });
            request.setAttribute("commentFavors", commentFavors);
        }

        request.getRequestDispatcher("/html/details.jsp").forward(request, response);
    }
}
