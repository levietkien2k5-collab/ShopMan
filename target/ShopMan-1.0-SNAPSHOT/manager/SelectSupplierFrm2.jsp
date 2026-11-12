<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.shopman.model.Supplier2, com.shopman.model.User2" %>
<%
    User2 manager = (User2) session.getAttribute("user");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
        return;
    }

    // Nếu truy cập trực tiếp file JSP mà chưa qua SupplierServlet2 thì điều hướng qua Servlet
    List<Supplier2> listSupplier = (List<Supplier2>) request.getAttribute("listSupplier");
    if (listSupplier == null) {
        response.sendRedirect(request.getContextPath() + "/supplier");
        return;
    }

    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chọn nhà cung cấp - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8f9fa; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        h2 { margin: 0; color: #333; }
        .search-bar { display: flex; gap: 10px; margin-bottom: 20px; }
        .search-bar input[type="text"] { flex: 1; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #007bff; color: white; }
        .btn { padding: 8px 14px; border: none; border-radius: 4px; color: white; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; font-size: 14px; }
        .btn-blue { background-color: #007bff; }
        .btn-green { background-color: #28a745; }
        .btn-gray { background-color: #6c757d; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 1000; }
        .modal-content { background: white; padding: 20px; width: 400px; border-radius: 6px; }
        .modal-content input { width: 100%; padding: 8px; margin-top: 4px; margin-bottom: 12px; box-sizing: border-box; }
    </style>
</head>
<body>
<div class="container">
    <div class="top-bar">
        <h2>Chọn Nhà Cung Cấp</h2>
        <button type="button" class="btn btn-green" onclick="document.getElementById('addSupplierModal').style.display='flex'">Thêm nhà cung cấp mới</button>
    </div>

    <form action="<%= ctx %>/supplier" method="get" class="search-bar">
        <input type="text" name="keyword" value="<%= keyword.replace("\"", "&quot;") %>" placeholder="Nhập tên nhà cung cấp..." />
        <button type="submit" class="btn btn-blue">Tìm kiếm</button>
    </form>

    <table id="tblSupplier">
        <thead>
            <tr>
                <th>Mã NCC</th>
                <th>Tên nhà cung cấp</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Mô tả</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <% if (!listSupplier.isEmpty()) {
                for (Supplier2 s : listSupplier) { %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getAddress() != null ? s.getAddress() : "" %></td>
                    <td><%= s.getPhone() != null ? s.getPhone() : "" %></td>
                    <td><%= s.getEmail() != null ? s.getEmail() : "" %></td>
                    <td><%= s.getDescription() != null ? s.getDescription() : "" %></td>
                    <td>
                        <form action="<%= ctx %>/import/select-supplier" method="post" style="margin:0;">
                            <input type="hidden" name="supplierId" value="<%= s.getId() %>" />
                            <button type="submit" class="btn btn-blue">Chọn</button>
                        </form>
                    </td>
                </tr>
            <%  }
               } else { %>
                <tr>
                    <td colspan="7" style="color: #888;">Không tìm thấy nhà cung cấp phù hợp.</td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <a href="<%= ctx %>/manager/ManagerHomeFrm2.jsp" class="btn btn-gray">&larr; Trở về trang chủ</a>
</div>

<div id="addSupplierModal" class="modal">
    <div class="modal-content">
        <h3>Thêm Nhà Cung Cấp Mới</h3>
        <form action="<%= ctx %>/supplier/add" method="post">
            <label>Tên nhà cung cấp (*):</label>
            <input type="text" name="name" required />
            <label>Địa chỉ:</label>
            <input type="text" name="address" />
            <label>Số điện thoại:</label>
            <input type="text" name="phone" />
            <label>Email:</label>
            <input type="email" name="email" />
            <label>Mô tả:</label>
            <input type="text" name="description" />
            <button type="submit" class="btn btn-green">Lưu</button>
            <button type="button" class="btn btn-gray" onclick="document.getElementById('addSupplierModal').style.display='none'">Hủy</button>
        </form>
    </div>
</div>
</body>
</html>