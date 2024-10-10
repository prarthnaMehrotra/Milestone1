package com.cl.sampleservletjspproject.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.MaintenancePaymentDao;
import com.cl.sampleservletjspproject.dao.RegisterDao;
import com.cl.sampleservletjspproject.dao.WalletDao;
import com.cl.sampleservletjspproject.model.MaintenancePayment;
import com.cl.sampleservletjspproject.model.User;
import com.cl.sampleservletjspproject.model.Wallet;

@WebServlet("/register")
public class UserControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RegisterDao registerDao;
	private WalletDao walletDao;
	private MaintenancePaymentDao paymentDao;

	public void init() {
		registerDao = new RegisterDao();
		walletDao = new WalletDao();
		paymentDao = new MaintenancePaymentDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		register(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("register/register.jsp");
	}

	private void register(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = "Resident";
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String flatNumber = request.getParameter("flatNumber");

		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setRole(role);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setFlatNumber(flatNumber);

		try {
			int result = registerDao.registerUser(user);
			if (result == 1) {
				request.setAttribute("NOTIFICATION", "User Registered Successfully!");
			} else {
				request.setAttribute("NOTIFICATION", "Error registering user. Please try again.");
			}
		} catch (Exception e) {
			request.setAttribute("NOTIFICATION", "An error occurred: " + e.getMessage());
			e.printStackTrace();
		}

		Wallet wallet = new Wallet();
		wallet.setUsername(username);
		wallet.setWalletBalance("0"); // Initial balance

		walletDao.createWallet(wallet);
		
		MaintenancePayment payment = new MaintenancePayment();
		payment.setUsername(username);
		payment.setPaid(false);
		payment.setPaymentAmount("3000");
		
		paymentDao.createMaintenancePayment(payment);

		RequestDispatcher dispatcher = request.getRequestDispatcher("login/login.jsp");
		dispatcher.forward(request, response);
	}
}