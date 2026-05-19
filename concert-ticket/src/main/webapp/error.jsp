<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>错误页面 - 陈家豪演唱会抢票系统</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Microsoft YaHei', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .error-container {
      background: white;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      text-align: center;
      max-width: 500px;
    }
    .error-icon {
      font-size: 64px;
      margin-bottom: 20px;
      color: #e74c3c;
    }
    .error-title {
      color: #333;
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 15px;
    }
    .error-message {
      color: #666;
      margin-bottom: 25px;
    }
    .back-btn {
      background: #667eea;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
      text-decoration: none;
      display: inline-block;
    }
  </style>
</head>
<body>
<div class="error-container">
  <div class="error-icon">❌</div>
  <h2 class="error-title">页面加载失败</h2>
  <p class="error-message">抱歉，页面加载时出现了问题。</p>
  
  <%-- 显示详细错误信息 --%>
  <% if (exception != null) { %>
  <div style="text-align: left; margin: 20px 0; padding: 15px; background-color: #f8f9fa; border-radius: 8px; border-left: 4px solid #e74c3c;">
    <h3 style="color: #e74c3c; margin-bottom: 10px;">详细错误信息：</h3>
    <p><strong>错误类型：</strong><%= exception.getClass().getName() %></p>
    <p><strong>错误消息：</strong><%= exception.getMessage() %></p>
    <h4 style="margin-top: 15px; margin-bottom: 10px; color: #333;">堆栈跟踪：</h4>
    <pre style="background-color: #333; color: #fff; padding: 15px; border-radius: 8px; overflow-x: auto; font-size: 12px;">
      <% exception.printStackTrace(new java.io.PrintWriter(out)); %>
    </pre>
  </div>
  <% } %>
  
  <a href="concerts" class="back-btn">返回演唱会列表</a>
</div>
</body>
</html>