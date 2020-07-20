package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.pojo.Img;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.function.Consumer;

@WebServlet("/favor")
public class favor extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据页码获取我的图片
        ImgDaoImpl imgDao = new ImgDaoImpl();

        long pageCapacity = 6;
        long uid = (long) request.getSession().getAttribute("UID");
        long page = (long) request.getAttribute("page");
        long start = pageCapacity * (page - 1);
        long end = pageCapacity * page;

        List<Img> img = imgDao.queryImgFavoredByUidLimited(uid, start, end);
        request.setAttribute("img", img);

        List<Img> imgAll = imgDao.queryImgFavoredByUID(uid);
        request.setAttribute("num", imgAll.size());
        request.setAttribute("pageNum", imgAll.size() / pageCapacity + 1);

        PrintWriter writer = response.getWriter();
        for (Img image:img
             ) {
            writer.print("");
        }

        request.getRequestDispatcher("/html/favor.jsp").forward(request, response);
    }
}
