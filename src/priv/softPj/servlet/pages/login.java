package priv.softPj.servlet.pages;

import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.awt.*;
import java.io.IOException;


@WebServlet("/login")
public class login extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");

        String userName = request.getParameter("userName");//用户名或密码
        String password = request.getParameter("password");

        UserDaoImpl impl = new UserDaoImpl();
        User user = impl.queryLogin(userName, password);

        if (user == null) {//登陆失败
            request.getRequestDispatcher("html/login.jsp").forward(request, response);
        } else {//登陆成功

            long UID = user.getUid();
            HttpSession session = request.getSession();
            session.setAttribute("UID", UID);
            request.setAttribute("userName",userName);

            request.getRequestDispatcher("html/common/alertWelcome.jsp").forward(request,response);
        }
    }
}
