package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.dao.impl.ImgfavorDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteFavor")
public class deleteFavor extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long uid=Long.parseLong(request.getParameter("UID"));
        long deleteId=Long.parseLong(request.getParameter("deleteId"));

        ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();
        imgfavorDao.unFavor(uid,deleteId);

        tools.back(request,response);
    }
}
