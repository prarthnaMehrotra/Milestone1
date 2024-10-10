package com.cl.sampleservletjspproject.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class VisitorNotification {

	private int id;
	private String content;
	private int madeBy;
	private int residentId;
	private Timestamp notificationDate;

}
