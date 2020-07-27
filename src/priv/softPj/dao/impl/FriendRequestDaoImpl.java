package priv.softPj.dao.impl;


import priv.softPj.dao.FriendRequestDao;
import priv.softPj.pojo.Friendrequest;

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
    public void sendRequest(long sendUID, long receiveUID) {
        String sql = "insert into friendrequest(SendUID,ReceiveUID,Status) values(?,?,1)";
        update(sql, sendUID, receiveUID);
    }

    @Override
    public void acceptRequest(long sendUID, long receiveUID) {
        String sql = "insert into friend(UID1,UID2) values(?,?)";
        update(sql, sendUID, receiveUID);
    }

    @Override
    public void deleteRequest(long sendUID, long receiveUID) {
        String sql = "delete from friendrequest where SendUID=? and receiveUID=?";
        update(sql, sendUID, receiveUID);
    }
}
