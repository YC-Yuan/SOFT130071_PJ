package priv.softPj.servlet;

import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/login")
public class login extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        UserDaoImpl impl = new UserDaoImpl();
        User user = impl.queryLogin(userName, password);

        if (user == null) {//登陆失败
            request.getRequestDispatcher("html/login.jsp").forward(request, response);
        } else {//登陆成功

            long UID = user.getUid();
            HttpSession session = request.getSession();
            session.setAttribute("UID", UID);

            tools.back(session,response);
        }
    }
}
