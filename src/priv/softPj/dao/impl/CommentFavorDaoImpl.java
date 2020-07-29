package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.CommentFavorDao;

public class CommentFavorDaoImpl extends BaseDao implements CommentFavorDao {
    @Override
    public void doFavor(long commentId, long uid) {
        String sql = "insert into commentfavor(UID,CommentID) values(?,?)";
        update(sql, uid, commentId);
    }

    @Override
    public void unFavor(long commentId, long uid) {
        String sql = "delete from commentfavor where uid=? and CommentID=?";
        update(sql, uid, commentId);
    }

    @Override
    public long isFavored(long commentId, long uid) {
        String sql = "select count(*)\n" +
                "from commentfavor\n" +
                "where UID = ? and CommentID = ?";
        return queryForValue(sql, uid, commentId);
    }
}
