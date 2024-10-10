package com.cl.sampleservletjspproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cl.sampleservletjspproject.model.LoginBean;
import com.cl.sampleservletjspproject.model.User;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class LoginDao {

	private static Connection conn;
	private static PreparedStatement pstmt;
	
	public User validate(LoginBean loginBean) throws ClassNotFoundException {
		User user = null;
		String sql_query = "SELECT * FROM users WHERE user_username = ? AND user_password = ?;";

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql_query);
			pstmt.setString(1, loginBean.getUsername());
			pstmt.setString(2, loginBean.getPassword());
			System.out.println(pstmt);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setId(rs.getString("user_id"));
				user.setUsername(rs.getString("user_username"));
				user.setPassword(rs.getString("user_password"));
				user.setRole(rs.getString("user_role"));
				user.setFlatNumber(rs.getString("user_flat_number"));
			}

		} catch (SQLException e) {
			JDBCUtils.printSQLException(e);
		}
		return user;
	}
}
