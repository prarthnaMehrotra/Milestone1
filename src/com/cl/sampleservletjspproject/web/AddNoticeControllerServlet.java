package com.cl.sampleservletjspproject.web;

import com.cl.sampleservletjspproject.dao.NoticeDao;
import com.cl.sampleservletjspproject.model.Notice;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/addNotice")
public class AddNoticeControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 2214196627293226098L;
	
	private NoticeDao noticeDao;

	public void init() {
		noticeDao = new NoticeDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("/addNotice.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		insert(request, response);
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setContent(content);
		notice.setCategory(category);
		notice.setPostedBy(username);
		notice.setPostedOn(Timestamp.valueOf(LocalDateTime.now()));
		

		try {
			int result = noticeDao.addNotice(notice);
			System.out.println(result);
			if (result == 1) {
				request.setAttribute("message", "Notice Added Successfully!");
			} else {
				request.setAttribute("message", "Error submitting the notice. Please try again.");
			}
		} catch (Exception e) {
			request.setAttribute("message", "An error occured " + e.getMessage());
			e.printStackTrace();
		}
		
		List<Notice> notices = noticeDao.getAllNotice();
		System.out.println(notices);
		request.setAttribute("notices", notices);

		RequestDispatcher dispatcher = request.getRequestDispatcher("notice/viewAndUpdateNotice.jsp");
		dispatcher.forward(request, response);
	}
}
