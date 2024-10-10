package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Comment implements Serializable {

	private static final long serialVersionUID = 6726505216194769942L;

	private String id;
	private String username;
	private String noticeId;
	private String content;
	private Timestamp postedOn;

}
