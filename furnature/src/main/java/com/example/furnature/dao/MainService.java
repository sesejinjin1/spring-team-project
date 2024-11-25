package com.example.furnature.dao;

import java.util.HashMap;

public interface MainService {
	// 상품 리스트 불러오기
	HashMap<String, Object> searchProductList(HashMap<String, Object> map);
	
	// 원데이클래스 리스트 불러오기
	HashMap<String, Object> searchOnedayList(HashMap<String, Object> map);
	
	// 경매 리스트 불러오기
	HashMap<String, Object> searchAuctionList(HashMap<String, Object> map);
}
