package com.example.furnature.model;

import lombok.Data;

@Data
public class Qna {
	private String qnaNo;
	private String userId;
	private String qnaTitle;
	private String qnaContents;
	private String qnaCategory;
	private String qnaCount;
	private String cdatetime;
	private String udatetime;
	

	private String pwd;
	private String userName;
	private String email;
	private String phone;
	private String gender;
	private String status;
	private String addr;
	
	private String commentNo;
	private String commentContents;
	
	private String qnaFilePath;
	
	private String commentCount;

}
