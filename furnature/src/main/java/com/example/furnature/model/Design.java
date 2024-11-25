package com.example.furnature.model;

import lombok.Data;

@Data
public class Design {
	private String designNo;
	private String userId;
	private String designTitle;
	private String designContents;
	private String designImgPath;
	private String designImgName;
	private String designChoice;
	private String designCdateTime;
	private String count;
	private String likeNo;
}
