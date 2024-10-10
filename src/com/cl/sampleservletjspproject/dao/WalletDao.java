package com.cl.sampleservletjspproject.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.cl.sampleservletjspproject.model.Wallet;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class WalletDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public List<Wallet> getWalletByUsername(String username) {
		List<Wallet> wallets = new ArrayList<>();
		String GET_WALLET_BY_USERNAME = "SELECT * FROM wallet WHERE user_username = ?";

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(GET_WALLET_BY_USERNAME);
			pstmt.setString(1, username);

			ResultSet resultSet = pstmt.executeQuery();

			while (resultSet.next()) {
				Wallet wallet = new Wallet();
				wallet.setUsername(resultSet.getString("user_username"));
				wallet.setWalletId(resultSet.getString("wallet_id"));
				wallet.setWalletBalance(resultSet.getString("wallet_balance"));
				wallets.add(wallet);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wallets;
	}

	public int updateWalletBalance(Wallet wallet) {
		String UPDATE_WALLET_BALANCE = "UPDATE wallet SET wallet_balance = ? WHERE user_username = ?";

		int result = 0;

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(UPDATE_WALLET_BALANCE);
			pstmt.setString(1, wallet.getWalletBalance());
			pstmt.setString(2, wallet.getUsername());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int createWallet(Wallet wallet) {
		String INSERT_WALLET = "INSERT INTO wallet (wallet_id, user_username, wallet_balance) VALUES (?, ?, ?)";

		int result = 0;

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(INSERT_WALLET);
			pstmt.setString(1, generateWalletId());
			pstmt.setString(2, wallet.getUsername());
			pstmt.setString(3, wallet.getWalletBalance());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String generateWalletId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "WA" + uuid.substring(0, 8);
		return uniqueId;
	}
}
