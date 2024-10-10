package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.TicketDao;

@WebServlet("/updateTicketStatus")
public class UpdateTicketStatusControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TicketDao ticketDao;

	@Override
	public void init() {
		ticketDao = new TicketDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ticketId = request.getParameter("ticketId");
		String newStatus = request.getParameter("newStatus");

		ticketDao.updateTicketStatus(ticketId, newStatus);

		response.sendRedirect(request.getContextPath() + "/adminDashboard");
	}
}
