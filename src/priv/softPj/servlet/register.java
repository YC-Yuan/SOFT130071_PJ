package priv.softPj.servlet;

import priv.softPj.dao.UserDao;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "/register")
public class register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDaoImpl userDao = new UserDaoImpl();
        userDao.updateRegister(userName, email, password);
        User user = userDao.queryLogin(userName, password);

        long UID = user.getUid();
        HttpSession session = request.getSession();
        session.setAttribute("UID", UID);

        tools.back(session,response);
    }
}
