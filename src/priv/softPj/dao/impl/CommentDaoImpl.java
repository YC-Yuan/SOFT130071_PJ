package priv.softPj.dao.impl;

import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.junit.Test;
import priv.softPj.dao.CommentDao;
import priv.softPj.pojo.Comment;

import java.util.List;

public class CommentDaoImpl extends BaseDao implements CommentDao {
    @Override
    public List<Comment> queryByTime(long imgId) {
        String sql = "SELECT * FROM `comment` WHERE ImageID= ? ORDER BY Time";
        return queryForList(Comment.class, sql, imgId);
    }

    @Override
    public List<Comment> queryByHeat(long imgId) {
        String sql = "SELECT comment.* ,COUNT(commentfavor.CommentID) as favorNum \n" +
                "FROM comment LEFT JOIN commentfavor\n" +
                "ON comment.CommentID = commentfavor.CommentID\n" +
                "WHERE comment.ImageID=?\n" +
                "GROUP BY commentfavor.CommentID\n" +
                "ORDER BY favorNum DESC";
        return queryForList(Comment.class, sql, imgId);
    }

    @Override
    public void insert(long imgId, long UID, String comment, String userName) {
        String sql = "INSERT INTO `comment` (`ImageID`, `UID`, `Comment`, `Time`, `UserName`) VALUES (?, ?, ?, now(), ?);";
        update(sql, imgId, UID, comment, userName);
    }

    @Override
    public void delete(long commentId) {
        String sql = "delete from `comment` where CommentID=?";
        update(sql,commentId);
    }
}
