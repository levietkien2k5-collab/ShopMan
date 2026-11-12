<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; }
        
        /* 1. Thanh Header góc trên */
        .navbar { display: flex; justify-content: space-between; align-items: center; background-color: #007bff; padding: 15px 40px; color: white; }
        .navbar .brand { font-size: 24px; font-weight: bold; text-decoration: none; color: white; }
        .navbar .auth-box { display: flex; align-items: center; gap: 15px; }
        .navbar .auth-box a { color: white; text-decoration: none; font-weight: bold; }
        .btn-header { padding: 6px 14px; border-radius: 4px; text-decoration: none; }
        .btn-login { background-color: white; color: #007bff !important; }
        .btn-register { background-color: #28a745; color: white !important; }
        .btn-logout { background-color: #dc3545; color: white !important; font-size: 13px; margin-left: 10px; }

        .container { padding: 30px 40px; }
        .search-box { margin-bottom: 25px; text-align: center; }
        .search-box input { width: 350px; padding: 10px; border: 1px solid #ccc; border-radius: 4px; }
        .search-box button { padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }

        /* 2. Lưới hiển thị danh sách sản phẩm */
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 25px; }
        .product-card { background: white; border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .product-img { width: 100%; height: 180px; object-fit: cover; border-radius: 6px; background-color: #eee; }
        .product-title { font-size: 18px; margin: 12px 0 6px 0; color: #333; }
        .product-price { font-size: 16px; color: #d9534f; font-weight: bold; margin-bottom: 8px; }
        .product-desc { font-size: 13px; color: #666; height: 36px; overflow: hidden; margin-bottom: 12px; }
        .btn-buy { display: inline-block; width: 100%; padding: 8px 0; background-color: #28a745; color: white; text-decoration: none; border-radius: 4px; font-weight: bold; }
    </style>
</head>
<body>

    <!-- Header điều hướng Top-Right -->
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="brand">ShopMan</a>
        
        <div class="auth-box">
            <c:choose>
                <%-- Trường hợp ĐÃ đăng nhập --%>
                <c:when test="${not empty sessionScope.user}">
                    <span>Xin chào, <strong>${sessionScope.user.name}</strong> (${sessionScope.user.userName})</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-header btn-logout">Đăng xuất</a>
                </c:when>

                <%-- Trường hợp CHƯA đăng nhập --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/LogInFrm2.jsp" class="btn-header btn-login">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/customer/SignUpFrm2.jsp" class="btn-header btn-register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Khung nội dung chính -->
    <div class="container">
        
        <!-- Thanh tìm kiếm sản phẩm -->
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/home" method="get">
                <input type="text" name="search" value="${param.search}" placeholder="Tìm kiếm mặt hàng theo tên..." />
                <button type="submit">Tìm kiếm</button>
            </form>
        </div>

        <h2>Danh mục sản phẩm</h2>

        <!-- Danh sách mặt hàng -->
        <div class="product-grid">
            <c:forEach items="${itemList}" var="item">
                <div class="product-card">
                    <!-- Ảnh minh họa sản phẩm (sử dụng ảnh mặc định nếu null) -->
                    <c:set var="imgName" value="${empty item.image ? 'default_item.jpg' : item.image}" />
                    <img src="${pageContext.request.contextPath}/images/${imgName}" 
                         alt="${item.name}" 
                         class="product-img" 
                         onerror="this.src='https://via.placeholder.com/200x180?text=ShopMan';" />
                    
                    <div class="product-title">${item.name}</div>
                    <div class="product-price">
                        <fmt:formatNumber value="${item.sellingPrice}" pattern="#,##0"/> VNĐ
                    </div>
                    <div class="product-desc">${item.description}</div>
                    <a href="${pageContext.request.contextPath}/customer/OrderOnlineFrm2.jsp?itemId=${item.id}" class="btn-buy">Đặt mua</a>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty itemList}">
            <p style="text-align: center; color: #888; margin-top: 40px;">Không có sản phẩm nào được tìm thấy.</p>
        </c:if>
    </div>

</body>
</html>