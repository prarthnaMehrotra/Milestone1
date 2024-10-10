package com.cl.sampleservletjspproject.dao;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.Date;

import com.cl.sampleservletjspproject.model.MaintenancePayment;
import com.cl.sampleservletjspproject.model.Wallet;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class MaintenancePaymentDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public int subtractMoneyFromWallet(Wallet wallet) {
		String SUBTRACT_MONEY_FROM_WALLET = "UPDATE wallet SET wallet_balance = ? WHERE user_username = ?";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(SUBTRACT_MONEY_FROM_WALLET);
			pstmt.setString(1, wallet.getWalletBalance());
			pstmt.setString(2, wallet.getUsername());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int markPaymentAsPaid(MaintenancePayment payment) {
		String MARK_PAYMENT_AS_PAID = "UPDATE maintenance_payments SET is_paid = TRUE, payment_date = ? WHERE user_username = ? AND payment_month = ?";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(MARK_PAYMENT_AS_PAID);
			pstmt.setDate(1, new java.sql.Date(new Date().getTime()));
			pstmt.setString(2, payment.getUsername());
			pstmt.setDate(3, payment.getPaymentMonth());
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<MaintenancePayment> getPaymentByUsername(String username) {
		List<MaintenancePayment> payments = new ArrayList<>();
		String GET_PAYMENT_BY_USERNAME = "SELECT * FROM maintenance_payments WHERE user_username = ?";

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(GET_PAYMENT_BY_USERNAME);
			pstmt.setString(1, username);

			ResultSet resultSet = pstmt.executeQuery();

			while (resultSet.next()) {
				MaintenancePayment payment = new MaintenancePayment();
				payment.setPaymentId(resultSet.getString("payment_id"));
				payment.setUsername(resultSet.getString("user_username"));
				payment.setPaymentDate(resultSet.getDate("payment_date"));
				payment.setPaymentAmount(resultSet.getString("payment_amount"));
				payment.setPaid(resultSet.getBoolean("is_paid"));
				payment.setPaymentMonth(resultSet.getDate("payment_month"));
				payments.add(payment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return payments;
	}
	
		public List<MaintenancePayment> getAllPayment() {
			List<MaintenancePayment> payments = new ArrayList<>();
			String GET_PAYMENT_BY_USERNAME = "SELECT * FROM maintenance_payments;";

			try {
				conn = JDBCUtils.getConnection();
				pstmt = conn.prepareStatement(GET_PAYMENT_BY_USERNAME);
				ResultSet resultSet = pstmt.executeQuery();
				while (resultSet.next()) {
					MaintenancePayment payment = new MaintenancePayment();
					payment.setPaymentId(resultSet.getString("payment_id"));
					payment.setUsername(resultSet.getString("user_username"));
					payment.setPaymentDate(resultSet.getDate("payment_date"));
					payment.setPaymentAmount(resultSet.getString("payment_amount"));
					payment.setPaid(resultSet.getBoolean("is_paid"));
					payment.setPaymentMonth(resultSet.getDate("payment_month"));
					payments.add(payment);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return payments;
		}

	public int createMaintenancePayment(MaintenancePayment payment) {
		String INSERT_PAYMENT = "INSERT INTO maintenance_payments (payment_id, user_username, payment_amount,"
				+ "is_paid, payment_month) VALUES (?, ?, ?, ?, ?)";

		int result = 0;

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(INSERT_PAYMENT);

			Date currentDate = new Date();

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-01");
			String formattedDate = dateFormat.format(currentDate);

			java.sql.Date sqlPaymentMonth = new java.sql.Date(dateFormat.parse(formattedDate).getTime());

			pstmt.setString(1, generatePaymentId());
			pstmt.setString(2, payment.getUsername());
			pstmt.setString(3, payment.getPaymentAmount());
			pstmt.setBoolean(4, payment.isPaid());
			pstmt.setDate(5, sqlPaymentMonth);
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String generatePaymentId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "PI" + uuid.substring(0, 8);
		return uniqueId;
	}
}
