package com.shopman.controller;

import com.shopman.dao.ItemDAO2;
import com.shopman.dao.SupplierDAO2;
import com.shopman.model.ImportInvoice2;
import com.shopman.model.ImportInvoiceDetail2;
import com.shopman.model.Item2;
import com.shopman.model.Manager2;
import com.shopman.model.Supplier2;
import com.shopman.model.SupplierItem2;
import com.shopman.model.User2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/import/*")
public class ImportServlet2 extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String pathInfo = request.getPathInfo();

        Manager2 manager = getSessionManager(session);
        if (manager == null) {
            response.sendRedirect(request.getContextPath() + "/user/LogInFrm2.jsp");
            return;
        }

        ImportInvoice2 invoice = (ImportInvoice2) session.getAttribute("importInvoice");
        if (invoice == null) {
            invoice = new ImportInvoice2();
            invoice.setManager(manager);
            session.setAttribute("importInvoice", invoice);
        }

        if ("/add-supplier".equals(pathInfo)) {
            Supplier2 s = new Supplier2();
            s.setName(request.getParameter("name"));
            s.setAddress(request.getParameter("address"));
            s.setPhone(request.getParameter("phone"));
            s.setEmail(request.getParameter("email"));
            s.setDescription(request.getParameter("description"));

            new SupplierDAO2().addSupplier(s);
            response.sendRedirect(request.getContextPath() + "/manager/SelectSupplierFrm2.jsp");

        } else if ("/select-supplier".equals(pathInfo)) {
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            Supplier2 supplier = new SupplierDAO2().getSupplierById(supplierId);
            if (invoice.getSupplier() == null || invoice.getSupplier().getId() != supplierId) {
                invoice.getItems().clear();
            }
            invoice.setSupplier(supplier);
            invoice.setManager(manager);
            session.removeAttribute("selectedSupplierItem");
            session.removeAttribute("isEditItem");
            response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");

        } else if ("/link-item".equals(pathInfo)) {
            if (invoice.getSupplier() != null) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                int importPrice = Integer.parseInt(request.getParameter("importPrice"));
                int minQty = Integer.parseInt(request.getParameter("minImportQuantity"));
                SupplierDAO2 supplierDAO = new SupplierDAO2();
                supplierDAO.addSupplierItem(invoice.getSupplier().getId(), itemId, importPrice, minQty);
                invoice.setSupplier(supplierDAO.getSupplierById(invoice.getSupplier().getId()));
            }
            response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");

        } else if ("/select-item".equals(pathInfo)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            boolean isEdit = "edit".equals(request.getParameter("mode"));
            Supplier2 supplier = invoice.getSupplier();
            if (supplier != null) {
                for (SupplierItem2 si : supplier.getItems()) {
                    if (si.getItem().getId() == itemId) {
                        session.setAttribute("selectedSupplierItem", si);
                        session.setAttribute("isEditItem", isEdit);
                        break;
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");

        } else if ("/save-quantity".equals(pathInfo)) {
            SupplierItem2 si = (SupplierItem2) session.getAttribute("selectedSupplierItem");
            int importQuantity = Integer.parseInt(request.getParameter("importQuantity"));
            Boolean isEdit = (Boolean) session.getAttribute("isEditItem");

            if (si != null) {
                if (importQuantity < si.getMinImportQuantity()) {
                    response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp?error=min_qty");
                    return;
                }

                boolean exists = false;
                for (ImportInvoiceDetail2 d : invoice.getItems()) {
                    if (d.getItem().getId() == si.getItem().getId()) {
                        int newQty = Boolean.TRUE.equals(isEdit) ? importQuantity : (d.getImportQuantity() + importQuantity);
                        d.setImportQuantity(newQty);
                        d.setAmount(newQty * si.getImportPrice());
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    ImportInvoiceDetail2 d = new ImportInvoiceDetail2();
                    d.setItem(si.getItem());
                    d.setImportQuantity(importQuantity);
                    d.setAmount(importQuantity * si.getImportPrice());
                    invoice.getItems().add(d);
                }
                invoice.getTotal();
                session.removeAttribute("selectedSupplierItem");
                session.removeAttribute("isEditItem");
            }
            response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");

        } else if ("/confirm".equals(pathInfo)) {
            if (invoice.getSupplier() == null || invoice.getItems().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp?error=empty");
                return;
            }
            session.removeAttribute("selectedSupplierItem");
            session.removeAttribute("isEditItem");
            invoice.setImportDate(new Date());
            invoice.getTotal();
            response.sendRedirect(request.getContextPath() + "/manager/ConfirmImportInvoiceFrm2.jsp");

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();

        if ("/items".equals(pathInfo)) {
            showImportItems(request, response);
        } else if ("/remove-item".equals(pathInfo)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            ImportInvoice2 invoice = (ImportInvoice2) session.getAttribute("importInvoice");
            if (invoice != null && invoice.getItems() != null) {
                invoice.getItems().removeIf(d -> d.getItem().getId() == itemId);
                invoice.getTotal();
            }
            response.sendRedirect(request.getContextPath() + "/manager/ImportItemFrm2.jsp");
        }
    }
    
    private void showImportItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ctx = request.getContextPath();

        // 1. Kiểm tra đăng nhập & hóa đơn nhập trong session
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

        // 2. Đóng hộp thoại nhập số lượng khi nhấn Hủy
        if ("1".equals(request.getParameter("cancel"))) {
            session.removeAttribute("selectedSupplierItem");
            session.removeAttribute("isEditItem");
        }

        // 3. Lấy từ khóa tìm kiếm và lọc danh sách mặt hàng của NCC
        String keyword = request.getParameter("keyword");
        keyword = (keyword != null) ? keyword.trim() : "";

        Supplier2 supplier = invoice.getSupplier();
        List<SupplierItem2> allSupplierItems = supplier.getItems();
        List<SupplierItem2> listItem = new ArrayList<>();
        Set<Integer> existingItemIds = new HashSet<>();

        if (allSupplierItems != null) {
            for (SupplierItem2 si : allSupplierItems) {
                if (si.getItem() != null) {
                    existingItemIds.add(si.getItem().getId());
                    if (keyword.isEmpty() || (si.getItem().getName() != null
                            && si.getItem().getName().toLowerCase().contains(keyword.toLowerCase()))) {
                        listItem.add(si);
                    }
                }
            }
        }

        // 4. Lấy toàn bộ mặt hàng trong hệ thống cho Modal "Thêm mặt hàng mới cho NCC"
        List<Item2> allItems = new ItemDAO2().getItems();

        // 5. Đẩy dữ liệu sang JSP
        request.setAttribute("keyword", keyword);
        request.setAttribute("listItem", listItem);
        request.setAttribute("existingItemIds", existingItemIds);
        request.setAttribute("allItems", allItems);

        request.getRequestDispatcher("/manager/ImportItemFrm2.jsp").forward(request, response);
    }
}
