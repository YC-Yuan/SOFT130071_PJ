package priv.softPj.dao;

import priv.softPj.pojo.Comment;

import java.util.List;

public interface CommentDao {
    public List<Comment> queryByTime(long imgId);

    public List<Comment> queryByHeat(long imgId);

    public void insert(long imgId,long UID,String comment,String userName);

    public void delete(long commentId);
}
