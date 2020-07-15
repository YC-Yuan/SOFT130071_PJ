package priv.softPj.servlet;

import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class login extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest req,HttpServletResponse resp) {
        resp.setHeader("Content-Type","text/html;charset=utf-8");

        String userName = req.getParameter("userName");
        String password = req.getParameter("password");

        UserDaoImpl impl = new UserDaoImpl();

        User user = impl.queryLogin(userName,password);

        if (user == null) {


        }
        else {
            int UID = (int) user.getUid();
            HttpSession session = req.getSession();
            session.setAttribute("UID",UID);
            try {
                resp.sendRedirect("./html/favor.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
