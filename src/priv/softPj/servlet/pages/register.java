package priv.softPj.servlet.pages;

import org.junit.Test;
import priv.softPj.dao.UserDao;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;
import priv.softPj.servlet.tools;
import sun.security.provider.MD5;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("--------register--------");
        System.out.println("userName = " + userName);
        System.out.println("email = " + email);
        System.out.println("password = " + password);

        //密码加密,pass为加密结果，password为输入内容
        long salt = tools.getRandomSalt();
        String pass = "";
        try {
            pass = tools.getSha1((password + salt).getBytes(StandardCharsets.UTF_8));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        UserDaoImpl userDao = new UserDaoImpl();
        userDao.updateRegister(userName, email, pass, salt);
        User user = userDao.queryLogin(userName, password);


        long UID = user.getUid();
        HttpSession session = request.getSession();
        session.setAttribute("UID", UID);

        tools.back(session, response);
    }

    //清洗加密密码
    @Test
    public void test() throws NoSuchAlgorithmException {

        long uid = 42;
        String password = "abcd1234";

        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.queryUserByUID(uid);
        String salt = user.getSalt();
        String sha1 = tools.getSha1(password.getBytes(StandardCharsets.UTF_8));
        String sha11 = tools.getSha1((sha1 + salt).getBytes(StandardCharsets.UTF_8));

        String sql = "update user set Password = ? WHERE UID = ?";
        userDao.update(sql, sha11, uid);
    }
}
