package com.example.furnature.dao;

import java.util.HashMap;

public interface EventService {
	// 룰렛 상태 불러오기
	HashMap<String, Object> searchRoulette(HashMap<String, Object> map);
	// 경매 리스트 불러오기
	HashMap<String, Object> searchAuctionList();
	// 경매 등록 + 수정
	HashMap<String, Object> addAuction(HashMap<String, Object> map);
	// 경매 썸네일 등록
	HashMap<String, Object> addAuctionImg(HashMap<String, Object> map);
	// 경매 상세 이미지 경로 등록
	HashMap<String, Object> editAuctionPath(HashMap<String, Object> map);
	// 경매 상세 페이지 조회
	HashMap<String, Object> searchAuctionDetail(HashMap<String, Object> map);
	// 경매 수정 - 정보 불러오기
	HashMap<String, Object> searchEditInfo(HashMap<String, Object> map);
	// 경매 삭제 + 경매 썸네일 리스트 삭제
	HashMap<String, Object> removeAuction(HashMap<String, Object> map);
	// 경매 입찰하기
	HashMap<String, Object> addAuctionBidding(HashMap<String, Object> map);
}
