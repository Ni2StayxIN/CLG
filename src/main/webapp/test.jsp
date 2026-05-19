<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>测试页面</title>
</head>
<body>
<h1>系统测试页面</h1>

<h2>测试链接：</h2>
<ul>
  <li><a href="concerts">演唱会列表</a></li>
  <li><a href="login">登录页面</a></li>
  <li><a href="register">注册页面</a></li>
  <li><a href="concert-detail?id=1">直接测试演唱会1</a></li>
  <li><a href="concert-detail?id=2">直接测试演唱会2</a></li>
  <li><a href="concert-detail">测试空ID（应该重定向）</a></li>
</ul>

<h2>当前会话信息：</h2>
<p>用户ID: <%= session.getAttribute("userId") %></p>
<p>用户名: <%= session.getAttribute("username") %></p>
<p>用户类型: <%= session.getAttribute("userType") %></p>
</body>
</html>