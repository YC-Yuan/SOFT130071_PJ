package priv.softPj.test;


import org.junit.Test;
import priv.softPj.pojo.*;
import priv.softPj.utils.JdbcUtils;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;


public class PrepareStatementTest {

    /*
     * 增：insert into table(name1,name2) values (?,?)
     * 删：delete from table
     * 改：update table set name1=?,name2=?
     * 条件：where name=value
     * 排序：order by name
     */
    public void update(String sql,Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1,args[i]);
            }
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        JdbcUtils.close(conn,ps);
    }

    /*
     * 查：select name from table
     */
    public <T> ArrayList<T> select(Class<T> clazz,String sql,Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<T> result = new ArrayList<T>(3);
        try {
            conn = JdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1,args[i]);
            }

            rs = ps.executeQuery();
            ResultSetMetaData md = rs.getMetaData();
            /*处理result
             *next()判断是否有数据，有则移动指针，无则返回false
             */
            int columnCount = md.getColumnCount();
            for (int j = 0; rs.next(); j++) {
                T t = clazz.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    String columnName = md.getColumnName(i + 1);
                    String columnLabel = md.getColumnLabel(i + 1);
                    Object columnValue = rs.getObject(i + 1);

                    Field field = clazz.getDeclaredField(columnName);
                    field.setAccessible(true);
                    field.set(t,columnValue);
                }
                result.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn,ps,rs);
        }
        return result;
    }


    @Test
    public void test() {
        String sql = "select * from user where UID = ?";
        ArrayList<User> users = select(User.class,sql,1);
        System.out.println(users);
    }

}