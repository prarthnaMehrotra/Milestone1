package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User implements Serializable {

	private static final long serialVersionUID = 7504137024669358637L;

	private String id;
	private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String role;
	private String flatNumber;

}
