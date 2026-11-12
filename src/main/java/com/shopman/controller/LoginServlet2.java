package com.shopman.controller;

import com.shopman.dao.UserDAO2;
import com.shopman.model.User2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        // Gọi tầng DAO để kiểm tra đăng nhập
        UserDAO2 userDAO = new UserDAO2();
        User2 user = userDAO.checkLogin(userName, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Lấy vai trò và phân quyền chuyển hướng trang
            String role = userDAO.getUserRole(user.getId());
            session.setAttribute("role", role);

            if ("Manager".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/manager/ManagerHomeFrm2.jsp");
            } else if ("Seller".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/seller/ProcessOrderFrm2.jsp");
            } else {
                // Chuyển hướng qua HomeServlet để tải danh sách sản phẩm
                response.sendRedirect(request.getContextPath() + "/home"); 
            }
        } else {
            // Đăng nhập thất bại -> Gửi thông báo lỗi về LogInFrm2.jsp
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/user/LogInFrm2.jsp").forward(request, response);
        }
    }
}