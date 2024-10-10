package com.cl.sampleservletjspproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.cl.sampleservletjspproject.model.Comment;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class CommentDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public int addComment(Comment comment) {
		String sql = "INSERT INTO noticecomments (comment_id, comment_made_by_name,"
				+ " comment_made_on_id, comment_content, comment_posted_on) VALUES (?, ?, ?, ?, ?)";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, generateCommentId());
			pstmt.setString(2, comment.getUsername());
			pstmt.setString(3, comment.getNoticeId());
			pstmt.setString(4, comment.getContent());
			pstmt.setTimestamp(5, comment.getPostedOn());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			System.err.println("SQL exception occurred during comment insertion: " + se.getMessage());
			se.printStackTrace();
		}
		return result;
	}

	public static String generateCommentId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "CO" + uuid.substring(0, 8);
		return uniqueId;
	}

	public List<Comment> getAllComment(String noticeId) {
		List<Comment> comments = new ArrayList<>();
		String sql = "SELECT * FROM noticecomments WHERE comment_made_on_id = ?";

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, noticeId);
			ResultSet resultSet = pstmt.executeQuery();

			while (resultSet.next()) {
				Comment comment = new Comment();
				comment.setUsername(resultSet.getString("comment_made_by_name"));
				comment.setNoticeId(resultSet.getString("comment_made_on_id"));
				comment.setContent(resultSet.getString("comment_content"));
				comment.setPostedOn(resultSet.getTimestamp("comment_posted_on"));
				comments.add(comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return comments;
	}
}
