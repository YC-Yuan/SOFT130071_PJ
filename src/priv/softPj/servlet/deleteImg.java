package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteImg")
public class deleteImg extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据图片id删除图片
        long deleteId = Long.parseLong(request.getParameter("deleteId"));

        ImgDaoImpl imgDao = new ImgDaoImpl();
        imgDao.deleteImg(deleteId);

        tools.back(request, response);
    }
}
