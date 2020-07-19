package priv.softPj.servlet;

import priv.softPj.dao.ImgfavorDao;
import priv.softPj.dao.impl.ImgfavorDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/favorButton")
public class favorButton extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取UID和ImageId
        String change = request.getParameter("change");
        long uid = Long.parseLong(request.getParameter("UID"));
        long imgId = Long.parseLong(request.getParameter("imgId"));
        long favorNum=0;

        ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();

        System.out.println("Parameter of favorButton");
        System.out.println(change + "&" + uid + "&" + imgId);
        //根据按钮状态选择
        if (change.equals("true")) {
            //已经收藏，需要取消
            imgfavorDao.unFavor(uid, imgId);
        } else {
            //还没收藏，需要收藏
            imgfavorDao.doFavor(uid, imgId);
        }
        favorNum = imgfavorDao.queryFavorNum(imgId);
        response.getWriter().print(favorNum);
    }
}
