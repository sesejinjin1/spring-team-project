package com.example.furnature.model;

import lombok.Data;

@Data
public class User {
	private String userId;
	private String userPwd;
	private String userZipCode;
	private String userAddr;
	private String userPhone;
	private String userEmail;
	private String userName;
	private String userBirth;
	private String userAuth;
	private String eventRoul;
	private String eventCheck;
	
	public String getUserId() {
		return userId;
	}
	public String getUserAuth() {
		return userAuth;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public String getUserPwd() {
		return userPwd;
	}
}
