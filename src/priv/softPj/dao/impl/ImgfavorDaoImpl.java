package priv.softPj.dao.impl;

import priv.softPj.dao.ImgfavorDao;
import priv.softPj.pojo.Imgfavor;

import java.util.List;

public class ImgfavorDaoImpl extends BaseDao implements ImgfavorDao {

    @Override
    public List<Imgfavor> queryFavorByUID(long UID) {
        String sql = "select `ImageID` from Imgfavor where UID = ?";
        return queryForList(Imgfavor.class, sql, UID);
    }

    @Override
    public long queryFavorNum(long imgId) {
        String sql = "SELECT COUNT(*)\n" +
                "FROM imgfavor\n" +
                "WHERE ImageID=?";
        return queryForValue(sql, imgId);
    }

    @Override
    public long queryIsFavored(long UID, long ImageId) {
        String sql = "select count(*)\n" +
                "from imgfavor\n" +
                "where UID = ? and ImageId = ?";
        return queryForValue(sql, UID, ImageId);
    }

    @Override
    public void doFavor(long UID, long ImageID) {
        String sql="insert into imgfavor(UID,ImageID) values(?,?)";
        update(sql,UID,ImageID);
    }

    @Override
    public void unFavor(long UID, long ImageID) {
        String sql="delete from imgfavor where UID=? and ImageID=?";
        update(sql,UID,ImageID);
    }

    @Override
    public void deleteByImgID(long imgId) {
        String sql="delete from imgfavor where ImageID=?";
        update(sql,imgId);
    }
}
