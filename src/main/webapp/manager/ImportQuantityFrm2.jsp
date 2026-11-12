<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page import="com.shopman.model.SupplierItem2, com.shopman.model.Item2" %>
<%
    SupplierItem2 si = (SupplierItem2) session.getAttribute("selectedSupplierItem");
    if (si == null) {
        response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");
        return;
    }
    Item2 item = si.getItem();
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    String ctx = request.getContextPath();
    String imgName = (item.getImage() != null && !item.getImage().trim().isEmpty()) ? item.getImage() : "default_item.jpg";
    boolean isIncluded = (request.getAttribute("jakarta.servlet.include.request_uri") != null);
%>
<% if (!isIncluded) { %>
<!DOCTYPE html>
<html>
<head>
    <title>Nhập số lượng mặt hàng - ShopMan</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0;">
<% } %>

<style>
    .qty-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.55);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1200;
    }
    .qty-modal-box {
        width: 430px;
        max-width: 92%;
        background: #fff;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 6px 24px rgba(0, 0, 0, 0.25);
        text-align: left;
    }
    .qty-modal-box h2 {
        text-align: center;
        color: #333;
        margin-top: 0;
        margin-bottom: 16px;
    }
    .qty-item-info {
        background: #f1f3f5;
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 15px;
        line-height: 1.6;
        text-align: center;
    }
    .qty-item-info img {
        width: 90px;
        height: 90px;
        object-fit: cover;
        border-radius: 6px;
        border: 1px solid #ddd;
        margin-bottom: 8px;
    }
    .qty-modal-box label {
        display: block;
        font-weight: bold;
        margin-bottom: 6px;
    }
    .qty-modal-box input[type="number"] {
        width: 100%;
        padding: 8px 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-bottom: 16px;
        font-size: 15px;
    }
    .qty-actions {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }
    .qty-btn {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 4px;
        color: white;
        font-weight: bold;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        font-size: 14px;
    }
    .qty-btn-save { background-color: #28a745; }
    .qty-btn-cancel { background-color: #6c757d; }
    .qty-error {
        color: red;
        font-weight: bold;
        text-align: center;
        margin-bottom: 12px;
    }
</style>

<div id="importQuantityOverlay" class="qty-overlay" onclick="if (event.target === this) window.location.href='<%= ctx %>/manager/ImportItemFrm2.jsp?cancel=1';">
    <div class="qty-modal-box">
        <h2>Nhập Số Lượng Mặt Hàng</h2>

        <% if ("min_qty".equals(request.getParameter("error"))) { %>
            <div class="qty-error">Số lượng nhập phải từ <%= si.getMinImportQuantity() %> <%= item.getUnit() %> trở lên!</div>
        <% } %>

        <div class="qty-item-info">
            <img src="<%= ctx %>/images/<%= imgName %>" alt="<%= item.getName() %>" onerror="this.src='https://via.placeholder.com/90?text=ShopMan';" />
            <div><strong><%= item.getName() %></strong> (<%= item.getUnit() %>)</div>
            <div>Tồn kho hiện tại: <strong><%= item.getQuantity() %></strong></div>
            <div>Đơn giá nhập: <strong><%= nf.format(si.getImportPrice()) %> VNĐ</strong></div>
            <div>Số lượng tối thiểu: <strong><%= si.getMinImportQuantity() %></strong></div>
        </div>

        <form action="<%= ctx %>/import/save-quantity" method="post">
            <label>Số lượng cần nhập (*):</label>
            <input type="number" name="importQuantity" min="<%= si.getMinImportQuantity() %>" value="<%= si.getMinImportQuantity() %>" required autofocus />

            <div class="qty-actions">
                <a href="<%= ctx %>/import/items?cancel=1" name="btnCancel" class="qty-btn qty-btn-cancel">Hủy</a>
                <button type="submit" name="btnSave" class="qty-btn qty-btn-save">Lưu</button>
            </div>
        </form>
    </div>
</div>

<% if (!isIncluded) { %>
</body>
</html>
<% } %>