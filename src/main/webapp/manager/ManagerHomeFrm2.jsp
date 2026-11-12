<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shopman.model.User2" %>
<%
    User2 manager = (User2) session.getAttribute("user");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
        return;
    }
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ShopMan</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: #f4f7fb;
            color: #1e293b;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            width: 250px;
            background: #172554;
            color: white;
            padding: 28px 18px;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 12px 35px;
            font-size: 23px;
            font-weight: 800;
        }

        .logo-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: #3b82f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .menu-label {
            color: #94a3b8;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.2px;
            padding: 0 13px;
            margin-bottom: 14px;
        }

        .sidebar-menu {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .sidebar-menu a {
            text-decoration: none;
            color: #cbd5e1;
            padding: 14px 15px;
            border-radius: 9px;
            display: flex;
            align-items: center;
            gap: 13px;
            font-size: 14px;
            font-weight: 500;
            transition: .2s;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: #2563eb;
            color: white;
        }

        .sidebar-menu i {
            width: 20px;
            text-align: center;
        }

        .sidebar-bottom {
            margin-top: auto;
            padding-top: 25px;
            border-top: 1px solid #334155;
        }

        .sidebar-bottom a {
            color: #fca5a5;
        }

        .sidebar-bottom a:hover {
            background: #7f1d1d;
            color: white;
        }

        /* MAIN CONTENT */
        .main {
            flex: 1;
            min-width: 0;
            padding: 30px 40px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            gap: 15px;
        }

        .welcome h1 {
            font-size: 25px;
            font-weight: 800;
            color: #172554;
            margin-bottom: 8px;
        }

        .welcome p {
            font-size: 14px;
            color: #64748b;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            background: white;
            padding: 10px 16px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(15, 23, 42, .04);
        }

        .avatar {
            width: 42px;
            height: 42px;
            background: #dbeafe;
            color: #2563eb;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .user-name {
            font-size: 13px;
            font-weight: 700;
        }

        .user-role {
            font-size: 11px;
            color: #94a3b8;
            margin-top: 4px;
        }

        /* OVERVIEW */
        .section-title {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 18px;
            color: #1e293b;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: white;
            padding: 23px;
            border-radius: 14px;
            box-shadow: 0 3px 15px rgba(15, 23, 42, .04);
            display: flex;
            align-items: center;
            gap: 17px;
        }

        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
        }

        .blue {
            background: #dbeafe;
            color: #2563eb;
        }

        .green {
            background: #dcfce7;
            color: #16a34a;
        }

        .orange {
            background: #ffedd5;
            color: #ea580c;
        }

        .stat-card h3 {
            font-size: 21px;
            margin-bottom: 5px;
            color: #172554;
        }

        .stat-card p {
            font-size: 12px;
            color: #94a3b8;
        }

        /* FUNCTION CARDS */
        .function-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }

        .function-card {
            background: white;
            border-radius: 14px;
            padding: 25px;
            text-decoration: none;
            color: inherit;
            border: 1px solid #edf0f5;
            transition: .25s;
            display: block;
        }

        .function-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(37, 99, 235, .1);
            border-color: #bfdbfe;
        }

        .function-icon {
            width: 55px;
            height: 55px;
            border-radius: 14px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 23px;
            margin-bottom: 20px;
        }

        .function-card h3 {
            font-size: 16px;
            margin-bottom: 9px;
            color: #1e293b;
        }

        .function-card p {
            font-size: 13px;
            line-height: 1.6;
            color: #94a3b8;
            margin-bottom: 20px;
        }

        .card-link {
            color: #2563eb;
            font-size: 13px;
            font-weight: 700;
        }

        .card-link i {
            margin-left: 5px;
            transition: .2s;
        }

        .function-card:hover .card-link i {
            transform: translateX(5px);
        }

        .footer {
            margin-top: 45px;
            text-align: center;
            color: #94a3b8;
            font-size: 12px;
        }

        /* SUCCESS MODAL */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, .55);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            padding: 15px;
        }

        .modal-box {
            background: white;
            width: 380px;
            max-width: 100%;
            border-radius: 16px;
            text-align: center;
            padding: 30px;
            box-shadow: 0 15px 50px rgba(0,0,0,.2);
            animation: showModal .25s ease;
        }

        @keyframes showModal {
            from {
                opacity: 0;
                transform: translateY(15px) scale(.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .success-icon {
            width: 65px;
            height: 65px;
            background: #dcfce7;
            color: #16a34a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin: 0 auto 18px;
        }

        .modal-box h3 {
            font-size: 19px;
            margin-bottom: 10px;
            color: #172554;
        }

        .modal-box p {
            font-size: 13px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 22px;
        }

        .modal-btn {
            background: #2563eb;
            color: white;
            border: none;
            padding: 11px 35px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 700;
        }

        .modal-btn:hover {
            background: #1d4ed8;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .sidebar {
                width: 210px;
            }

            .main {
                padding: 25px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 600px) {
            .layout {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                padding: 15px;
            }

            .logo {
                padding-bottom: 15px;
            }

            .menu-label {
                display: none;
            }

            .sidebar-menu {
                flex-direction: row;
                flex-wrap: wrap;
            }

            .sidebar-menu a {
                flex: 1;
                justify-content: center;
                font-size: 12px;
                padding: 10px;
            }

            .sidebar-bottom {
                margin-top: 10px;
                padding-top: 10px;
            }

            .main {
                padding: 20px 15px;
            }

            .topbar {
                align-items: flex-start;
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-icon">
                <i class="fa-solid fa-store"></i>
            </div>
            <span>ShopMan</span>
        </div>

        <div class="menu-label">MENU CHÍNH</div>

        <nav class="sidebar-menu">
            <a href="#" class="active">
                <i class="fa-solid fa-house"></i>
                Trang chủ
            </a>

            <a href="<%= ctx %>/supplier">
                <i class="fa-solid fa-truck-field"></i>
                Nhập hàng
            </a>
        </nav>

        <div class="sidebar-bottom">
            <nav class="sidebar-menu">
                <a href="<%= ctx %>/logout">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Đăng xuất
                </a>
            </nav>
        </div>
    </aside>

    <!-- MAIN -->
    <main class="main">

        <!-- HEADER -->
        <header class="topbar">
            <div class="welcome">
                <h1>Trang chủ quản lý</h1>
                <p>Chào mừng bạn quay trở lại hệ thống ShopMan!</p>
            </div>

            <div class="user-info">
                <div class="avatar">
                    <i class="fa-solid fa-user-tie"></i>
                </div>
                <div>
                    <div class="user-name">
                        <%= manager.getName() %>
                    </div>
                    <div class="user-role">Quản lý hệ thống</div>
                </div>
            </div>
        </header>

        <!-- OVERVIEW -->
        <h2 class="section-title">Tổng quan hệ thống</h2>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <div>
                    <h3>Kho hàng</h3>
                    <p>Quản lý hàng hóa</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fa-solid fa-truck"></i>
                </div>
                <div>
                    <h3>Nhà cung cấp</h3>
                    <p>Quản lý nhập hàng</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon orange">
                    <i class="fa-solid fa-file-invoice-dollar"></i>
                </div>
                <div>
                    <h3>Hóa đơn</h3>
                    <p>Theo dõi giao dịch nhập hàng</p>
                </div>
            </div>
        </div>

        <!-- FUNCTIONS -->
        <h2 class="section-title">Chức năng quản lý</h2>

        <div class="function-grid">

            <a href="<%= ctx %>/supplier" class="function-card">
                <div class="function-icon">
                    <i class="fa-solid fa-truck-ramp-box"></i>
                </div>
                <h3>Nhập hàng từ nhà cung cấp</h3>
                <p>
                    Tạo phiếu nhập hàng, lựa chọn nhà cung cấp,
                    thêm sản phẩm và thực hiện thanh toán hóa đơn.
                </p>
                <div class="card-link">
                    Truy cập chức năng
                    <i class="fa-solid fa-arrow-right"></i>
                </div>
            </a>

            <!-- Có thể thêm các chức năng khác tại đây -->

        </div>

        <div class="footer">
            © 2026 ShopMan - Hệ thống quản lý cửa hàng
        </div>

    </main>
</div>

<!-- SUCCESS MODAL -->
<div id="customAlert" class="modal-overlay">
    <div class="modal-box">
        <div class="success-icon">
            <i class="fa-solid fa-check"></i>
        </div>

        <h3>Thành công!</h3>

        <p>
            Nhập hàng và thanh toán hóa đơn thành công!
        </p>

        <button type="button" class="modal-btn"
                onclick="closeAlertModal()">
            Xác nhận
        </button>
    </div>
</div>

<script>
    function closeAlertModal() {
        document.getElementById("customAlert").style.display = "none";

        if (window.history.replaceState) {
            const url = new URL(window.location.href);
            url.searchParams.delete("status");

            window.history.replaceState(
                {},
                document.title,
                url.pathname + url.search + url.hash
            );
        }
    }

    <% if ("import_success".equals(request.getParameter("status"))) { %>
        document.getElementById("customAlert").style.display = "flex";
    <% } %>
</script>

</body>
</html>