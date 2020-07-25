package priv.softPj.servlet;

import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/friends")
public class friends extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据用户名搜索
        String userName=request.getParameter("userName");

        UserDaoImpl userDao = new UserDaoImpl();
        List<User> users = userDao.queryUserByName(userName);

        request.setAttribute("users",users);

        //根据用户搜索好友
        long uid = (long) request.getSession().getAttribute("UID");
        List<User> friends = userDao.queryFriendByUID(uid);

        request.setAttribute("friends",friends);

        //根据用户搜请求对应的好友（包括送出和接收）
    }
}
