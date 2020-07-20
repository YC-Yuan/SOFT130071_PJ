package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.CountryDao;
import priv.softPj.pojo.Country;

import java.util.List;

public class CountryDaoImpl extends BaseDao implements CountryDao {
    @Override
    public Country queryById(String countryCode) {
        String sql = "SELECT * FROM `country` WHERE CountryCode=?";
        return queryForOne(Country.class, sql, countryCode);
    }

    @Override
    public Country queryByName(String countryName) {
        String sql = "SELECT * FROM `country` WHERE CountryName=?";
        return queryForOne(Country.class, sql, countryName);
    }

    @Override
    public List<Country> queryFuzzyByName(String countryName, long num) {
        String sql = "SELECT * FROM `country` WHERE CountryName LIKE ? LIMIT ?";
        countryName="%"+countryName+"%";
        return queryForList(Country.class, sql, countryName, num);
    }
}
