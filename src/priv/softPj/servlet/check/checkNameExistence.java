package priv.softPj.servlet.check;

import priv.softPj.dao.impl.UserDaoImpl;
import priv.softPj.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/checkNameExistence")
public class checkNameExistence extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName=request.getParameter("userName");
        response.setContentType("test/html;charset=utf-8");

        UserDaoImpl userDao=new UserDaoImpl();
        if(userDao.queryUserNameExist(userName)){
            response.getWriter().print("exist");
        }
    }
}
