package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Ticket implements Serializable {

	private static final long serialVersionUID = 3574581662440707496L;

	private String id;
	private String title;
	private String description;
	private String category;
	private String status;
	private String raisedBy;
	private Timestamp raisedOn;
	private Timestamp resolvedOn;
	private String flatNumber;

}
