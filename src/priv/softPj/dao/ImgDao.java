package priv.softPj.dao;

import priv.softPj.pojo.Img;

import java.util.List;

public interface ImgDao {
    public Img queryImgById(long imgId);

    public List<Img> queryImgByUID(long UID);

    public List<Img> queryImgByUIDLimited(long UID,long start,long end);

    public List<Img> queryImgFavoredByUID(long UID);

    public List<Img> queryImgFavoredByUidLimited(long UID,long start,long end);

    public List<Img> queryImgHot(long num);

    public List<Img> queryImgNew(long num);

    public void deleteImg(long imgId);
}
