package com.shopman.controller;

import com.shopman.dao.CustomerDAO2;
import com.shopman.model.Customer2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/register")
public class RegisterServlet2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Lấy tham số từ Form SignUpFrm2.jsp
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dateOfBirth");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // 2. Kiểm tra mật khẩu xác nhận
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/customer/SignUpFrm2.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra độ dài mật khẩu (theo kịch bản ngoại lệ)
        if (password.length() < 8) {
            request.setAttribute("error", "Mật khẩu phải chứa ít nhất 8 ký tự!");
            request.getRequestDispatcher("/customer/SignUpFrm2.jsp").forward(request, response);
            return;
        }

        // 4. Gọi CustomerDAO2 kiểm tra tên đăng nhập đã tồn tại chưa
        CustomerDAO2 customerDAO = new CustomerDAO2();
        if (customerDAO.checkUserNameExists(userName)) {
            request.setAttribute("error", "Tên đăng nhập '" + userName + "' đã được sử dụng!");
            request.getRequestDispatcher("/customer/SignUpFrm2.jsp").forward(request, response);
            return;
        }

        // 5. Chuyển đổi chuỗi ngày sinh sang java.util.Date
        Date dateOfBirth = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                dateOfBirth = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 6. Đóng gói đối tượng Customer2
        Customer2 customer = new Customer2();
        customer.setUserName(userName);
        customer.setPassword(password);
        customer.setName(name);
        customer.setDateOfBirth(dateOfBirth);
        customer.setPhone(phone);
        customer.setEmail(email);

        // 7. Gọi CustomerDAO2 để thực thi đăng ký tài khoản
        boolean isSuccess = customerDAO.registerCustomer(customer);

        if (isSuccess) {
            // Đăng ký thành công
            response.sendRedirect(request.getContextPath() + "/customer/SignUpFrm2.jsp?status=success");
        } else {
            request.setAttribute("error", "Hệ thống gặp lỗi trong quá trình lưu dữ liệu!");
            request.getRequestDispatcher("/customer/SignUpFrm2.jsp").forward(request, response);
        }
    }
}