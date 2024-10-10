package com.cl.sampleservletjspproject.web;

import com.cl.sampleservletjspproject.dao.NoticeDao;
import com.cl.sampleservletjspproject.model.Notice;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewAndUpdateNotice")
public class ViewAndUpdateNoticeControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 2214196627293226098L;
	private NoticeDao noticeDao;

	public void init() {
		noticeDao = new NoticeDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("dashboard/adminDashboard.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		operations(request, response);
	}

	private void operations(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Notice> notices = noticeDao.getAllNotice();
		System.out.println(notices);
		request.setAttribute("notices", notices);

		RequestDispatcher dispatcher = request.getRequestDispatcher("notice/viewAndUpdateNotice.jsp");
		dispatcher.forward(request, response);
	}
}
