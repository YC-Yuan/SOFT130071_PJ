package priv.softPj.dao;

import priv.softPj.pojo.Country;

import java.util.List;

public interface CountryDao {
    public Country queryById(String countryCode);

    public Country queryByName(String countryName);

    public List<Country> queryFuzzyByName(String countryName, long num);
}
