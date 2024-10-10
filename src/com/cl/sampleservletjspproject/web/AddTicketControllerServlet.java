package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cl.sampleservletjspproject.dao.TicketDao;
import com.cl.sampleservletjspproject.model.Ticket;

@WebServlet("/addTicket")
public class AddTicketControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private TicketDao ticketDao;

	public void init() {
		ticketDao = new TicketDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("/addTicket.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		insert(request, response);
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String category = request.getParameter("category");

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String flatNumber = (String) session.getAttribute("flatNumber");

		Ticket ticket = new Ticket();
		ticket.setTitle(title);
		ticket.setDescription(description);
		ticket.setCategory(category);
		ticket.setRaisedBy(username);
		ticket.setRaisedOn(Timestamp.valueOf(LocalDateTime.now()));
		ticket.setFlatNumber(flatNumber);

		try {
			int result = ticketDao.insertTicket(ticket);
			if (result == 1) {
				request.setAttribute("message", "Ticket Submitted Successfully!");
			} else {
				request.setAttribute("message", "Error submitting the ticket. Please try again.");
			}
		} catch (Exception e) {
			request.setAttribute("message", "An error occured " + e.getMessage());
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("ticket/submitTicket.jsp");
		dispatcher.forward(request, response);

	}
}
