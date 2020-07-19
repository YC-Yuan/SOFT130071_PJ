package priv.softPj.dao;

import priv.softPj.pojo.City;

public interface CityDao {
    public City queryById(long cityCode);

    public City queryByName(String cityName);
}
