package com.shopman.controller;

import com.shopman.dao.ImportInvoiceDAO2;
import com.shopman.dao.ItemDAO2;
import com.shopman.dao.PaymentDAO2;
import com.shopman.model.ImportInvoice2;
import com.shopman.model.ImportInvoiceDetail2;
import com.shopman.model.Manager2;
import com.shopman.model.Payment2;
import com.shopman.model.User2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/payment", "/payment/*"})
public class PaymentServlet2 extends HttpServlet {

    private Manager2 getSessionManager(HttpSession session) {
        User2 u = (User2) session.getAttribute("user");
        if (u == null) return null;
        if (u instanceof Manager2) return (Manager2) u;
        Manager2 m = new Manager2();
        m.setId(u.getId());
        m.setName(u.getName());
        m.setDateOfBirth(u.getDateOfBirth());
        m.setPhone(u.getPhone());
        m.setEmail(u.getEmail());
        m.setUserName(u.getUserName());
        m.setPassword(u.getPassword());
        return m;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
            return;
        }
        request.getRequestDispatcher("/user/PaymentFrm2.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String pathInfo = request.getPathInfo();

        if ("/import".equals(pathInfo) || (pathInfo == null && session.getAttribute("importInvoice") != null)) {
            Manager2 manager = getSessionManager(session);
            if (manager == null) {
                response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
                return;
            }

            ImportInvoice2 invoice = (ImportInvoice2) session.getAttribute("importInvoice");
            if (invoice == null || invoice.getSupplier() == null || invoice.getItems().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");
                return;
            }

            if (invoice.getManager() == null) {
                invoice.setManager(manager);
            }

            String paymentMethod = request.getParameter("paymentMethod");
            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "Đã thanh toán";
            }

            Payment2 payment = new Payment2();
            payment.setPaymentDate(new Date());
            payment.setAmount(invoice.getTotal());
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus(status);

            PaymentDAO2 paymentDAO = new PaymentDAO2();
            ImportInvoiceDAO2 importInvoiceDAO = new ImportInvoiceDAO2();
            ItemDAO2 itemDAO = new ItemDAO2();

            if (paymentDAO.processPayment(payment)) {
                invoice.setPayment(payment);
                for (ImportInvoiceDetail2 d : invoice.getItems()) {
                    itemDAO.updateStockQuantity(d.getItem().getId(), d.getImportQuantity());
                }
                if (importInvoiceDAO.saveImportInvoice(invoice)) {
                    session.removeAttribute("importInvoice");
                    response.sendRedirect(request.getContextPath() + "/manager/ManagerHomeFrm2.jsp?status=import_success");
                    return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/user/PaymentFrm2.jsp?error=failed");
        }
    }
}