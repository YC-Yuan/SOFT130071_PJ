package priv.softPj.pojo.combination;

import priv.softPj.pojo.Friend;
import priv.softPj.pojo.Friendrequest;
import priv.softPj.pojo.User;

public class FriendRequestFull {
    private Friendrequest friendrequest;
    private User user;

    public Friendrequest getFriendrequest() {
        return friendrequest;
    }

    public void setFriendrequest(Friendrequest friendrequest) {
        this.friendrequest = friendrequest;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
