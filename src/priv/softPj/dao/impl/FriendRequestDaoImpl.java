package priv.softPj.dao.impl;


import priv.softPj.dao.FriendRequestDao;
import priv.softPj.pojo.Friendrequest;
import priv.softPj.pojo.User;

import java.util.List;

public class FriendRequestDaoImpl extends BaseDao implements FriendRequestDao {
    @Override
    public List<Friendrequest> queryReceiveByUID(long uid) {
        String sql = "select * from friendrequest where ReceiveUID = ?";
        return queryForList(Friendrequest.class, sql, uid);
    }

    @Override
    public List<Friendrequest> querySendByUID(long uid) {
        String sql = "select * from friendrequest where SendUID = ?";
        return queryForList(Friendrequest.class, sql, uid);
    }

    @Override
    public Friendrequest queryById(long id) {
        String sql = "select * from friendrequest where RequestId=?";
        return queryForOne(Friendrequest.class, sql, id);
    }

    @Override
    public void sendRequest(long sendUID, long receiveUID) {
        String sql = "insert into friendrequest(SendUID,ReceiveUID,Status) values(?,?,1)";
        update(sql, sendUID, receiveUID);
    }

    @Override
    //更改请求状态并添加好友
    public void acceptRequest(long requestId) {
        String sql = "update friendrequest set Status=2 where RequestID=?";
        update(sql,requestId);
    }

    @Override
    public void deleteRequest(long requestId) {
        String sql = "delete from friendrequest where RequestID=?";
        update(sql, requestId);
    }

    @Override
    public List<User> queryFriendsByUID(long uid) {
        String sql="SELECT user.* from user,friendrequest\n" +
                "WHERE user.UID=friendrequest.ReceiveUID AND friendrequest.SendUID=? AND friendrequest.Status=2\n" +
                "OR user.UID=friendrequest.SendUID AND friendrequest.ReceiveUID=? AND friendrequest.Status=2";
        return queryForList(User.class,sql,uid,uid);
    }
}
