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

@WebServlet("/home")
public class home extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取轮播图
        ImgFullImpl imgFull = new ImgFullImpl();
        List<ImgFull> imgHot = imgFull.queryImgHot(3);
        request.setAttribute("imgHot", imgHot);
        //获取最新图
        List<ImgFull> imgNew = imgFull.queryImgNew(6);
        request.setAttribute("imgNew", imgNew);

        request.getRequestDispatcher("/html/home.jsp").forward(request, response);
    }
}
