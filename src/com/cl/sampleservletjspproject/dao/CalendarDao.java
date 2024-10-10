package com.cl.sampleservletjspproject.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cl.sampleservletjspproject.model.Calendar;
import com.cl.sampleservletjspproject.util.JDBCUtils;

public class CalendarDao {

	private static Connection conn;
	private static PreparedStatement pstmt;

	public List<Calendar> getAllEvents() {
		String GET_ALL_EVENTS = "SELECT * FROM calendarevents";
		List<Calendar> events = new ArrayList<>();

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(GET_ALL_EVENTS);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String date = rs.getString("event_date");
				String name = rs.getString("event_name");
				events.add(new Calendar(date, name));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return events;
	}

	public int addEvent(Calendar event) {
		String INSERT_EVENT = "INSERT INTO calendarevents (event_date, event_name) VALUES (?, ?)";

		int result = 0;

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(INSERT_EVENT);
			pstmt.setString(1, event.getDate());
			pstmt.setString(2, event.getEventName());
			System.out.println(pstmt);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int removeEventByDate(String date) {
		String DELETE_EVENT = "DELETE FROM calendarevents WHERE event_date = ?";

		int result = 0;

		try {
			conn = JDBCUtils.getConnection();
			pstmt = conn.prepareStatement(DELETE_EVENT);
			pstmt.setString(1, date);
			System.out.println(pstmt);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}
