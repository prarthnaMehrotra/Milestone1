package com.cl.sampleservletjspproject.model;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Wallet implements Serializable {
	
	private static final long serialVersionUID = 1969920018654529731L;
	
	private String walletId;
	private String username;
	private String walletBalance;

}
