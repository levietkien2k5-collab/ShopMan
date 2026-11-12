<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat, java.text.SimpleDateFormat, java.util.Locale" %>
<%@ page import="com.shopman.model.User2, com.shopman.model.ImportInvoice2, com.shopman.model.ImportInvoiceDetail2, com.shopman.model.Item2" %>
<%
    User2 manager = (User2) session.getAttribute("user");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
        return;
    }
    ImportInvoice2 invoice = (ImportInvoice2) session.getAttribute("importInvoice");
    if (invoice == null || invoice.getSupplier() == null || invoice.getItems().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");
        return;
    }
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận hóa đơn nhập - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8f9fa; }
        .container { max-width: 820px; margin: auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; }
        .info-box { background: #f1f3f5; padding: 15px; border-radius: 6px; margin-bottom: 20px; line-height: 1.6; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; vertical-align: middle; }
        th { background-color: #007bff; color: white; }
        .thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
        .total { text-align: right; font-size: 18px; font-weight: bold; color: #d9534f; margin-bottom: 20px; }
        .actions { display: flex; justify-content: space-between; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; text-decoration: none; color: white; font-weight: bold; cursor: pointer; font-size: 14px; }
        .btn-back { background-color: #6c757d; }
        .btn-print { background-color: #17a2b8; }
        .btn-pay { background-color: #28a745; }
        @media print { .actions { display: none; } }
    </style>
</head>
<body>
<div class="container">
    <h2>Xác Nhận Hóa Đơn Nhập Hàng</h2>

    <div class="info-box">
        <div><strong>Nhân viên quản lý:</strong> <%= invoice.getManager() != null ? invoice.getManager().getName() : "" %></div>
        <div><strong>Nhà cung cấp:</strong> <%= invoice.getSupplier().getName() %> (SĐT: <%= invoice.getSupplier().getPhone() %>)</div>
        <div><strong>Địa chỉ NCC:</strong> <%= invoice.getSupplier().getAddress() %></div>
        <div><strong>Ngày lập phiếu:</strong> <%= sdf.format(invoice.getImportDate()) %></div>
    </div>

    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Ảnh</th>
                <th>Mặt hàng</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <% int stt = 1;
               for (ImportInvoiceDetail2 d : invoice.getItems()) {
                   Item2 it = d.getItem();
                   String imgName = (it.getImage() != null && !it.getImage().trim().isEmpty()) ? it.getImage() : "default_item.jpg"; %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><img src="<%= ctx %>/images/<%= imgName %>" alt="<%= it.getName() %>" class="thumb" onerror="this.src='https://via.placeholder.com/50?text=ShopMan';" /></td>
                    <td><%= it.getName() %></td>
                    <td><%= d.getImportQuantity() %> <%= it.getUnit() %></td>
                    <td><%= nf.format(d.getAmount()) %> VNĐ</td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <div class="total">Tổng tiền thanh toán: <%= nf.format(invoice.getTotal()) %> VNĐ</div>

    <div class="actions">
        <a href="<%= ctx %>/manager/ImportItemFrm2.jsp" class="btn btn-back">&larr; Quay lại</a>
        <div>
            <button type="button" name="btnPrint" class="btn btn-print" onclick="window.print()">In hóa đơn</button>
            <a href="<%= ctx %>/payment" class="btn btn-pay">Thanh toán &rarr;</a>
        </div>
    </div>
</div>
</body>
</html>
