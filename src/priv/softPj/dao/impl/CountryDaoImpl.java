package priv.softPj.dao.impl;

import priv.softPj.dao.CountryDao;
import priv.softPj.pojo.Country;

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
}
