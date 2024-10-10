package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.NoticeDao;
import com.cl.sampleservletjspproject.model.Notice;

@WebServlet("/viewNotice")
public class ViewNoticeControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private NoticeDao noticeDao;

	@Override
	public void init() {
		noticeDao = new NoticeDao();
		System.out.println("initialized");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("dashboard/residentDashboard.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("hi");
		List<Notice> notices = noticeDao.getAllNotice();
		System.out.println(notices);
		request.setAttribute("notices", notices);
		RequestDispatcher dispatcher = request.getRequestDispatcher("notice/viewNotice.jsp");
		dispatcher.forward(request, response);
	}
}
