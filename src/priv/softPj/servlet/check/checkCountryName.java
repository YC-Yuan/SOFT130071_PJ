package priv.softPj.servlet.check;

import priv.softPj.dao.impl.CountryDaoImpl;
import priv.softPj.pojo.Country;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/checkCountryName")
public class checkCountryName extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("test/html;charset=utf-8");

        String countryName = request.getParameter("countryName");

        CountryDaoImpl countryDao = new CountryDaoImpl();
        List<Country> countries = countryDao.queryFuzzyByName(countryName, 5);

        Country country = countryDao.queryByName(countryName);//找不到返回null

        PrintWriter writer = response.getWriter();

        if (country != null) writer.print("true");
        else if (countries.size() == 0) writer.print("false");
        else {
            for (int i = 0; i < countries.size(); i++) {
                if (i == 0) writer.print(countries.get(0).getCountryName());
                else writer.print("|" + countries.get(i).getCountryName());
            }
        }
    }
}
