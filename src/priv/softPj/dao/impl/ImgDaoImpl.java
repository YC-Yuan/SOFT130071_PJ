package priv.softPj.dao.impl;

import priv.softPj.dao.ImgDao;

public class ImgDaoImpl extends BaseDao implements ImgDao {
    @Override
    public priv.softPj.pojo.Img queryImgById(int UID) {
        String sql = "select * from img where ImageID = ?";
        return queryForOne(priv.softPj.pojo.Img.class,sql,UID);
    }
}
