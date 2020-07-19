package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.ImgDao;
import priv.softPj.pojo.Img;

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
    public List<Img> queryImgFavoredByUID(long UID) {
        String sql="SELECT img.*\n" +
                "FROM img,imgfavor\n" +
                "WHERE imgfavor.UID=? AND imgfavor.ImageID=img.ImageID";
        return queryForList(Img.class,sql,UID);
    }

    @Override
    public List<Img> queryImgFavoredByUidLimited(long UID, long start, long end) {
        String sql="SELECT img.*\n"+
                "FROM img,imgfavor\n"+
                "WHERE imgfavor.UID= ? AND imgfavor.ImageID=img.ImageID\n" +
                "LIMIT ? , ?";
        return queryForList(Img.class,sql,UID,start,end);
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
    public void deleteImg(long imgId) {
        String sql="DELETE from img where ImageID=?";
        update(sql,imgId);
    }
}
