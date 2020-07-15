package priv.softPj.dao;

import org.junit.Test;
import priv.softPj.pojo.User;

public interface UserDao {
    public User queryLogin(String userName,String password);

    public boolean queryUserNameExist(String userName);

    public void updateRegister(String userName,String email,String password);
}