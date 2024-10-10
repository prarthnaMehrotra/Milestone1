package com.cl.sampleservletjspproject.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cl.sampleservletjspproject.dao.MaintenancePaymentDao;
import com.cl.sampleservletjspproject.dao.WalletDao;
import com.cl.sampleservletjspproject.model.MaintenancePayment;
import com.cl.sampleservletjspproject.model.Wallet;

import java.io.IOException;

@WebServlet("/payMaintenance")
public class PayMaintenanceControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MaintenancePaymentDao paymentDao;
	private WalletDao walletDao;

	public void init() {
		paymentDao = new MaintenancePaymentDao();
		walletDao = new WalletDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		String maintenanceAmount = "3000";

		MaintenancePayment payment = paymentDao.getPaymentByUsername(username).get(0);
		Wallet wallet = walletDao.getWalletByUsername(username).get(0);

		double walletBalance = Double.parseDouble(wallet.getWalletBalance());
		double amount = Double.parseDouble(maintenanceAmount);

		boolean isPaid = payment.isPaid();

		if (isPaid) {
			response.sendRedirect("payment/payment.jsp?paymentUpdate=alreadyPaid");
			return;
		}

		if (walletBalance < amount) {
			response.sendRedirect("payment/payment.jsp?paymentUpdate=insufficientFunds");
			return;
		}
		
		double newBalance = walletBalance - amount;
		wallet.setWalletBalance(String.valueOf(newBalance));
		payment.setPaid(true);

		int result1 = paymentDao.markPaymentAsPaid(payment);
		int result2 = walletDao.updateWalletBalance(wallet);

		if (result1 > 0 && result2 > 0) {
			session.setAttribute("walletBalance", wallet.getWalletBalance());
			session.setAttribute("isPaid", true);
			response.sendRedirect("payment/payment.jsp?paymentUpdate=success");
		} else {
			response.sendRedirect("payment/payment.jsp?paymentUpdate=failure");
		}
	}
}
