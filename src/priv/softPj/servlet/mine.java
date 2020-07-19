package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.pojo.Img;
import priv.softPj.pojo.combination.ImgFull;
import priv.softPj.service.impl.ImgFullImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/mine")
public class mine extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据页码获取我的图片
        ImgDaoImpl imgDao = new ImgDaoImpl();

        long pageCapacity = 6;
        long uid = (long) request.getSession().getAttribute("UID");
        long page = (long) request.getAttribute("page");
        long start = pageCapacity * (page - 1);
        long end = pageCapacity * page;

        List<Img> img = imgDao.queryImgByUIDLimited(uid, start, end);
        request.setAttribute("img", img);

        List<Img> imgAll = imgDao.queryImgByUID(uid);
        request.setAttribute("num", imgAll.size());
        request.setAttribute("pageNum", imgAll.size() / pageCapacity + 1);

        request.getRequestDispatcher("/html/mine.jsp").forward(request, response);
    }
}