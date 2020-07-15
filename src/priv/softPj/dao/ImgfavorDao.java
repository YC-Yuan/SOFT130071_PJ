package priv.softPj.dao;

import priv.softPj.pojo.Imgfavor;

import java.util.List;

public interface ImgfavorDao {
    //根据UID查询Favor的ImageID
    public List<Imgfavor> queryFavorByUID(int UID);

    public void doFavor(int UID,int ImageID);

    public void unFavor(int UID,int ImageID);
}
