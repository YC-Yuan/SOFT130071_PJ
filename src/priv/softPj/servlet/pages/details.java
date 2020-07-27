package priv.softPj.servlet.pages;

import priv.softPj.dao.impl.HistoryDaoImpl;
import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.dao.impl.ImgfavorDaoImpl;
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

@WebServlet("/details")
public class details extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImgFullImpl imgFullImpl=new ImgFullImpl();
        ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();

        long imgId = Long.parseLong(request.getParameter("imgId"));
        ImgFull imgFull=imgFullImpl.queryImgFull(imgId);

        if (request.getSession().getAttribute("UID") != null) {
            long uid = (long) request.getSession().getAttribute("UID");
            long isFavored = imgfavorDao.queryIsFavored(uid, imgId);
            request.setAttribute("isFavored", isFavored);

            //记录足迹
            HistoryDaoImpl historyDao = new HistoryDaoImpl();
            historyDao.insertHistory(uid,imgId);
        }

        request.setAttribute("imgFull", imgFull);
        request.getRequestDispatcher("/html/details.jsp").forward(request, response);
    }
}
