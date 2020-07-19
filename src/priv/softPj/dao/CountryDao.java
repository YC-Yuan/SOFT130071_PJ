package priv.softPj.dao;

import priv.softPj.pojo.Country;

public interface CountryDao {
    public Country queryById(String countryCode);

    public Country queryByName(String countryName);
}
