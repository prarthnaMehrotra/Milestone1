package com.cl.sampleservletjspproject.dao;

import com.cl.sampleservletjspproject.model.Notice;
import com.cl.sampleservletjspproject.util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class NoticeDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public int addNotice(Notice notice) {
		String sql = "INSERT INTO notices (notice_id, notice_title, notice_content, notice_category, "
				+ "notice_posted_by, notice_posted_on, notice_status) VALUES (?, ?, ?, ?, ?, ?, 'Open')";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, generateUserId());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			pstmt.setString(4, notice.getCategory());
			pstmt.setString(5, notice.getPostedBy());
			pstmt.setTimestamp(6, notice.getPostedOn());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			System.err.println("SQL exception occurred during notice insertion: " + se.getMessage());
			se.printStackTrace();
		}
		return result;
	}

	public static String generateUserId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "NT" + uuid.substring(0, 8);
		return uniqueId;
	}

	public List<Notice> getAllNotice() {
		List<Notice> notices = new ArrayList<>();
		String sql = "SELECT notice_id, notice_title, notice_content, notice_category, notice_posted_by, "
				+ "notice_posted_on, notice_status FROM notices";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			ResultSet resultSet = pstmt.executeQuery();
			while (resultSet.next()) {
				Notice notice = new Notice();
				notice.setId(resultSet.getString("notice_id"));
				notice.setTitle(resultSet.getString("notice_title"));
				notice.setContent(resultSet.getString("notice_content"));
				notice.setCategory(resultSet.getString("notice_category"));
				notice.setPostedBy(resultSet.getString("notice_posted_by"));
				notice.setPostedOn(resultSet.getTimestamp("notice_posted_on"));
				notice.setStatus(resultSet.getString("notice_status"));
				notices.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return notices;
	}
	
	public int updateNoticeStatus(String noticeId, String newStatus) {
		String sql = "UPDATE notices SET notice_status = ? WHERE notice_id = ?";
		
		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newStatus);
			pstmt.setString(2, noticeId);
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

}
