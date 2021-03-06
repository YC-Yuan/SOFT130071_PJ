package priv.softPj.servlet.request;

import com.sun.javafx.scene.SceneEventDispatcher;
import priv.softPj.dao.impl.FriendRequestDaoImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/acceptRequest")
public class acceptRequest extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long acceptId = Long.parseLong(request.getParameter("acceptId"));
        long UID= (long) request.getSession().getAttribute("UID");

        FriendRequestDaoImpl friendRequestDao = new FriendRequestDaoImpl();
        friendRequestDao.acceptRequest(acceptId);

        tools.friendBack(request,response);
    }
}
