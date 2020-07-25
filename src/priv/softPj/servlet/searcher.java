package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.pojo.Img;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searcher")
public class searcher extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据页码和条件搜索图片
        ImgDaoImpl imgDao = new ImgDaoImpl();

        long pageCapacity = 9;
        long page = Long.parseLong(request.getParameter("page"));

        long start = pageCapacity * (page - 1);
        long end = pageCapacity * page;

        //获取条件
        String searchText = request.getParameter("searchText");
        String searchMethod = request.getParameter("searchMethod");
        String orderMethod = request.getParameter("orderMethod");

        System.out.println("--------------------");
        System.out.println("page = " + page);
        System.out.println("searchText = " + searchText);
        System.out.println("searchMethod = " + searchMethod);
        System.out.println("orderMethod = " + orderMethod);

        List<Img> imgAll = null;

        if (orderMethod.equals("byTime")) {//按时间排序搜索
            if (searchMethod.equals("byTitle")) imgAll = imgDao.queryImgByTitleOrderedByTime(searchText);
            else imgAll = imgDao.queryImgByContentOrderedByTime(searchText);
        } else {//按热度排序搜索
            if (searchMethod.equals("byTitle")) imgAll = imgDao.queryImgByTitleOrderedByHeat(searchText);
            else imgAll = imgDao.queryImgByContentOrderedByHeat(searchText);
        }

        start = Math.min(start, imgAll.size());
        end = Math.min(end, imgAll.size());
        List<Img> img = imgAll.subList((int) start, (int) end);

        request.setAttribute("img", img);
        System.out.println("img size:" + img.size());
        System.out.println("imgAll size:" + imgAll.size());
        System.out.println("num:"+imgAll.size());
        System.out.println("pageNum:"+Math.floorDiv(imgAll.size(), pageCapacity));

        request.setAttribute("num", imgAll.size());
        request.setAttribute("pageNum", Math.floorDiv(imgAll.size(), pageCapacity));

        request.getRequestDispatcher("/html/search.jsp").forward(request, response);
    }
}
