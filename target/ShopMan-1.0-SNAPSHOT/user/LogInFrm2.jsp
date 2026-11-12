<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập tài khoản - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .form-container { width: 350px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .forgot-password-container { text-align: right; margin-bottom: 15px; }
        .forgot-password { color: gray; text-decoration: underline; font-style: italic; font-size: 14px; }
        .btn-submit { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; }
        .success-msg { color: green; text-align: center; margin-bottom: 15px; font-weight: bold; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; font-weight: bold; }
        .btn-back { display: block; text-align: center; margin-top: 10px; color: #6c757d; text-decoration: none; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Đăng nhập tài khoản</h2>

    <%-- Thông báo lỗi đăng nhập --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error-msg"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Tên đăng nhập:</label>
            <input type="text" name="userName" value="${param.userName}" required />
        </div>
        <div class="form-group">
            <label>Mật khẩu:</label>
            <input type="password" name="password" value="${param.password}" required />
        </div>

        <div class="forgot-password-container">
            <a href="ForgotPasswordFrm2.jsp" class="forgot-password">Quên mật khẩu</a>
        </div>

        <button type="submit" class="btn-submit">Đăng nhập</button>
        <a href="${pageContext.request.contextPath}/home" class="btn-back">Trở về trang chủ</a>
    </form>
</div>
</body>
</html>