package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.UserDao;
import priv.softPj.pojo.User;
import priv.softPj.servlet.tools;

import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;

public class UserDaoImpl extends BaseDao implements UserDao {
    @Override
    //先取出salt，与password结合加密后再检测
    public User queryLogin(String userName, String password) {
        String sql = "select `Salt` from User where UserName = ?";
        User user = queryForOne(User.class, sql, userName);
        if (user == null) return null;
        long salt = user.getSalt();
        String pass = "";
        try {
            pass = tools.getSha1((password + salt).getBytes(StandardCharsets.UTF_8));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        sql = "select `UID` from User where UserName = ? and Password = ?";
        return queryForOne(User.class, sql, userName, pass);
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
}
