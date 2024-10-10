package com.cl.sampleservletjspproject.model;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginBean implements Serializable {

	private static final long serialVersionUID = 2876495345168481829L;

	private String username;
	private String password;
	private String role;

}
