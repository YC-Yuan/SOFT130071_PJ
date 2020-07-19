package priv.softPj.service.impl;

import priv.softPj.dao.impl.*;
import priv.softPj.pojo.City;
import priv.softPj.pojo.Country;
import priv.softPj.pojo.Img;
import priv.softPj.pojo.User;
import priv.softPj.pojo.combination.ImgFull;
import priv.softPj.service.ImgFullService;

import java.rmi.server.UID;
import java.util.ArrayList;
import java.util.List;

public class ImgFullImpl implements ImgFullService {
    @Override
    public ImgFull queryImgFull(long imgId) {
        ImgDaoImpl imgDao = new ImgDaoImpl();
        UserDaoImpl userDao = new UserDaoImpl();
        CityDaoImpl cityDao = new CityDaoImpl();
        CountryDaoImpl countryDao = new CountryDaoImpl();
        ImgfavorDaoImpl imgfavorDao = new ImgfavorDaoImpl();

        Img img = imgDao.queryImgById(imgId);
        User user = userDao.queryUserByUID(img.getUid());
        City city = cityDao.queryById(img.getCityCode());
        Country country = countryDao.queryById(img.getCountryCode());
        long favorNum = imgfavorDao.queryFavorNum(imgId);

        ImgFull imgFull = new ImgFull();
        imgFull.setImg(img);
        imgFull.setUser(user);
        imgFull.setCity(city);
        imgFull.setCountry(country);
        imgFull.setFavorNum(favorNum);

        return imgFull;
    }

    @Override
    public List<ImgFull> queryImgHot(long num) {
        ImgDaoImpl imgDao = new ImgDaoImpl();
        UserDaoImpl userDao = new UserDaoImpl();

        List<Img> imgHot = imgDao.queryImgHot(num);
        List<ImgFull> imgFullList = new ArrayList<ImgFull>();
        for (int i = 0; i < imgHot.size(); i++) {

        }
        imgHot.forEach(img -> {
            ImgFull imgFull = new ImgFull();
            imgFull.setImg(img);
            imgFull.setUser(userDao.queryUserByUID(img.getUid()));
            imgFullList.add(imgFull);
        });

        return imgFullList;
    }

    @Override
    public List<ImgFull> queryImgNew(long num) {
        ImgDaoImpl imgDao = new ImgDaoImpl();
        UserDaoImpl userDao = new UserDaoImpl();

        List<Img> imgNew = imgDao.queryImgNew(num);
        List<ImgFull> imgFullList = new ArrayList<ImgFull>();
        for (int i = 0; i < imgNew.size(); i++) {

        }
        imgNew.forEach(img -> {
            ImgFull imgFull = new ImgFull();
            imgFull.setImg(img);
            imgFull.setUser(userDao.queryUserByUID(img.getUid()));
            imgFullList.add(imgFull);
        });
        return imgFullList;
    }
}