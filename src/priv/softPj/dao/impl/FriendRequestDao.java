package priv.softPj.dao.impl;

import priv.softPj.pojo.Friendrequest;

import java.util.List;

public interface FriendRequestDao {
    public List<Friendrequest> queryReceiveByUID(long uid);

    public List<Friendrequest> querySendByUID(long uid);
}
