package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.ImgDao;
import priv.softPj.pojo.Img;
import priv.softPj.servlet.tools;

import java.util.List;

public class ImgDaoImpl extends BaseDao implements ImgDao {
    @Override
    public Img queryImgById(long imgId) {
        String sql = "select * from img where ImageID = ?";
        return queryForOne(Img.class, sql, imgId);
    }

    @Override
    public List<Img> queryImgByUID(long UID) {
        String sql = "select * from img where UID = ?";
        return queryForList(Img.class, sql, UID);
    }

    @Override
    public List<Img> queryImgByUIDLimited(long UID, long start, long end) {
        String sql = "select * from img where UID = ? LIMIT ?,?";
        return queryForList(Img.class, sql, UID, start, end);
    }

    @Override
    public List<Img> queryImgByTitleOrderedByTime(String title) {
        String sql="SELECT * FROM `img` WHERE Title LIKE concat('%',?,'%') ORDER BY Time DESC";
        return queryForList(Img.class,sql,title);
    }

    @Override
    public List<Img> queryImgByTitleOrderedByHeat(String title) {
        String sql="SELECT img.*,COUNT(imgfavor.ImageID) as favorNum\n" +
                "FROM img LEFT JOIN imgfavor ON imgfavor.ImageID=img.ImageID\n" +
                "WHERE img.Title LIKE concat('%',?,'%')\n" +
                "GROUP BY img.ImageID\n" +
                "ORDER BY favorNum DESC";
        return queryForList(Img.class,sql,title);
    }

    @Override
    public List<Img> queryImgByContentOrderedByTime(String content) {
        String sql="SELECT * FROM `img` WHERE Content LIKE concat('%',?,'%') ORDER BY Time DESC";
        return queryForList(Img.class,sql,content);
    }

    @Override
    public List<Img> queryImgByContentOrderedByHeat(String content) {
        String sql="SELECT img.*,COUNT(imgfavor.ImageID) as favorNum\n" +
                "FROM img LEFT JOIN imgfavor ON imgfavor.ImageID=img.ImageID\n" +
                "WHERE img.Content LIKE concat('%',?,'%') \n" +
                "GROUP BY img.ImageID\n" +
                "ORDER BY favorNum DESC";
        return queryForList(Img.class,sql,content);
    }

    @Override
    public Img queryImgByPath(String path) {
        String sql = "select * from img where PATH = ?";
        return queryForOne(Img.class, sql, path);
    }

    @Override
    public List<Img> queryImgFavoredByUID(long UID) {
        String sql = "SELECT img.*\n" +
                "FROM img,imgfavor\n" +
                "WHERE imgfavor.UID=? AND imgfavor.ImageID=img.ImageID";
        return queryForList(Img.class, sql, UID);
    }

    @Override
    public List<Img> queryImgFavoredByUidLimited(long UID, long start, long end) {
        String sql = "SELECT img.*\n" +
                "FROM img,imgfavor\n" +
                "WHERE imgfavor.UID= ? AND imgfavor.ImageID=img.ImageID\n" +
                "LIMIT ? , ?";
        return queryForList(Img.class, sql, UID, start, end);
    }

    @Override
    public List<Img> queryImgHot(long num) {
        String sql = "SELECT img.*,COUNT(imgfavor.ImageID) as f\n" +
                "FROM `img`,`imgfavor`\n" +
                "WHERE imgfavor.ImageID=img.ImageID\n" +
                "GROUP BY imgfavor.ImageID\n" +
                "ORDER BY f DESC\n" +
                "LIMIT ?";
        return queryForList(Img.class, sql, num);
    }

    @Override
    public List<Img> queryImgNew(long num) {
        String sql = "SELECT img.*,user.UserName\n" +
                "FROM `img`,`user`\n" +
                "WHERE img.UID=user.UID\n" +
                "ORDER BY img.Time DESC\n" +
                "LIMIT ?";
        return queryForList(Img.class, sql, num);
    }

    @Override
    public boolean queryIsPathExist(String path) {
        String sql = "SELECT * FROM `img` WHERE PATH= ?";
        Img img = queryForOne(Img.class, sql, path);
        return img != null;
    }

    @Override
    public void updateImg(long imgId, String title, String description, String cityName, String countryName, String content) {
        String sql = "UPDATE img SET Title=?,Description=?,CityCode=?,CountryCode=?,Content=?,Time=now()\n" +
                "WHERE ImageID=?";

        CityDaoImpl cityDao = new CityDaoImpl();
        CountryDaoImpl countryDao = new CountryDaoImpl();
        long cityCode = cityDao.queryByName(cityName).getCityCode();
        String countryCode = countryDao.queryByName(countryName).getCountryCode();

        update(sql, title, description, cityCode, countryCode, content, imgId);
    }

    @Override
    public void updateImgPath(long imgId, String path) {
        String sql = "UPDATE img SET PATH=? WHERE ImageID=?";
        update(sql, path, imgId);
    }


    @Override
    public void insertImg(String title, String description, String cityName, String countryName, long uid, String path, String content) {
        String sql = "insert into img(Title,Description,CityCode,CountryCode,UID,PATH,Content,Time)\n" +
                "values(?,?,?,?,?,?,?,now())";

        CityDaoImpl cityDao = new CityDaoImpl();
        CountryDaoImpl countryDao = new CountryDaoImpl();
        long cityCode = cityDao.queryByName(cityName).getCityCode();
        String countryCode = countryDao.queryByName(countryName).getCountryCode();
        update(sql, title, description, cityCode, countryCode, uid, path, content);
    }

    @Override
    public void deleteImg(long imgId) {
        Img img = queryImgById(imgId);
        String path = img.getPath();
        tools.deleteImgFile(path);
        String sql = "DELETE from img where ImageID=?";
        update(sql, imgId);
    }
}
