package priv.softPj.servlet.request;

import priv.softPj.dao.impl.FriendRequestDaoImpl;
import priv.softPj.servlet.tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteRequest")
public class deleteRequest extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long deleteId = Long.parseLong(request.getParameter("deleteId"));

        FriendRequestDaoImpl friendRequestDao = new FriendRequestDaoImpl();

        friendRequestDao.deleteRequest(deleteId);

        tools.friendBack(request,response);
    }
}
