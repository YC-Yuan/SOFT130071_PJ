package priv.softPj.service;

import priv.softPj.pojo.combination.FriendRequestFull;

import java.util.List;

public interface FRFull {
    public List<FriendRequestFull> querySentByUID(long UID);

    public List<FriendRequestFull> queryReceiveByUID(long UID);
}
