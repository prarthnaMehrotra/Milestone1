package com.cl.sampleservletjspproject.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cl.sampleservletjspproject.dao.CommentDao;
import com.cl.sampleservletjspproject.model.Comment;

@WebServlet("/addComment")
public class AddCommentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CommentDao commentDao;

	public void init() {
		commentDao = new CommentDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.sendRedirect("/viewNotice.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		operations(request, response);
	}

	protected void operations(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String noticeId = request.getParameter("noticeId");
		String content = request.getParameter("comment");

		Comment comment = new Comment();
		comment.setUsername(username);
		comment.setNoticeId(noticeId);
		comment.setContent(content);
		comment.setPostedOn(Timestamp.valueOf(LocalDateTime.now()));

		try {
			int result = commentDao.addComment(comment);
			System.out.println(result);
			if (result == 1) {
				request.setAttribute("message", "Comment Added Successfully!");
			} else {
				request.setAttribute("message", "Error submitting the comment. Please try again.");
			}
		} catch (Exception e) {
			request.setAttribute("message", "An error occured " + e.getMessage());
			e.printStackTrace();
		}

		System.out.println("hi");

		List<Comment> comments = commentDao.getAllComment(noticeId);
		System.out.println(comments);
		request.setAttribute("comments", comments);
		request.setAttribute("noticeId", noticeId);
		System.out.println(comments);

		RequestDispatcher dispatcher = request.getRequestDispatcher("notice/viewComment.jsp");
		dispatcher.forward(request, response);
	}

}
