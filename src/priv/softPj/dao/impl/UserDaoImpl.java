package priv.softPj.dao.impl;

import org.junit.Test;
import priv.softPj.dao.UserDao;
import priv.softPj.pojo.User;

public class UserDaoImpl extends BaseDao implements UserDao {
    @Override
    public User queryLogin(String userName, String password) {
        String sql = "select `UID` from User where UserName = ? and Password = ?";
        return queryForOne(User.class,sql,userName,password);
    }

    @Override
    public boolean queryUserNameExist(String userName) {
        String sql = "select * from User where UserName = ?";
        User user = queryForOne(User.class,sql,userName);
        return user != null;
    }

    @Override
    public void updateRegister(String userName, String email, String password) {
        String sql="insert into user(Email,UserName,Password,ShowFavor,DateJoined) values(?,?,?,1,now());";
        update(sql,userName,email,password);
    }
}
