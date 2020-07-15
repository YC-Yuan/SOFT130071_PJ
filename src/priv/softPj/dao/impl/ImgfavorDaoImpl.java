package priv.softPj.dao.impl;

import priv.softPj.dao.ImgfavorDao;
import priv.softPj.pojo.Imgfavor;

import java.util.List;

public class ImgfavorDaoImpl extends BaseDao implements ImgfavorDao {

    @Override
    public List<Imgfavor> queryFavorByUID(int UID) {
        String sql = "select `ImageID` from Imgfavor where UID = ?";
        return queryForList(Imgfavor.class,sql,UID);
    }

    @Override
    public void doFavor(int UID,int ImageID) {
    }

    @Override
    public void unFavor(int UID,int ImageID) {

    }
}
