package com.cl.sampleservletjspproject.model;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Calendar implements Serializable {

	private static final long serialVersionUID = 4866048766357377188L;

	private String date;
	private String eventName;

}
