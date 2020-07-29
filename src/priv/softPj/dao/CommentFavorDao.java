package priv.softPj.dao;

public interface CommentFavorDao {
    public void doFavor(long commentId, long uid);

    public void unFavor(long commentId, long uid);

    public long isFavored(long commentId,long uid);
}
