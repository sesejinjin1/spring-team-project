package com.example.furnature.model;

import lombok.Data;

@Data
public class Event {
	private String auctionNo;
	private String auctionTitle;
	private String auctionPrice;
	private String auctionPriceCurrent;
	private String userId;
	private String startDay;
	private String endDay;
	private String auctionCdatetime;
	private String auctionUdatetime;
	private String auctionContents;
	private String auctionContentsImgName;
	private String auctionContentsImgPath;
	private String auctionStatus;
	
	private String auctionImgName;
	private String auctionImgOrgName;
	private String auctionImgPath;
	private String auctionImgSize;
	
	private String eventRoul;
	
	public String getAuctionNo() {
		return auctionNo;
	}
}
