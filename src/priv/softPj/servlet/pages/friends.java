package priv.softPj.servlet.pages;

import priv.softPj.dao.impl.FriendRequestDaoImpl;
import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.Friendrequest;
import priv.softPj.pojo.User;
import priv.softPj.pojo.combination.FriendRequestFull;
import priv.softPj.service.impl.FRFullImpl;

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

        FRFullImpl frFull = new FRFullImpl();
        FriendRequestDaoImpl friendRequestDao = new FriendRequestDaoImpl();

        System.out.println("--------Friends---------");

        if (userName != null) {
            System.out.println("userName = " + userName);
            //根据用户名搜索
            List<FriendRequestFull> users = frFull.queryUserByName(uid, userName);
            request.setAttribute("users",users);
            request.getSession().setAttribute("friendParameter", userName);
            System.out.println("users = " + users);
        }

        //根据用户搜索好友
        List<User> friends = friendRequestDao.queryFriendsByUID(uid);

        request.setAttribute("friends", friends);

        //根据用户搜请求对应的好友（包括送出和接收）
        List<FriendRequestFull> requestReceive = frFull.queryReceiveByUID(uid);
        List<FriendRequestFull> requestSend = frFull.querySentByUID(uid);


        request.setAttribute("requestReceive", requestReceive);
        request.setAttribute("requestSend", requestSend);

        System.out.println("friends = " + friends);
        System.out.println("requestReceive = " + requestReceive);
        System.out.println("requestSend = " + requestSend);


        request.getRequestDispatcher("html/friends.jsp").forward(request, response);
    }
}