package priv.softPj.test;

import org.junit.Test;
import priv.softPj.utils.JdbcUtils;

import java.sql.Connection;

public class JDBCExample {

    @Test
    public void test(){
        System.out.println(JdbcUtils.getConnection());
    }
}
