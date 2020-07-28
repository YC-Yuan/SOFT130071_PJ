package priv.softPj.dao;

import org.junit.Test;
import priv.softPj.pojo.User;

import java.util.List;

public interface UserDao {
    public User queryLogin(String userName,String password);

    public boolean queryUserNameExist(String userName);

    public void updateRegister(String userName,String email,String password,long salt);

    public User queryUserByUID(long UID);

    public List<User> queryUserByName(String userName);

    public void favorPublic(long UID);

    public void favorPrivate(long UID);
}