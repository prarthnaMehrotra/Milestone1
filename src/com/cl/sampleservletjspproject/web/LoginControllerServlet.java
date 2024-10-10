package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cl.sampleservletjspproject.dao.CalendarDao;
import com.cl.sampleservletjspproject.dao.LoginDao;
import com.cl.sampleservletjspproject.dao.MaintenancePaymentDao;
import com.cl.sampleservletjspproject.dao.WalletDao;
import com.cl.sampleservletjspproject.model.Calendar;
import com.cl.sampleservletjspproject.model.LoginBean;
import com.cl.sampleservletjspproject.model.MaintenancePayment;
import com.cl.sampleservletjspproject.model.User;
import com.cl.sampleservletjspproject.model.Wallet;

@WebServlet("/login")
public class LoginControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginDao loginDao;
	private CalendarDao calendarDao;
	private WalletDao walletDao;
	private MaintenancePaymentDao paymentDao;

	public void init() {
		loginDao = new LoginDao();
		System.out.println("initialized");

		calendarDao = new CalendarDao();
		System.out.println("going to calendar");

		walletDao = new WalletDao();
		System.out.println("wallet created");

		paymentDao = new MaintenancePaymentDao();
		System.out.println("payment created");

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("login/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		authenticate(request, response);
	}

	private void authenticate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		LoginBean loginBean = new LoginBean();
		loginBean.setUsername(username);
		loginBean.setPassword(password);

		try {
			User user = loginDao.validate(loginBean);
			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("username", user.getUsername());
				session.setAttribute("role", user.getRole());
				session.setAttribute("flatNumber", user.getFlatNumber());

				if ("Admin".equals(user.getRole())) {
					response.sendRedirect("dashboard/adminDashboard.jsp");

				} else if ("Resident".equals(user.getRole())) {
					displayResident(request, response, session);
				}
			} else {
				request.setAttribute("errorMessage", "Invalid credentials!!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("login/login.jsp");
				dispatcher.forward(request, response);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "An error occurred. Please try again.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("login/login.jsp");
			dispatcher.forward(request, response);
		}
	}

	private void displayResident(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws ServletException, IOException, ClassNotFoundException {

		String username = request.getParameter("username");
		System.out.println("hi");
		List<Calendar> events = calendarDao.getAllEvents();
		System.out.println(events);
		session.setAttribute("events", events);

		List<Wallet> wallets = walletDao.getWalletByUsername(username);
		if (wallets.isEmpty()) {
			// Create wallet if it doesn't exist
			Wallet wallet = new Wallet();
			wallet.setUsername(username);
			wallet.setWalletBalance("0"); // Initial balance

			walletDao.createWallet(wallet);
			session.setAttribute("walletBalance", wallet.getWalletBalance());
		} else {
			// Assuming there's only one wallet per user
			Wallet wallet = wallets.get(0);
			session.setAttribute("walletBalance", wallet.getWalletBalance());
		}

		List<MaintenancePayment> payments = paymentDao.getPaymentByUsername(username);
		if (payments.isEmpty()) {
			// Create payment if it doesn't exist
			MaintenancePayment payment = new MaintenancePayment();
			payment.setUsername(username);
			payment.setPaid(false);
			payment.setPaymentAmount("3000");

			paymentDao.createMaintenancePayment(payment);
			session.setAttribute("isPaid", payment.isPaid());
		} else {
			// Assuming there's only one payment per user
			MaintenancePayment payment = payments.get(0);
			session.setAttribute("isPaid", payment.isPaid());
		}

		response.sendRedirect("dashboard/residentDashboard.jsp");
	}

}
