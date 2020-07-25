package priv.softPj.dao;

import priv.softPj.pojo.Img;

import java.util.List;

public interface ImgDao {
    public Img queryImgById(long imgId);

    public List<Img> queryImgByUID(long UID);

    public List<Img> queryImgByUIDLimited(long UID, long start, long end);

    public List<Img> queryImgByTitleOrderedByTime(String title);

    public List<Img> queryImgByTitleOrderedByHeat(String title);

    public List<Img> queryImgByContentOrderedByTime(String content);

    public List<Img> queryImgByContentOrderedByHeat(String content);

    public Img queryImgByPath(String path);

    public List<Img> queryImgFavoredByUID(long UID);

    public List<Img> queryImgFavoredByUidLimited(long UID, long start, long end);

    public List<Img> queryImgHot(long num);

    public List<Img> queryImgNew(long num);

    public boolean queryIsPathExist(String path);

    public void updateImg(long imgId, String title, String description, String cityName, String countryName, String content);

    public void updateImgPath(long imgId, String path);

    public void insertImg(String title, String description, String cityName, String countryName, long uid, String path, String content);

    public void deleteImg(long imgId);
}
