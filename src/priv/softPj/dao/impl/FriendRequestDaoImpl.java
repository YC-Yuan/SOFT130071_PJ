package priv.softPj.dao.impl;


import priv.softPj.pojo.Friendrequest;

import java.util.List;

public class FriendRequestDaoImpl extends BaseDao implements FriendRequestDao{
    @Override
    public List<Friendrequest> queryReceiveByUID(long uid) {
        String sql="select * from friendrequest where ReceiveUID = ?";
        return queryForList(Friendrequest.class,sql,uid);
    }

    @Override
    public List<Friendrequest> querySendByUID(long uid) {
        String sql="select * from friendrequest where SendUID = ?";
        return queryForList(Friendrequest.class,sql,uid);
    }
}
