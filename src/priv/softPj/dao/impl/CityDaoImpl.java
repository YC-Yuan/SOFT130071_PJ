package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.CityDao;
import priv.softPj.pojo.City;

public class CityDaoImpl extends BaseDao implements CityDao {
    @Override
    public City queryById(long cityCode) {
        String sql="SELECT * FROM `city` WHERE CityCode=?";
        return queryForOne(City.class,sql,cityCode);
    }

    @Override
    public City queryByName(String cityName) {
        String sql="SELECT * FROM `city` WHERE `CityName` = ?";
        return queryForOne(City.class,sql,cityName);
    }
}
