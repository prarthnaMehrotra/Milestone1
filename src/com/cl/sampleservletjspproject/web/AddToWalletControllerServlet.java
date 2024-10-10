package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cl.sampleservletjspproject.dao.WalletDao;
import com.cl.sampleservletjspproject.model.Wallet;

@WebServlet("/addToWallet")
public class AddToWalletControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private WalletDao walletDao = new WalletDao();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String balanceToAdd = request.getParameter("walletBalance");
		System.out.println(username + " " + balanceToAdd);

		if (balanceToAdd != null && !balanceToAdd.isEmpty()) {
			System.out.println("balance to add is not null");
			// Fetch the current wallet
			Wallet wallet = walletDao.getWalletByUsername(username).get(0);
			double newBalance = Double.parseDouble(wallet.getWalletBalance()) + Double.parseDouble(balanceToAdd);
			wallet.setWalletBalance(String.valueOf(newBalance));
			System.out.println(wallet);

			int result = walletDao.updateWalletBalance(wallet);

			if (result > 0) {
				System.out.println("money added successfully!");
				session.setAttribute("walletBalance", wallet.getWalletBalance());
				response.sendRedirect("payment/payment.jsp?walletUpdate=success");
			} else {
				response.sendRedirect("payment/payment.jsp?walletUpdate=failure");
			}
		}
	}
}
