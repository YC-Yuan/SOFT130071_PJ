package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.UserDao;
import priv.softPj.pojo.User;
import priv.softPj.servlet.tools;

import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class UserDaoImpl extends BaseDao implements UserDao {
    @Override
    //先取出salt，与password结合加密后再检测
    public User queryLogin(String userName, String password) {
        String sql = "select `Salt` from User where UserName = ? or Email = ?";
        User user = queryForOne(User.class, sql, userName, userName);
        System.out.println("----------login-----------");
        System.out.println(userName);
        System.out.println(password);
        System.out.println("Is user exist?" + user);
        if (user == null) return null;
        long salt = Long.parseLong(user.getSalt());
        String pass = "";
        try {
            pass = tools.getSha1((password + salt).getBytes(StandardCharsets.UTF_8));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        System.out.println("sha1 password:"+pass);
        sql = "select `UID` from User where UserName = ? and Password = ? or Email= ? AND Password = ? ";
        System.out.println("Is password correct?" + queryForOne(User.class, sql, userName, pass, userName, pass));
        return queryForOne(User.class, sql, userName, pass, userName, pass);
    }

    @Override
    public boolean queryUserNameExist(String userName) {
        String sql = "select * from User where UserName = ?";
        User user = queryForOne(User.class, sql, userName);
        return user != null;
    }

    @Override
    public void updateRegister(String userName, String email, String password, long salt) {
        String sql = "insert into user(UserName,Email,Password,ShowFavor,DateJoined,Salt) values(?,?,?,1,now(),?);";
        update(sql, userName, email, password, salt);
    }

    @Override
    public User queryUserByUID(long UID) {
        String sql = "select * from user where UID = ?";
        return queryForOne(User.class, sql, UID);
    }

    @Override
    public List<User> queryUserByName(String userName) {
        String sql = "select * from user where UserName like concat('%',?,'%')";
        return queryForList(User.class, sql, userName);
    }

    @Override
    public List<User> queryFriendByUID(long UID) {
        String sql = "SELECT user.*\n" +
                "FROM friend,user\n" +
                "WHERE friend.UID2=? AND UID1 =user.UID\n" +
                "UNION ALL\n" +
                "SELECT user.*\n" +
                "FROM friend,user\n" +
                "WHERE friend.UID1=? AND UID2 =user.UID";
        return queryForList(User.class, sql, UID, UID);
    }
}
