<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký thành viên - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .form-container { width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; margin-bottom: 4px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; font-weight: bold; }
        .btn-back { display: block; text-align: center; margin-top: 10px; color: #6c757d; text-decoration: none; }

        /* Giao diện Popup thông báo ShopMan */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none; align-items: center; justify-content: center;
            z-index: 1000;
        }
        .modal-box {
            background: #fff; width: 340px; border-radius: 8px; overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); text-align: center;
        }
        .modal-header {
            background: #007bff; color: white; padding: 12px; font-weight: bold; font-size: 16px;
        }
        .modal-body {
            padding: 20px 15px; color: #333; font-size: 15px;
        }
        .modal-footer {
            padding-bottom: 15px;
        }
        .modal-btn {
            background: #28a745; color: white; border: none; padding: 8px 30px;
            border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px;
        }
        .modal-btn:hover { background: #218838; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Đăng ký thành viên</h2>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error-msg"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>Tên đăng nhập (*):</label>
            <input type="text" name="userName" value="${param.userName}" required />
        </div>
        <div class="form-group">
            <label>Mật khẩu (*):</label>
            <input type="password" name="password" required />
        </div>
        <div class="form-group">
            <label>Xác nhận mật khẩu (*):</label>
            <input type="password" name="confirmPassword" required />
        </div>
        <div class="form-group">
            <label>Họ và tên (*):</label>
            <input type="text" name="name" value="${param.name}" required />
        </div>
        <div class="form-group">
            <label>Ngày sinh:</label>
            <input type="date" name="dateOfBirth" value="${param.dateOfBirth}" />
        </div>
        <div class="form-group">
            <label>Số điện thoại:</label>
            <input type="text" name="phone" value="${param.phone}" />
        </div>
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" value="${param.email}" />
        </div>
        <button type="submit" class="btn-submit">Đăng ký</button>
        <a href="${pageContext.request.contextPath}/home" class="btn-back">Trở về trang chủ</a>
    </form>
</div>

<!-- Popup thông báo ShopMan -->
<div id="customAlert" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-header">ShopMan</div>
        <div class="modal-body">Đăng ký tài khoản thành công!</div>
        <div class="modal-footer">
            <button class="modal-btn" onclick="redirectToLogin()">OK</button>
        </div>
    </div>
</div>

<script>
    <% if ("success".equals(request.getParameter("status"))) { %>
        document.getElementById("customAlert").style.display = "flex";
    <% } %>
        
    function redirectToLogin() {
        window.location.href = "<%= request.getContextPath() %>/user/LogInFrm2.jsp";
    }
</script>

</body>
</html>