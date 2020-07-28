package priv.softPj.service.impl;

import org.junit.Test;
import priv.softPj.dao.impl.BaseDao;
import priv.softPj.pojo.Friendrequest;
import priv.softPj.pojo.User;
import priv.softPj.pojo.combination.FriendRequestFull;
import priv.softPj.service.FRFull;

import java.util.List;

public class FRFullImpl extends BaseDao implements FRFull {
    @Override
    public List<FriendRequestFull> querySentByUID(long UID) {
        String sql = "SELECT friendrequest.*,user.UserName,user.Email,user.DateJoined FROM `friendrequest`,user\n" +
                "WHERE friendrequest.ReceiveUID=user.UID\n" +
                "AND friendrequest.SendUID=?\n" +
                "AND friendrequest.Status=1";


        return queryForList(FriendRequestFull.class, sql, UID);
    }

    @Override
    public List<FriendRequestFull> queryReceiveByUID(long UID) {
        String sql = "SELECT friendrequest.*,user.UserName,user.Email,user.DateJoined FROM `friendrequest`,user\n" +
                "WHERE friendrequest.SendUID=user.UID\n" +
                "AND friendrequest.ReceiveUID=?\n" +
                "AND friendrequest.Status=1";

        return queryForList(FriendRequestFull.class, sql, UID);
    }

    @Override
    //返回用户和请求状态，未接触的请求状态都是0，发送过的为1，已经是好友的为2
    public List<FriendRequestFull> queryUserByName(long UID, String name) {
        String sql = "select friendrequest.*,user.UserName,user.ShowFavor,user.UID from user left join friendrequest\n" +
                "ON friendrequest.ReceiveUID=user.UID and SendUID=? OR friendrequest.ReceiveUID=? AND SendUID=user.UID\n" +
                "WHERE user.UserName like concat('%',?,'%') and user.UID != ?";
        return queryForList(FriendRequestFull.class, sql, UID, UID, name, UID);
    }
}
