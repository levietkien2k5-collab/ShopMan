<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Set, java.util.HashSet, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="com.shopman.dao.ItemDAO2, com.shopman.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Set, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="com.shopman.model.*" %>
<%
    String ctx = request.getContextPath();
    User2 manager = (User2) session.getAttribute("user");
    if (manager == null) {
        response.sendRedirect(ctx + "/user/LogInFrm2.jsp");
        return;
    }

    ImportInvoice2 invoice = (ImportInvoice2) session.getAttribute("importInvoice");
    if (invoice == null || invoice.getSupplier() == null) {
        response.sendRedirect(ctx + "/manager/SelectSupplierFrm2.jsp");
        return;
    }

    // Nếu người dùng truy cập trực tiếp file JSP mà chưa qua Servlet thì điều hướng về Servlet
    @SuppressWarnings("unchecked")
    List<SupplierItem2> listItem = (List<SupplierItem2>) request.getAttribute("listItem");
    if (listItem == null) {
        String kwParam = request.getParameter("keyword");
        String target = ctx + "/import/items" + (kwParam != null ? "?keyword=" + java.net.URLEncoder.encode(kwParam, "UTF-8") : "");
        response.sendRedirect(target);
        return;
    }

    @SuppressWarnings("unchecked")
    Set<Integer> existingItemIds = (Set<Integer>) request.getAttribute("existingItemIds");
    @SuppressWarnings("unchecked")
    List<Item2> allItems = (List<Item2>) request.getAttribute("allItems");
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";

    Supplier2 supplier = invoice.getSupplier();
    List<ImportInvoiceDetail2> selectedDetails = invoice.getItems();
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chọn mặt hàng nhập - ShopMan</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8f9fa; }
        .container { max-width: 960px; margin: auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .info-bar { background: #e9f5ff; padding: 12px 16px; border-radius: 6px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .search-bar { display: flex; gap: 10px; margin-bottom: 15px; }
        .search-bar input[type="text"] { flex: 1; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; vertical-align: middle; }
        th { background-color: #007bff; color: white; }
        .thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
        .btn { padding: 8px 14px; border: none; border-radius: 4px; color: white; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; font-size: 14px; }
        .btn-blue { background-color: #007bff; }
        .btn-green { background-color: #28a745; }
        .btn-edit { background-color: #f0ad4e; padding: 5px 10px; font-size: 12px; margin-right: 4px; }
        .btn-red { background-color: #dc3545; padding: 5px 10px; font-size: 12px; }
        .btn-gray { background-color: #6c757d; }
        .btn-selected { background-color: #adb5bd; color: #fff; cursor: not-allowed; }
        .total-box { text-align: right; font-size: 18px; font-weight: bold; color: #d9534f; margin-bottom: 15px; }
        .error { color: red; font-weight: bold; margin-bottom: 12px; }

        /* Modal chung & lớp nền tối */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.55); align-items: center; justify-content: center; z-index: 1000; }
        .modal-content { background: white; padding: 20px; width: 420px; border-radius: 6px; box-shadow: 0 4px 15px rgba(0,0,0,0.25); }
        .modal-content input[type="number"] { width: 100%; padding: 8px; margin-top: 4px; margin-bottom: 12px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }

        /* Ô kích hoạt chọn mặt hàng trong modal đăng ký */
        .item-picker-box {
            display: flex; justify-content: space-between; align-items: center;
            width: 100%; min-height: 42px; padding: 6px 10px; margin-top: 4px; margin-bottom: 12px;
            box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px;
            background: #fff; cursor: pointer;
        }
        .item-picker-box:hover { border-color: #007bff; }

        /* Modal danh sách mặt hàng (hiển thị đè lên trên) */
        .picker-modal { z-index: 1100; }
        .picker-content { width: 540px; max-height: 80vh; display: flex; flex-direction: column; }
        .picker-list { overflow-y: auto; max-height: 360px; margin-top: 10px; }
        .picker-list table { margin-bottom: 0; }
    </style>
</head>
<body>
<div class="container">
    <h2>Nhập Hàng Từ Nhà Cung Cấp</h2>

    <div class="info-bar">
        <div>
            <strong>Nhà cung cấp:</strong> <%= supplier.getName() %> | <strong>SĐT:</strong> <%= supplier.getPhone() %>
        </div>
        <button type="button" class="btn btn-green" onclick="openLinkItemModal()">Thêm mặt hàng mới cho NCC</button>
    </div>

    <% if ("empty".equals(request.getParameter("error"))) { %>
        <div class="error">Vui lòng chọn ít nhất 1 mặt hàng vào phiếu nhập trước khi xác nhận!</div>
    <% } %>

    <h3>Danh sách mặt hàng của nhà cung cấp</h3>

    <form action="<%= ctx %>/import/items" method="get" class="search-bar">
        <input type="text" name="keyword" value="<%= keyword.replace("\"", "&quot;") %>" placeholder="Nhập tên mặt hàng..." />
        <button type="submit" class="btn btn-blue">Tìm kiếm</button>
    </form>

    <table id="tblItem">
        <thead>
            <tr>
                <th>STT</th>
                <th>Ảnh</th>
                <th>Tên mặt hàng</th>
                <th>Đơn vị</th>
                <th>Mô tả</th>
                <th>Giá nhập</th>
                <th>SL tối thiểu</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <% if (listItem != null && !listItem.isEmpty()) {
                int itemStt = 1;
                for (SupplierItem2 si : listItem) {
                    Item2 it = si.getItem();
                    String imgName = (it.getImage() != null && !it.getImage().trim().isEmpty()) ? it.getImage() : "default_item.jpg"; %>
                <tr>
                    <td><%= itemStt++ %></td>
                    <td><img src="<%= ctx %>/images/<%= imgName %>" alt="<%= it.getName() %>" class="thumb" onerror="this.src='https://via.placeholder.com/50?text=ShopMan';" /></td>
                    <td><%= it.getName() %></td>
                    <td><%= it.getUnit() %></td>
                    <td><%= it.getDescription() %></td>
                    <td><%= nf.format(si.getImportPrice()) %> VNĐ</td>
                    <td><%= si.getMinImportQuantity() %></td>
                    <td>
                        <form action="<%= ctx %>/import/select-item" method="post" style="margin:0;">
                            <input type="hidden" name="itemId" value="<%= it.getId() %>" />
                            <button type="submit" class="btn btn-blue">Chọn nhập</button>
                        </form>
                    </td>
                </tr>
            <%  }
               } else { %>
                <tr><td colspan="8" style="color:#888;">Không tìm thấy mặt hàng phù hợp.</td></tr>
            <% } %>
        </tbody>
    </table>

    <h3>Danh sách mặt hàng đã chọn nhập</h3>
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tên mặt hàng</th>
                <th>Đơn vị</th>
                <th>Số lượng nhập</th>
                <th>Thành tiền</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <% if (selectedDetails != null && !selectedDetails.isEmpty()) {
                int stt = 1;
                for (ImportInvoiceDetail2 d : selectedDetails) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= d.getItem().getName() %></td>
                    <td><%= d.getItem().getUnit() %></td>
                    <td><%= d.getImportQuantity() %></td>
                    <td><%= nf.format(d.getAmount()) %> VNĐ</td>
                    <td>
                        <form action="<%= ctx %>/import/select-item" method="post" style="display:inline; margin:0;">
                            <input type="hidden" name="itemId" value="<%= d.getItem().getId() %>" />
                            <input type="hidden" name="mode" value="edit" />
                            <button type="submit" class="btn btn-edit">Sửa</button>
                        </form>
                        <a href="<%= ctx %>/import/remove-item?itemId=<%= d.getItem().getId() %>" class="btn btn-red">Xóa</a>
                    </td>
                </tr>
            <%  }
               } else { %>
                <tr><td colspan="6" style="color:#888;">Chưa chọn mặt hàng nào.</td></tr>
            <% } %>
        </tbody>
    </table>

    <div class="total-box">Tổng tiền dự kiến: <%= nf.format(invoice.getTotal()) %> VNĐ</div>

    <div style="display: flex; justify-content: space-between;">
        <a href="<%= ctx %>/manager/SelectSupplierFrm2.jsp" class="btn btn-gray">&larr; Đổi nhà cung cấp</a>
        <form action="<%= ctx %>/import/confirm" method="post" style="margin:0;">
            <button type="submit" name="btnConfirm" class="btn btn-green">Xác nhận hóa đơn &rarr;</button>
        </form>
    </div>
</div>

<!-- Lớp phủ ImportQuantityFrm2 đè lên giao diện hiện tại khi chọn/sửa mặt hàng -->
<% if (session.getAttribute("selectedSupplierItem") != null) { %>
    <jsp:include page="ImportQuantityFrm2.jsp" />
<% } %>

<!-- Modal 1: Đăng ký mặt hàng cung cấp -->
<div id="linkItemModal" class="modal">
    <div class="modal-content">
        <h3 style="margin-top:0;">Đăng ký mặt hàng cung cấp</h3>
        <form id="linkItemForm" action="<%= ctx %>/import/link-item" method="post">
            <label>Mặt hàng (*):</label>
            <input type="hidden" id="linkItemIdInput" name="itemId" />
            <div id="itemPickerTrigger" class="item-picker-box" onclick="openItemPicker()">
                <span style="color:#6c757d;">-- Nhấn để chọn mặt hàng --</span>
                <span style="color:#007bff; font-size:13px;">Chọn &#9662;</span>
            </div>
            <div id="linkItemError" style="color:red; font-size:13px; margin-top:-8px; margin-bottom:10px; display:none;">
                Vui lòng chọn một mặt hàng!
            </div>

            <label>Giá nhập (VNĐ):</label>
            <input type="number" name="importPrice" min="1000" step="500" required />

            <label>Số lượng nhập tối thiểu:</label>
            <input type="number" name="minImportQuantity" min="1" value="10" required />

            <div style="margin-top: 8px;">
                <button type="submit" class="btn btn-green">Lưu</button>
                <button type="button" class="btn btn-gray" onclick="document.getElementById('linkItemModal').style.display='none'">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal 2: Danh sách mặt hàng (Ảnh + Tên + Chọn / Đã chọn) -->
<div id="itemPickerModal" class="modal picker-modal">
    <div class="modal-content picker-content">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
            <h3 style="margin:0;">Chọn Mặt Hàng</h3>
            <button type="button" class="btn btn-gray" style="padding:4px 10px;" onclick="document.getElementById('itemPickerModal').style.display='none'">Đóng</button>
        </div>

        <input type="text" id="pickerSearchInput" onkeyup="filterPickerItems()" placeholder="Tìm nhanh theo tên mặt hàng..." style="width:100%; padding:8px; box-sizing:border-box; border:1px solid #ccc; border-radius:4px;" />

        <div class="picker-list">
            <table>
                <thead>
                    <tr>
                        <th style="width:70px;">Ảnh</th>
                        <th>Tên mặt hàng</th>
                        <th style="width:110px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="pickerTableBody">
                    <% if (allItems != null && !allItems.isEmpty()) {
                        for (Item2 it : allItems) {
                            String imgName = (it.getImage() != null && !it.getImage().trim().isEmpty()) ? it.getImage() : "default_item.jpg";
                            boolean isAdded = existingItemIds.contains(it.getId());
                            String displayLabel = it.getName() + " (" + it.getUnit() + ")"; %>
                        <tr class="picker-row" data-search="<%= it.getName().toLowerCase().replace("\"", "&quot;") %>">
                            <td>
                                <img src="<%= ctx %>/images/<%= imgName %>" alt="<%= it.getName() %>" class="thumb" onerror="this.src='https://via.placeholder.com/50?text=ShopMan';" />
                            </td>
                            <td style="text-align:left; font-weight:bold;"><%= displayLabel %></td>
                            <td>
                                <% if (isAdded) { %>
                                    <button type="button" class="btn btn-selected" disabled>Đã chọn</button>
                                <% } else { %>
                                    <button type="button"
                                            class="btn btn-blue"
                                            data-id="<%= it.getId() %>"
                                            data-name="<%= displayLabel.replace("\"", "&quot;") %>"
                                            data-img="<%= imgName %>"
                                            onclick="chooseLinkItem(this)">Chọn</button>
                                <% } %>
                            </td>
                        </tr>
                    <%  }
                       } else { %>
                        <tr><td colspan="3" style="color:#888;">Chưa có mặt hàng nào trong hệ thống.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function openLinkItemModal() {
        document.getElementById("linkItemForm").reset();
        document.getElementById("linkItemIdInput").value = "";
        document.getElementById("linkItemError").style.display = "none";
        document.getElementById("itemPickerTrigger").innerHTML =
            '<span style="color:#6c757d;">-- Nhấn để chọn mặt hàng --</span>' +
            '<span style="color:#007bff; font-size:13px;">Chọn &#9662;</span>';
        document.getElementById("linkItemModal").style.display = "flex";
    }

    function openItemPicker() {
        document.getElementById("pickerSearchInput").value = "";
        filterPickerItems();
        document.getElementById("itemPickerModal").style.display = "flex";
    }

    function chooseLinkItem(btn) {
        const id = btn.getAttribute("data-id");
        const name = btn.getAttribute("data-name");
        const img = btn.getAttribute("data-img");
        const ctx = "<%= ctx %>";

        document.getElementById("linkItemIdInput").value = id;
        document.getElementById("linkItemError").style.display = "none";

        const trigger = document.getElementById("itemPickerTrigger");
        trigger.innerHTML = "";

        const leftDiv = document.createElement("div");
        leftDiv.style.display = "flex";
        leftDiv.style.alignItems = "center";
        leftDiv.style.gap = "10px";

        const imgEl = document.createElement("img");
        imgEl.src = ctx + "/images/" + img;
        imgEl.style.width = "32px";
        imgEl.style.height = "32px";
        imgEl.style.objectFit = "cover";
        imgEl.style.borderRadius = "4px";
        imgEl.style.border = "1px solid #ddd";
        imgEl.onerror = function() { this.src = "https://via.placeholder.com/32?text=SP"; };

        const nameSpan = document.createElement("span");
        nameSpan.style.fontWeight = "bold";
        nameSpan.style.color = "#333";
        nameSpan.textContent = name;

        leftDiv.appendChild(imgEl);
        leftDiv.appendChild(nameSpan);

        const rightSpan = document.createElement("span");
        rightSpan.style.color = "#007bff";
        rightSpan.style.fontSize = "13px";
        rightSpan.innerHTML = "Đổi &#9662;";

        trigger.appendChild(leftDiv);
        trigger.appendChild(rightSpan);

        document.getElementById("itemPickerModal").style.display = "none";
    }

    function filterPickerItems() {
        const kw = document.getElementById("pickerSearchInput").value.trim().toLowerCase();
        const rows = document.querySelectorAll("#pickerTableBody .picker-row");
        rows.forEach(row => {
            const name = row.getAttribute("data-search") || "";
            row.style.display = name.includes(kw) ? "" : "none";
        });
    }

    document.getElementById("linkItemForm").addEventListener("submit", function(e) {
        if (!document.getElementById("linkItemIdInput").value) {
            e.preventDefault();
            document.getElementById("linkItemError").style.display = "block";
        }
    });
</script>
</body>
</html>