package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Notice implements Serializable {

	private static final long serialVersionUID = 6174801117222736372L;

	private String id;
	private String title;
	private String content;
	private String category;
	private String postedBy;
	private Timestamp postedOn;
	private String status;

}
