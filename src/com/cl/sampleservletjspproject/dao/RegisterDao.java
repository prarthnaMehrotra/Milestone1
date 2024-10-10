package com.cl.sampleservletjspproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import com.cl.sampleservletjspproject.model.User;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class RegisterDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public int registerUser(User user) throws ClassNotFoundException {
		String INSERT_USERS_SQL = "INSERT INTO users"
				+ "  (user_id, user_username, user_password, user_first_name, user_last_name, user_role, "
				+ "user_flat_number) VALUES " + " (?, ?, ?, ?, ?, ?, ?);";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(INSERT_USERS_SQL);
			pstmt.setString(1, generateUserId());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getFirstName());
			pstmt.setString(5, user.getLastName());
			pstmt.setString(6, user.getRole());
			pstmt.setString(7, user.getFlatNumber());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("SQL exception occurred during user registration: " + e.getMessage());
			e.printStackTrace(); 
		}
		return result;
	}

	public static String generateUserId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "UA" + uuid.substring(0, 8);
		return uniqueId;
	}

}
