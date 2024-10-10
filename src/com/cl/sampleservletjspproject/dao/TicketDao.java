package com.cl.sampleservletjspproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.cl.sampleservletjspproject.model.Ticket;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class TicketDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public int insertTicket(Ticket ticket) throws SQLException {
		String sql = "INSERT INTO tickets (ticket_id, ticket_title, ticket_description, "
				+ "ticket_category, ticket_status, ticket_raised_by, ticket_raised_on, ticket_resolved_on, flat_number) "
				+ "VALUES (?, ?, ?, ?, 'Open', ?, ?, ?, ?)";

		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, generateUserId());
			pstmt.setString(2, ticket.getTitle());
			pstmt.setString(3, ticket.getDescription());
			pstmt.setString(4, ticket.getCategory());
			pstmt.setString(5, ticket.getRaisedBy());
			pstmt.setTimestamp(6, ticket.getRaisedOn());
			pstmt.setTimestamp(7, null);
			pstmt.setString(8, ticket.getFlatNumber());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			System.err.println("SQL exception occurred during ticket insertion: " + se.getMessage());
			se.printStackTrace();
		}
		return result;
	}

	public static String generateUserId() {
		String uuid = UUID.randomUUID().toString();
		String uniqueId = "TI" + uuid.substring(0, 8);
		return uniqueId;
	}

	public List<Ticket> getAllTickets() {
		List<Ticket> tickets = new ArrayList<>();
		String sql = "SELECT ticket_id, ticket_title, ticket_description, ticket_raised_by, "
				+ "ticket_raised_on, ticket_status, flat_number FROM tickets";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			ResultSet resultSet = pstmt.executeQuery();
			while (resultSet.next()) {
				Ticket ticket = new Ticket();
				ticket.setId(resultSet.getString("ticket_id"));
				ticket.setTitle(resultSet.getString("ticket_title"));
				ticket.setDescription(resultSet.getString("ticket_description"));
				ticket.setRaisedBy(resultSet.getString("ticket_raised_by"));
				ticket.setRaisedOn(resultSet.getTimestamp("ticket_raised_on"));
				ticket.setStatus(resultSet.getString("ticket_status"));
				ticket.setFlatNumber(resultSet.getString("flat_number"));
				tickets.add(ticket);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tickets;
	}
	
	public List<Ticket> getTicketsByUsername(String username) {
		List<Ticket> tickets = new ArrayList<>();
		String sql = "SELECT ticket_id, ticket_title, ticket_description, ticket_raised_by, "
				+ "ticket_raised_on, ticket_status, flat_number FROM tickets WHERE ticket_raised_by = ?;";
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			
			ResultSet resultSet = pstmt.executeQuery();
			
			while (resultSet.next()) {
				Ticket ticket = new Ticket();
				ticket.setId(resultSet.getString("ticket_id"));
				ticket.setTitle(resultSet.getString("ticket_title"));
				ticket.setDescription(resultSet.getString("ticket_description"));
				ticket.setRaisedBy(resultSet.getString("ticket_raised_by"));
				ticket.setRaisedOn(resultSet.getTimestamp("ticket_raised_on"));
				ticket.setStatus(resultSet.getString("ticket_status"));
				ticket.setFlatNumber(resultSet.getString("flat_number"));
				tickets.add(ticket);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tickets;
	}

	public int updateTicketStatus(String ticketId, String newStatus) {
		String sql = "UPDATE tickets SET ticket_status = ? WHERE ticket_id = ?;";
		
		int result = 0;
		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newStatus);
			pstmt.setString(2, ticketId);
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}
