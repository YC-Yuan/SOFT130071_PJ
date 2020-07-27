package priv.softPj.dao;

import priv.softPj.pojo.Friendrequest;

import java.util.List;

public interface FriendRequestDao {
    public List<Friendrequest> queryReceiveByUID(long uid);

    public List<Friendrequest> querySendByUID(long uid);

    public void sendRequest(long sendUID, long receiveUID);

    public void acceptRequest(long sendUID, long receiveUID);

    public void deleteRequest(long sendUID, long receiveUID);
}
