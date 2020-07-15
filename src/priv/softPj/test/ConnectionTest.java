package priv.softPj.test;

import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionTest {

    @Test
    public void testConnection1() throws SQLException {
        //获取Driver实现类对象
        Driver driver = new com.mysql.cj.jdbc.Driver();

        //提供数据库位置
        String url = "jdbc:mysql://localhost:3306/softproject";
        //封装用户名和密码
        Properties info = new Properties();
        info.setProperty("user","softproject");
        info.setProperty("password","softDevelopmentProject");

        Connection conn = driver.connect(url,info);

        System.out.println(conn);
    }

    @Test
    public void testConnection2() throws Exception {
        //获取Driver实现类对象，用反射避免了第三方API
        Class clazz = Class.forName("com.mysql.cj.jdbc.Driver");
        Driver driver = (Driver) clazz.newInstance();

        //提供数据库位置
        String url = "jdbc:mysql://localhost:3306/softproject";
        //封装用户名和密码
        Properties info = new Properties();
        info.setProperty("user","softproject");
        info.setProperty("password","softDevelopmentProject");

        Connection conn = driver.connect(url,info);

        System.out.println(conn);
    }

    @Test
    public void testConnection3() throws Exception {
        //获取Driver实现类对象，用反射避免了第三方API
        Class clazz = Class.forName("com.mysql.cj.jdbc.Driver");
        Driver driver = (Driver) clazz.newInstance();

        String url = "jdbc:mysql://localhost:3306/softproject";
        String user = "softproject";
        String password = "softDevelopmentProject";

        //注册驱动
        DriverManager.registerDriver(driver);

        //获取连接
        Connection conn = DriverManager.getConnection(url,user,password);
        System.out.println(conn);
    }

    @Test
    public void testConnection4() throws Exception {
        String url = "jdbc:mysql://localhost:3306/softproject";
        String user = "softproject";
        String password = "softDevelopmentProject";

        //获取Driver实现类对象，用反射避免了第三方API
        //META-INF中给出了Driver地址，使用mysql时此步亦可省略(使用其他数据库则不行)
        Class.forName("com.mysql.cj.jdbc.Driver");
        //加载类时自动执行注册驱动，省略3种下列操作
//        Driver driver = (Driver) clazz.newInstance();
//        //注册驱动
//        DriverManager.registerDriver(driver);

        //获取连接
        Connection conn = DriverManager.getConnection(url,user,password);
        System.out.println(conn);
    }

    @Test
    public void testConnection5() throws Exception {
        //敏感信息写入配置文件，加载jdbc.properties（本质上是数据与代码的解耦分离，部署时免去重新打包）
        InputStream input = ConnectionTest.class.getClassLoader().getResourceAsStream("jdbc.properties");
        Properties pros = new Properties();
        pros.load(input);

        String user = pros.getProperty("user");
        String password = pros.getProperty("password");
        String url = pros.getProperty("url");
        String driverClass = pros.getProperty("driverClass");

        //根据driverClass加载驱动（大部分自动完成）
        Class.forName(driverClass);

        //获取连接
        Connection conn=DriverManager.getConnection(url,user,password);
        System.out.println(conn);
    }
}
