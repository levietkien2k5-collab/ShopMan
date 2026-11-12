package com.shopman.controller;

import com.shopman.dao.SupplierDAO2;
import com.shopman.model.Supplier2;
import com.shopman.model.User2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/supplier", "/supplier/*"})
public class SupplierServlet2 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User2 manager = (User2) session.getAttribute("user");
        if (manager == null) {
            response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
            return;
        }

        String keyword = request.getParameter("keyword");
        keyword = (keyword != null) ? keyword.trim() : "";

        SupplierDAO2 supplierDAO = new SupplierDAO2();
        List<Supplier2> allSuppliers = supplierDAO.getSuppliers();
        List<Supplier2> listSupplier = new ArrayList<>();

        if (keyword.isEmpty()) {
            listSupplier = allSuppliers;
        } else {
            String kwLower = keyword.toLowerCase();
            for (Supplier2 s : allSuppliers) {
                if (s.getName() != null && s.getName().toLowerCase().contains(kwLower)) {
                    listSupplier.add(s);
                }
            }
        }

        request.setAttribute("listSupplier", listSupplier);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/manager/SelectSupplierFrm2.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User2 manager = (User2) session.getAttribute("user");
        if (manager == null) {
            response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/add".equals(pathInfo)) {
            Supplier2 s = new Supplier2();
            s.setName(request.getParameter("name"));
            s.setAddress(request.getParameter("address"));
            s.setPhone(request.getParameter("phone"));
            s.setEmail(request.getParameter("email"));
            s.setDescription(request.getParameter("description"));

            new SupplierDAO2().addSupplier(s);
            response.sendRedirect(request.getContextPath() + "/supplier");
        } else {
            doGet(request, response);
        }
    }
}