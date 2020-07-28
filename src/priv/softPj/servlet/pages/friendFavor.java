package priv.softPj.servlet.pages;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.Img;
import priv.softPj.pojo.User;
import priv.softPj.pojo.combination.ImgHistory;
import priv.softPj.service.impl.ImgHistoryImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/friendFavor")
public class friendFavor extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据页码获取好友的的图片
        ImgDaoImpl imgDao = new ImgDaoImpl();
        UserDaoImpl userDao = new UserDaoImpl();

        long pageCapacity = 6;

        //这里用好友的收藏
        long uid = Long.parseLong(request.getParameter("friendUID"));
        long page = (long) request.getAttribute("page");
        long start = pageCapacity * (page - 1);
        long end = pageCapacity * page;

        List<Img> img = imgDao.queryImgFavoredByUidLimited(uid, start, end);
        request.setAttribute("img", img);

        List<Img> imgAll = imgDao.queryImgFavoredByUID(uid);
        request.setAttribute("num", imgAll.size());
        request.setAttribute("pageNum", tools.ceilFloor(imgAll.size(),pageCapacity));

        //根据UID获取足迹
        ImgHistoryImpl imgHistory = new ImgHistoryImpl();
        List<ImgHistory> imgHistoryList = imgHistory.queryHistory(uid);
        request.setAttribute("history",imgHistoryList);

        //搜一下好友的人
        User user = userDao.queryUserByUID(uid);
        request.setAttribute("friend",user);

        request.getRequestDispatcher("/html/friendFavor.jsp").forward(request, response);
    }
}
