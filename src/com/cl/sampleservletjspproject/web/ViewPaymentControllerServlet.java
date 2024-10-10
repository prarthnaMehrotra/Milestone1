package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.MaintenancePaymentDao;
import com.cl.sampleservletjspproject.model.MaintenancePayment;

@WebServlet("/viewPayments")
public class ViewPaymentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MaintenancePaymentDao paymentDao;

	@Override
	public void init() {
		paymentDao = new MaintenancePaymentDao();
		System.out.println("initialized");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("dashboard/adminDashboard.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("hi");
		List<MaintenancePayment> payments = paymentDao.getAllPayment();
		System.out.println(payments);
		request.setAttribute("payments", payments);
		RequestDispatcher dispatcher = request.getRequestDispatcher("payment/viewPayment.jsp");
		dispatcher.forward(request, response);
	}
}
