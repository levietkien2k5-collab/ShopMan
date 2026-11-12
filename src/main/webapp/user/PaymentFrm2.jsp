<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán hóa đơn - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .box { width: 450px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group select, .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-pay { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer; font-size: 16px; margin-bottom: 10px; }
        .btn-back { display: block; text-align: center; padding: 8px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 3px; }
    </style>
</head>
<body>
<div class="box">
    <h2>Thanh Toán Hóa Đơn</h2>

    <!-- THỜI ĐIỂM 1: Nhân viên Quản lý thanh toán Hóa đơn nhập cho Nhà cung cấp -->
    <c:if test="${not empty sessionScope.importInvoice}">
        <p><strong>Loại giao dịch:</strong> Thanh toán nhập hàng từ nhà cung cấp</p>
        <p><strong>Từ:</strong> ShopMan</p>
        <p><strong>Tới:</strong> ${sessionScope.importInvoice.supplier.name}</p>

        <form action="${pageContext.request.contextPath}/payment/import" method="post">
            <div class="form-group">
                <label>Số tiền cần thanh toán:</label>
                <input type="text" value="<fmt:formatNumber value='${sessionScope.importInvoice.total}' pattern='#,##0'/> VNĐ" readonly />
            </div>
            <div class="form-group">
                <label>Phương thức thanh toán:</label>
                <select name="paymentMethod" required>
                    <option value="Chuyển khoản">Chuyển khoản ngân hàng</option>
                    <option value="Tiền mặt">Tiền mặt</option>
                </select>
            </div>
            <input type="hidden" name="status" value="Đã thanh toán" />
            <button type="submit" class="btn-pay">Xác nhận thanh toán</button>
            <a href="${pageContext.request.contextPath}/manager/ConfirmImportInvoiceFrm2.jsp" class="btn-back">Trở về</a>
        </form>
    </c:if>

    <!-- THỜI ĐIỂM 2: Khách hàng thanh toán Đơn đặt hàng trực tuyến -->
    <c:if test="${not empty sessionScope.customerOrder}">
        <p><strong>Loại giao dịch:</strong> Thanh toán đơn hàng trực tuyến</p>
        <p><strong>Khách hàng thanh toán:</strong> ${sessionScope.user.name}</p>
        <p><strong>Địa chỉ giao hàng:</strong> ${sessionScope.customerOrder.address}</p>

        <form action="${pageContext.request.contextPath}/order/pay" method="post">
            <div class="form-group">
                <label>Số tiền cần thanh toán:</label>
                <input type="text" value="<fmt:formatNumber value='${sessionScope.customerOrder.total}' pattern='#,##0'/> VNĐ" readonly />
            </div>
            <div class="form-group">
                <label>Phương thức thanh toán:</label>
                <select name="paymentMethod" required>
                    <option value="Ví điện tử / QR Code">Ví điện tử (Momo/ZaloPay/VNPAY)</option>
                    <option value="Chuyển khoản">Chuyển khoản ngân hàng</option>
                    <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                </select>
            </div>
            <input type="hidden" name="status" value="Đã thanh toán" />
            <button type="submit" class="btn-pay">Thanh toán đơn hàng</button>
            <a href="${pageContext.request.contextPath}/customer/CartFrm2.jsp" class="btn-back">Trở về giỏ hàng</a>
        </form>
    </c:if>
</div>
</body>
</html>