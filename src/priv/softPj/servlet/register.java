package priv.softPj.servlet;

import org.junit.Test;
import priv.softPj.dao.UserDao;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.DigestMethod;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");


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
}
