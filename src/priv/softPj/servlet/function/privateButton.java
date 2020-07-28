package priv.softPj.servlet.function;

import priv.softPj.dao.impl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/privateButton")
public class privateButton extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDaoImpl userDao = new UserDaoImpl();

        long uid = (long) request.getSession().getAttribute("UID");

        userDao.favorPrivate(uid);

        request.getRequestDispatcher("html/favor.jsp").forward(request,response);
    }
}
