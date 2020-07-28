package priv.softPj.servlet;

import com.sun.deploy.net.HttpRequest;
import com.sun.deploy.net.HttpResponse;
import org.junit.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class tools {
    public static void back(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("prePage") != null) {
            String prePage = session.getAttribute("prePage").toString();
            response.sendRedirect(prePage);
        } else response.sendRedirect("html/home.jsp");
    }

    public static void back(HttpSession session, HttpServletResponse response) throws IOException {
        if (session.getAttribute("prePage") != null) {
            String prePage = session.getAttribute("prePage").toString();
            response.sendRedirect(prePage);
        } else response.sendRedirect("html/home.jsp");
    }

    public static String getSha1(byte[] input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input);
        StringBuilder sb = new StringBuilder();
        for (byte b : result) {
            sb.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
        }
        return sb.toString();
    }

    public  static long getRandomSalt(){
        return (long) (Math.random() * Math.pow(10, 10));
    }

    public static String getFileType(String name){
        return name.substring(name.lastIndexOf('.'));
    }

    public static boolean deleteImgFile(String name){
        File imgFile=new File("C:/Users/AAA/Desktop/Soft仓库/SOFT130071_PJ/web/img/travel/"+name);
        if(imgFile.isFile()&&imgFile.exists()){
            return imgFile.delete();
        }
        else return false;
    }

    public static long ceilFloor(long a,long b){
        return (long) Math.ceil((double)a/b);
    }

    public static void friendBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(request.getSession().getAttribute("friendParameter")==null){
            response.sendRedirect("html/friends.jsp");
        }else{
            String friendParameter = (String) request.getSession().getAttribute("friendParameter");
            response.sendRedirect("friends?searchText="+friendParameter);
        }
    }
}
