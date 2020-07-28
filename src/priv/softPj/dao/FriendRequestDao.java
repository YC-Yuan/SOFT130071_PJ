package priv.softPj.dao;

import priv.softPj.pojo.Friendrequest;
import priv.softPj.pojo.User;

import java.util.List;

public interface FriendRequestDao {
    public List<Friendrequest> queryReceiveByUID(long uid);

    public List<Friendrequest> querySendByUID(long uid);

    public Friendrequest queryById(long id);

    public void sendRequest(long sendUID, long receiveUID);

    public void acceptRequest(long requestId);

    public void deleteRequest(long requestId);

    public List<User> queryFriendsByUID(long uid);
}
