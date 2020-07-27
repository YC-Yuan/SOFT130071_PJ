package priv.softPj.service.impl;

import priv.softPj.dao.impl.BaseDao;
import priv.softPj.pojo.combination.FriendRequestFull;
import priv.softPj.service.FRFull;

import java.util.List;

public class FRFullImpl extends BaseDao implements FRFull {
    @Override
    public List<FriendRequestFull> querySentByUID(long UID) {
        String sql="SELECT friendrequest.*,user.UserName,user.Email,user.DateJoined FROM `friendrequest`,user\n" +
                "WHERE friendrequest.ReceiveUID=user.UID\n" +
                "AND friendrequest.SendUID=?";
        return queryForList(FriendRequestFull.class,sql,UID);
    }

    @Override
    public List<FriendRequestFull> queryReceiveByUID(long UID) {
        String sql="SELECT friendrequest.*,user.UserName,user.Email,user.DateJoined FROM `friendrequest`,user\n" +
                "WHERE friendrequest.SendUID=user.UID\n" +
                "AND friendrequest.ReceiveUID=?";
        return queryForList(FriendRequestFull.class,sql,UID);
    }
}
