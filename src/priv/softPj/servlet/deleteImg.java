package priv.softPj.servlet;

import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.pojo.Img;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@WebServlet("/deleteImg")
public class deleteImg extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据图片id删除图片
        long deleteId = Long.parseLong(request.getParameter("deleteId"));

        ImgDaoImpl imgDao = new ImgDaoImpl();

        Img img=imgDao.queryImgById(deleteId);

        imgDao.deleteImg(deleteId);

        //File imgFile=new File("C:/Users/AAA/Desktop/Soft仓库/SOFT130071_PJ/web/img/travel/"+img.getPath());
        File imgFile=new File(request.getServletContext().getRealPath("/img/travel/")+img.getPath());
        if(imgFile.isFile()&&imgFile.exists()){
            System.out.println("Img delete:"+imgFile.delete());
        }

        response.sendRedirect("html/mine.jsp");
    }
}
