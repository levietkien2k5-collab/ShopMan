package com.shopman.controller;

import com.shopman.dao.ItemDAO2;
import com.shopman.model.Item2;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet2 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("search");

        ItemDAO2 itemDAO = new ItemDAO2();
        List<Item2> itemList = itemDAO.getItemsByName(keyword);

        request.setAttribute("itemList", itemList);
        request.getRequestDispatcher("/customer/CustomerHomeFrm2.jsp").forward(request, response);
    }
}