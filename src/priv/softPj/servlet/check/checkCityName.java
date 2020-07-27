package priv.softPj.servlet.check;

import priv.softPj.dao.impl.CityDaoImpl;
import priv.softPj.dao.impl.CountryDaoImpl;
import priv.softPj.pojo.City;
import priv.softPj.pojo.Country;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/checkCityName")
public class checkCityName extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("test/html;charset=utf-8");
        PrintWriter writer = response.getWriter();

        String countryName = request.getParameter("countryName");
        String cityName = request.getParameter("cityName");

        CityDaoImpl cityDao = new CityDaoImpl();
        List<City> cities = cityDao.queryFuzzyByName(cityName, countryName, 5);
        City city = cityDao.queryByName(cityName);

        if (city != null) writer.print("true");
        else if (cities.size() == 0) writer.print("false");
        else {
            for (int i = 0; i < cities.size(); i++) {
                if (i == 0) writer.print(cities.get(0).getCityName());
                else writer.print("|" + cities.get(i).getCityName());
            }
        }
    }
}
