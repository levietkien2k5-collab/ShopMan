<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Duyệt & Xử lý đơn hàng - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table, th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .btn-approve { padding: 6px 12px; background-color: #28a745; color: white; text-decoration: none; border-radius: 3px; }
    </style>
</head>
<body>
    <h2>Danh sách đơn hàng trực tuyến cần xử lý</h2>
    <table>
        <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Ngày đặt</th>
                <th>Khách hàng</th>
                <th>Địa chỉ giao</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>#ORD001</td>
                <td>2026-03-30</td>
                <td>Nguyễn Văn An</td>
                <td>Hà Nội</td>
                <td>Chờ duyệt</td>
                <td><a href="#" class="btn-approve">Duyệt đơn</a></td>
            </tr>
        </tbody>
    </table>
</body>
</html>