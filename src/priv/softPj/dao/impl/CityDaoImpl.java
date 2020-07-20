package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.CityDao;
import priv.softPj.pojo.City;

import java.util.List;

public class CityDaoImpl extends BaseDao implements CityDao {
    @Override
    public City queryById(long cityCode) {
        String sql = "SELECT * FROM `city` WHERE CityCode=?";
        return queryForOne(City.class, sql, cityCode);
    }

    @Override
    public City queryByName(String cityName) {
        String sql = "SELECT * FROM `city` WHERE `CityName` = ?";
        return queryForOne(City.class, sql, cityName);
    }

    @Override
    public List<City> queryFuzzyByName(String cityName, long num) {
        String sql = "SELECT * FROM `city` WHERE `CityName` LIKE '?' LIMIT ?";
        cityName="%"+cityName+"%";
        return queryForList(City.class, sql, cityName, num);
    }

    @Override
    public List<City> queryFuzzyByName(String cityName, String countryName, long num) {
        CountryDaoImpl countryDao = new CountryDaoImpl();
        String countryCode = countryDao.queryByName(countryName).getCountryCode();

        String sql = "SELECT * FROM `city` WHERE `CountryCode` = ? AND `CityName` LIKE ? LIMIT ?";
        cityName="%"+cityName+"%";
        return queryForList(City.class, sql, countryCode, cityName, num);
    }
}
