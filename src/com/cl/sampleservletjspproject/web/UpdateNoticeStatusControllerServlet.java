package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.sampleservletjspproject.dao.NoticeDao;

@WebServlet("/updateNoticeStatus")
public class UpdateNoticeStatusControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private NoticeDao noticeDao;

	@Override
	public void init() {
		noticeDao = new NoticeDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String noticeId = request.getParameter("noticeId");
		String newStatus = request.getParameter("newStatus");

		int result = noticeDao.updateNoticeStatus(noticeId, newStatus);

		if (result > 0) {
			System.out.println("status changed successfully!");
			response.sendRedirect("dashboard/adminDashboard.jsp");
		} else {
			response.sendRedirect("dashboard/adminDashboard.jsp");
		}
	}
}