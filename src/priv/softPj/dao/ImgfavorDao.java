package priv.softPj.dao;

import priv.softPj.pojo.Imgfavor;

import java.util.List;

public interface ImgfavorDao {
    //根据UID查询Favor的ImageID
    public List<Imgfavor> queryFavorByUID(long UID);

    public long queryFavorNum(long imgId);

    public long queryIsFavored(long UID,long ImageId);

    public void doFavor(long UID, long ImageID);

    public void unFavor(long UID, long ImageID);

    public void deleteByImgID(long imgId);
}
