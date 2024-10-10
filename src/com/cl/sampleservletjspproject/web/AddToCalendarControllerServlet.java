package com.cl.sampleservletjspproject.web;

import com.cl.sampleservletjspproject.dao.CalendarDao;
import com.cl.sampleservletjspproject.model.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/calendar")
public class AddToCalendarControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 4821887231102798870L;
	private CalendarDao calendarDao;

	@Override
	public void init() {
		calendarDao = new CalendarDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/dashboard/adminDashboard.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		addEvent(request, response);

	}

	private void addEvent(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		String date = request.getParameter("date");
		String eventName = request.getParameter("eventName");

		System.out.println("Action: " + action);
		System.out.println("Date: " + date);
		System.out.println("Event Name: " + eventName);

		if ("save".equalsIgnoreCase(action)) {
			if (eventName != null && !eventName.isEmpty()) {
				Calendar event = new Calendar(date, eventName);
				calendarDao.addEvent(event);
				System.out.println("Event inserted");
			} else {
				System.out.println("Event name is empty");
			}
		} else if ("cancel".equalsIgnoreCase(action)) {
			if (date != null && !date.isEmpty()) {
				calendarDao.removeEventByDate(date);
				System.out.println("Event removed");
			} else {
				System.out.println("Date is empty");
			}
		} else {
			System.out.println("Unknown action");
		}

		response.sendRedirect("dashboard/adminDashboard.jsp");

	}

}
