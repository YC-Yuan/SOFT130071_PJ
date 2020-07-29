package priv.softPj.servlet.function;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import priv.softPj.pojo.combination.ImgFull;
import priv.softPj.service.impl.ImgFullImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/getFullImg")
public class getFullImg extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long imgId = Long.parseLong(request.getParameter("imgId"));

        ImgFullImpl imgFull = new ImgFullImpl();
        ImgFull img = imgFull.queryImgFull(imgId);

        request.setAttribute("imgFull", img);
        request.getRequestDispatcher("/html/upload.jsp").forward(request, response);
    }
}
