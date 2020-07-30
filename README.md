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

大部分页面公用的导航栏也进行了抽象，但是根据页面的不同需要额外指明当前所在页面（以便在视图上有所区别）

```Java
    <!--navigation begin-->
    <%@include file="common/navigation.jsp" %>
    <script>document.getElementById("navigation").children[1].className = "currentPage"</script>
    <!--navigation end-->
```

#### 2.2.2 注册与登录

##### 注册

注册将用ajax实现对用户名重复的查询，表单合法性统一用setCustomValidity进行提示，增强同类机制的亲密性。

对文本框的input事件进行绑定，避免了ajax请求未完成而请求已提交的情况。

* ajax对应内容以事件绑定触发，即使同步请求也会错过阻止提交 

密码强度并非合法性的一部分，只是建议采取高强度密码，采用不同的UI。

注册成功后跳转到直接登录servlet，理所当然地验证成功并不需要再次验证。（也算是一部分controller功能）

##### 登录

登录的成功失败统一用alert提示。

但成功后需要先跳转到提示页面进行alert，再进行重定向。而重定向会破坏alert！

因而改为采用借助el表达式设置window.location.href，兼得统一的alert方式与跳转到先前浏览页面的要求

```Javascript
    alert("Welcome!  ${requestScope.userName}");
    if (${sessionScope.prePage!=null}) {
        window.location.href = "${sessionScope.prePage.toString()}";
    } else {
        window.location.href = "html/home.jsp";
    }
```

##### 验证码

分为前段后端两部分，后端生成验证码并将答案储存在session域中。

前段展示验证码（并提供刷新验证码的控制），并完成验证。前端验证能够兼顾在密码加密功能安全性的情况下，验证失败不刷新密码。同时，验证码的验证功能其实并未受损，私以为比后端验证更加用户友好。

本项目的验证失败完全不影响表单内容，不触发请求，故不启动加密、也不需要将原本的密码储存在其他地方（伴随抓包泄露风险）。失败仅清空验证码并自动刷新。

**超星网的后端验证验证码就常常莫名失败，并且刷掉我的密码**

##### 加密

注册与登录在请求提交时都会使用sha1进行一次加密，避免抓包泄露原密码。

注册时，将随机生成salt，并连接在一次加密的密码后，再次进行sha1加密。数据库中储存二次sha1加密结果与salt。登录时读取salt，与一次加密的密码连接，再次加密进行验证。

#### 2.2.3 首页

轮播展示3张最热图片

下方展示6张最新图片，包含作者、主题、上传时间

#### 2.2.4 搜索页

可以自主选择根据标题/主题搜索，并按上传时间或热度排序。搜索内容和方式将被记住，除非离开搜索页。

##### 分页

每页九宫格进行分页，分页页码最多显示5个（在总页数足够时始终5个），附带前一页、后一页、首页、末页跳转。

收藏和我的图片页面也是每页6张。（横向分割，竖直排列）

#### 2.2.5 详情页面

展示图片详细信息，登录后可以收藏（ajax实现），不登录则在收藏位置提醒登录。

##### 放大镜功能

主要用js依靠offset属性和事件绑定实现。

页面中放置原图和放大图，原图上设置放大镜窗口，而大图只能透过固定的窗口展现。

鼠标移入时，显示放大镜与大图窗口。根据鼠标移动位置决定放大镜位置。根据放大镜在原图中的位置，按比例改变大图漏出窗口的部分。（移动的是大图图片本身，所以与放大镜方向相反）

```Javascript
smallBox.onmousemove = function (e) {
        let left = e.pageX - smallBox.offsetLeft - floatBox.offsetWidth / 2;
        let top = e.pageY - smallBox.offsetTop - floatBox.offsetHeight / 2;

        left = Math.max(left, 0);
        left = Math.min(left, smallBox.offsetWidth - floatBox.offsetWidth);

        top = Math.max(top, 0);
        top = Math.min(top, smallBox.offsetHeight - floatBox.offsetHeight);

        floatBox.style.left = left + "px";
        floatBox.style.top = top + "px";

        let percentX = left / (smallBoxImage.offsetWidth - floatBox.offsetWidth);
        let percentY = top / (smallBoxImage.offsetHeight - floatBox.offsetHeight);

        bigBoxImage.style.left = -percentX * (bigBoxImage.offsetWidth - bigBox.offsetWidth) + "px";
        bigBoxImage.style.top = -percentY * (bigBoxImage.offsetHeight - bigBox.offsetHeight) + "px";
    }
```

##### 评论功能

不登录时显示但不可用，结合收藏和点赞功能提醒用户登录。

登录后可以发表评论、为评论点赞。

用户可以删除自己发表的评论或自己图片下的任何评论。

评论区可以选择按发布时间或点赞数排序。

#### 2.2.6 上传界面

除description部分都要求填写

城市、国家未采用下拉框，因为大国的城市数量太多，上万选项列表使用体验较差。

城市、国家采用文本框输入，结合ajax实时检测合法性，并模糊搜索给出提示。鼓励用户自主输入，同时又能指导用户输入符合数据库约束的内容。

修改图片将帮助用户填入先前的内容，并将上传等提示改为修改。

##### 模态框确认

对于上传图片和大部分的删除，不会点击一次生效，而要弹出模态框要求确认。

上传部分的模态框尤其难实现，因为第一次点击需要进行合法性检测、但又不能触发提交，检测过程则需要统一采用原生检测方式，以触发validity提醒。（原生检测和表单提交未找到分割方式）

本项目进行额外的检测，如不通过，再进行原生检测。如果通过，阻止整个表单提交过程（也阻止了原生检测，但在通过的情况下，并不需要原生检测进行提示），并弹出模态框。

#### 2.2.7 我的照片

可以修改或删除上传的照片，有分页。

#### 2.2.8 我的收藏

可以移除已有收藏，有分页。

收藏页可以设定收藏是否向好友公开。

下方显示我的足迹，记录最近浏览的10个图片。（不重复，在图片删除后顺延删除）

#### 2.2.9 好友列表

可以模糊搜索用户名加好友，以发送请求的、正给我发送请求的、已经是好友的无法再次发送。

可以处理收到的好友请求（接受或拒绝）、选择撤回送出的好友请求。

已添加的好友，可以选择删除或查看对方收藏。（需要对方在收藏页面设置公开，否则无法查看）

### 2.3 云部署

使用阿里云服务器，Tomcat9.0的Webapps目录下放置war包部署

浏览器地址栏输入121.89.211.146即可查看（域名需要备案，故不采用）