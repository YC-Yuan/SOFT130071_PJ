package priv.softPj.dao;

import priv.softPj.pojo.City;

import java.util.List;

public interface CityDao {
    public City queryById(long cityCode);

    public City queryByName(String cityName);

    public List<City> queryFuzzyByName(String cityName, long num);

    public List<City> queryFuzzyByName(String cityName,String countryName,long num);
}
