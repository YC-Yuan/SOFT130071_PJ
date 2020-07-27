package priv.softPj.servlet.function;

import priv.softPj.dao.impl.FriendRequestDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/sendRequest")
public class sendRequest extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long toUID = Long.parseLong(request.getParameter("toUID"));
        long UID= (long) request.getSession().getAttribute("UID");

        FriendRequestDaoImpl friendRequestDao = new FriendRequestDaoImpl();
        friendRequestDao.sendRequest(UID,toUID);

        response.sendRedirect("html/friends.jsp");
    }
}
