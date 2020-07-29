package priv.softPj.servlet.function;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.junit.Test;
import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/uploadImg")
public class uploadImg extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long uid = (long) request.getSession().getAttribute("UID");

        ImgDaoImpl imgDao = new ImgDaoImpl();

        HashMap<String, String> infos = new HashMap<>();

        FileItem img = null;
        String path = null;

        //解析上传数据
        if (ServletFileUpload.isMultipartContent(request)) {
            //创建解析工厂实现类
            FileItemFactory fileItemFactory = new DiskFileItemFactory();

            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            try {
                List<FileItem> fileItems = servletFileUpload.parseRequest(request);

                for (FileItem fileItem : fileItems) {
                    if (fileItem.isFormField()) {//普通表单项
                        infos.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
                    } else if (fileItem.getSize() != 0) {//上传的图片，处理path，储存文件
                        path = fileItem.getName();
                        while (imgDao.queryIsPathExist(path)) {
                            String fileType = tools.getFileType(path);
                            String randomName = Long.toString(tools.getRandomSalt());
                            path = randomName + fileType;
                        }
                        img = fileItem;
                        //img.write(new File("C:/Users/AAA/Desktop/Soft仓库/SOFT130071_PJ/web/img/travel/" + path));
                        img.write(new File(request.getServletContext().getRealPath("img/travel/") + path));
                        System.out.println(request.getServletContext().getRealPath("/img/travel/") + path);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Error in fileItems or writing img!");
            }
        }

        System.out.println(infos);
        //根据解析结果对接数据库
        if (infos.get("imgId") == null) {//新图片上传
            imgDao.insertImg(infos.get("title"), infos.get("description"), infos.get("city"), infos.get("country"), uid, path, infos.get("content"));
            long imgId = imgDao.queryImgByPath(path).getImageId();
            response.sendRedirect("html/details.jsp?imgId=" + imgId);
        } else {
            //老图属性更新
            long imgId = Long.parseLong(infos.get("imgId"));

            String oldPath = imgDao.queryImgById(imgId).getPath();

            imgDao.updateImg(imgId, infos.get("title"), infos.get("description"), infos.get("city"), infos.get("country"), infos.get("content"));
            if (img != null) {//老图图片更新
                imgDao.updateImgPath(imgId, path);

                //删除本地文件中的老图片
                File imgFile=new File(request.getServletContext().getRealPath("/img/travel/")+oldPath);
                if(imgFile.isFile()&&imgFile.exists()){
                    System.out.println("Img delete:"+imgFile.delete());
                }

            }
            response.sendRedirect("html/details.jsp?imgId=" + imgId);
        }

    }
}
