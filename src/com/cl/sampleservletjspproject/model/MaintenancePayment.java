package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class MaintenancePayment implements Serializable {

	private static final long serialVersionUID = -364533043879418838L;

	private String paymentId;
	private String username;
	private Date paymentDate;
	private String paymentAmount;
	private boolean isPaid;
	private java.sql.Date paymentMonth;

}
