package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.TicketDao;
import com.cl.sampleservletjspproject.model.Ticket;

@WebServlet("/viewTicketStatus")
public class ViewTicketStatusControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TicketDao ticketDao;

	@Override
	public void init() {
		ticketDao = new TicketDao();
		System.out.println("initialized");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("dashboard/residentDashboard.jsp");
		System.out.println("hello");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("hi");
		List<Ticket> tickets = ticketDao.getAllTickets();
		System.out.println(tickets);
		request.setAttribute("tickets", tickets);
		RequestDispatcher dispatcher = request.getRequestDispatcher("ticket/viewTicketStatus.jsp");
		dispatcher.forward(request, response);
	}
}
