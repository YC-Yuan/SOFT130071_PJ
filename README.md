# SOFT130071_PJ 卓越软件开发Project项目设计文档

## 1、 背景和需求

### 1.1 课程名称与作者信息

课程：复旦大学2020年暑假学期卓越软件开发课

姓名：袁逸聪

学号：19302010020

### 1.2 项目背景与技术概览

【Daddy】旅行社委托开发：旅游图片分享交流平台

前端使用html，css，javascript完成，也运用了bootstrap4框架

后端使用JSP+Servlet+JavaBean的MVC架构实现

服务器使用Tomcat9，数据库使用了借助xampp安装的Mysql（实际上是MarinaDB）

### 1.3 需求分析与结构设计

从需求出发，项目需要为用户提供浏览、上传图片的交流平台。需要展示的核心有二：用户、图片。

因而数据库的设计也以用户和图片为核心，根据需求开枝散叶。

页面围绕向用户展现图片展开，在首页、搜索页便于用户接触到图片，点击后进入详情页展示细节。浏览记录将被记录，可在收藏页查询，跳转到之前看过的图片。

内容方面，由用户自主上传。可在我的收藏页面管理。

社交方面，用户可以在图片下评论、为图片或评论点赞。可以在好友页面搜索、添加好友，查看好友的收藏内容。

于是，数据库在用户和图片之外，延展出三个主要部分：好友，收藏（包含了浏览记录）与评论（评论与评论点赞的关系其实类似于图片和收藏）

此外，还提供了城市与国家表来约束用户的上传内容，避免意涵重复而记录不同。

## 2、 技术与实现

### 2.1 MVC架构

#### 2.1.1 Module模型

模型部分旨在与数据库交互，用idea的View->Tool Windows->Database连接到数据库，自动生成了对应pojo（JavaBean类）。

JavaBean由私有属性和公共的setter，getter（还有省略的无参构造器）组成，属性名对应数据库中的字段，改用驼峰法命名。

JavaBean未必要与数据库一一对应，也可以自由增删属性，适应查询需求：

```Java
public List<Comment> queryByHeat(long imgId) {
        String sql = "SELECT comment.* ,COUNT(commentfavor.CommentID) as favorNum \n" +
                "FROM comment LEFT JOIN commentfavor\n" +
                "ON comment.CommentID = commentfavor.CommentID\n" +
                "WHERE comment.ImageID=?\n" +
                "GROUP BY comment.CommentID\n" +
                "ORDER BY favorNum DESC";
        return queryForList(Comment.class, sql, imgId);
    }
```

如上查询语句，不仅查询了comment表的属性，还将每条评论对应的点赞数记为favorNum一并查询。只要在Comment类（JavaBean）中添加favorNum属性，即可接受并使用。

对于复杂的使用需求，也可以设计聚合的类：

```Java
public class ImgFull {
    private Img img;
    private User user;
    private Country country;
    private City city;
    private long favorNum;
    ......
}
```

用于详情页的图片需要各种详细信息，因而包含了Img，User,Country,City四大类分别查询。

与JavaBean直接交互的是Dao层（在JdbcUtils的基础之上），本项目采用了阿里提供的Druid连接池来实现JdbcUtils：

```Java
private static DruidDataSource dataSource;
    static {
        try {
            Properties properties = new Properties();
            InputStream inputStream = JdbcUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            properties.load(inputStream);
            dataSource = (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
```

期中properties文件记录了登录数据库所需的账户、表名等信息，亦可直接保存在初始化代码中。

**连接数据库需要修改时序：在配置文件my.ini中在[mysqlId]下添加 default-time_zone='+8:00'设置时区为东八区，否则启动将报错**

Dao层中，BaseDao作为所有DaoImpl实现类的继承对象，依靠JdbcUtils实现对数据库的查询与操作（以查询为例）：

```Java
public <T> List<T> queryForList(Class<T> type, String sql, Object... args) {
        Connection conn = JdbcUtils.getConnection();
        try {
            return queryRunner.query(conn, sql, new BeanListHandler<T>(type), args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn);
        }
        return null;
    }
```

运用泛型弥补不知道查询对象结构的不足，由JavaBean提供具体信息。列表化参数接合sql预处理语句，只需要开发者自己编写sql语句，在需要的位置留下?占位，将内容作为参数传入即可。

**预处理的传入参数相当于在sql语句中添加引号，因而原本带有引号的语句如模糊查询LIKE "%?%" 将失效，需要改用concat('%',?,'%')**

#### 2.1.2 View视图

视图主要是JSP，从数据域中提取servlet的封装成果，在页面中展示。

本项目将JSP与servlet一一对应，因而servlet中绑定页面的部分其实担任了一大部分Controller的功能，根据页面转发请求的参数调用其他功能性servlet，统一调度。

每个页面将首先判断是否拿到了需要的数据，没有则向对应servlet请求，再转回JSP。此时的JSP与用户初次加载时不同，已经具有了所需数据，便不需要再依靠servlet：

```Java
<!--url process start-->
<% if (request.getAttribute("imgHot") == null) request.getRequestDispatcher("/home").forward(request, response);%>
<!--url process end-->
```

JSP页面中，用el表达式读取数据非常方便：

```Java
<a href="html/details.jsp?imgId=${requestScope.imgHot[s.index].img.imageId}">
    <img class="m-auto d-block" src="img/travel/${requestScope.imgHot[s.index].img.path}"alt="Second slide">
</a>
```

JSTL标签也大大简化了逻辑部分：

```Java
<c:forEach items="${requestScope.imgNew}" varStatus="s">
    <c:if test="${s.index%2==0}"><div class="row mx-0"></c:if>
    ...
    <c:if test="${s.index%2==1}"></div></c:if>
</c:forEach>
```

#### 2.1.3 Controller控制器

本项目的控制器主要由页面对应的servlet承担，根据需求调用功能性servlet。（本质上，项目并未设计业务层service，因为大多需求比较简单，最终的servlet也不是太多。目录结构中的service实际上是复合型JavaBean对应的Dao层与其实现，尽量避免直接接触数据库，而在已有的Dao层之上封装）

其实JSP页面中的链接设计也承载了一部分控制功能，譬如点赞按钮直接链接到功能性servlet。或许是因为项目规模较小，比起臃肿的分发servlet，我宁可牺牲一部分视图与逻辑的解耦来使代码更简洁直观。

### 2.2 页面功能

#### 2.2.1 公用页面封装

对于几乎每个页面都需要使用的head部分与footer部分，提取到了额外的jsp文件中，并以include标签引入：

```Java
    <!--静态引入page,base,css,jstl-->
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="css/home.css">
```

head.jsp中设定了编码信息、引入了JSTL标签库、bootstrap、公用css并设定了至关重要的base标签

```Java
<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";%>
<base href="<%=basePath%>"/>
```

#### 2.2.1 导航栏

