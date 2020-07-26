package priv.softPj.servlet;

import priv.softPj.dao.impl.FriendRequestDaoImpl;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.Friendrequest;
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
        String userName = request.getParameter("searchText");
        long uid = (long) request.getSession().getAttribute("UID");

        UserDaoImpl userDao = new UserDaoImpl();
        FriendRequestDaoImpl friendRequestDao = new FriendRequestDaoImpl();

        if (userName != null) {
            //根据用户名搜索
            List<User> users = userDao.queryUserByName(userName);
            request.setAttribute("users", users);
        }

        //根据用户搜索好友
        List<User> friends = userDao.queryFriendByUID(uid);

        request.setAttribute("friends", friends);

        //根据用户搜请求对应的好友（包括送出和接收）
        List<Friendrequest> requestReceive = friendRequestDao.queryReceiveByUID(uid);
        List<Friendrequest> requestSend = friendRequestDao.querySendByUID(uid);

        request.setAttribute("requestReceive", requestReceive);
        request.setAttribute("requestSend", requestSend);

        request.getRequestDispatcher("html/friends.jsp").forward(request, response);
    }
}
