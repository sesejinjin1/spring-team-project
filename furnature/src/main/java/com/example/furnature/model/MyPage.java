package com.example.furnature.model;

import lombok.Data;

@Data
public class MyPage {
	// 내정보
	private String userId;
	private String userAddr;
	private String userPhone;
	private String userEmail;
	private String userName;
	private String userBirth;
	private String userAuth;
	private String eventRoul;
	private String eventCheck;
	private String userZipCode;
	private String mileageTotal;
	
	// 원데이클래스
	private String classNo;
	private String joinDate;
	private String count;
	private String className;
	private String price;
	private String numberLimit;
	private String classDate;
	private String startDay;
	private String endDay;
	private String payDay;
	private String payId;
	private String currentNumber;
	private String result;
	private String description;
	private String joinDay;
	private String payStatus;
	private String fileNo;
	private String filePath;
	private String thumbName;
	private String thumbNo;
	private String thumbSize;
	private String thumbPath;
	private String thumb;
	
	
	// 이벤트 - 경매
	private String auctionBiddingNo;
	private String auctionNo;
	private String auctionBiddingPrice;
	private String auctionBiddingDate;
	private String myBidding;
	private String auctionTitle;
	private String auctionPrice;
	private String auctionPriceCurrent;
	private String auctionStatus;
	private String auctionImgPath;
	private String userInfo;
	private String paymentStatus;
	
	// 배송
	private String payNo;
	private String orderNo;
	private String orderId;
	private String productNo;
	private String orderPrice;
	private String orderSize;
	private String orderCount;
	private String productPrice;
	private String oderDate;
	private String orderCate;
	private String deliveryCate;
	private String cateNo;
	private String cateName;
	private String productThumbnail;
	private String productName;
	
	// 마일리지
	private String mileageNo;
	private String mileageName;
	private String mileagePrice;
	private String mileageStatus;
	
	//장바구니
	private String cartNo;
	private String productSize;
	private String cdatetime;
	private String time;
	
	private String paymentAmount;
	private String paymentPayDate;
	
	public String getAuctionBiddingPrice() {
		return auctionBiddingPrice;
	}

	public String getAuctionPrice() {
		return auctionPrice;
	}	
	
	public String getCdatetime() {
		return cdatetime;
	}
	
}
