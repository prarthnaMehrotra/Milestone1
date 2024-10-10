package com.cl.sampleservletjspproject.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtils {

	private static String jdbcURL = "jdbc:postgresql://localhost:5432/APARTMENTNOTICEBOARD";
	private static String jdbcUsername = "postgres";
	private static String jdbcPassword = "crimson@123";

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException se) {
			printSQLException(se);
		} catch (ClassNotFoundException ce) {
			System.err.println("PostgreSQL JDBC Driver not found. Include it in your library path.");
			ce.printStackTrace();
		}
		return conn;
	}

	public static void printSQLException(SQLException se) {
		for (Throwable te : se) {
			if (te instanceof SQLException) {
				te.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) te).getSQLState());
				System.err.println("Error Code: " + ((SQLException) te).getErrorCode());
				System.err.println("Message: " + te.getMessage());
				Throwable cause = te.getCause();
				while (cause != null) {
					System.err.println("Cause: " + cause);
					cause = cause.getCause();
				}
			}
		}
	}
}
