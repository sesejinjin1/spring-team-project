package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Event;

@Mapper
public interface EventMapper {
	// 룰렛 상태 불러오기
	Event selectRoulette(HashMap<String, Object> map);
	
	// 룰렛 상태 변경
	void updateRoulette(HashMap<String, Object> map);
	
	// 마일리지 적립
	void insertMileage(HashMap<String, Object> map);
	
	// 경매 리스트 불러오기
	List<Event> selectAuctionList();
	
	// 경매 등록
	void insertAuction(HashMap<String, Object> map);
	
	// 경매 수정
	void updateAuction(HashMap<String, Object> map);
	
	// 썸네일 등록
	void insertAuctionImg(HashMap<String, Object> map);
	
	// 경매 상세 이미지 경로 등록
	void updataAuctionPath(HashMap<String, Object> map);
	
	// 경매 상세페이지 리스트 불러오기
	List<Event> selectDetail(HashMap<String, Object> map);

	// 경매 수정 - 정보 불러오기
	Event selectEditInfo(HashMap<String, Object> map);
	
	// 경매 삭제
	void deleteAuction(HashMap<String, Object> map);
	
	// 경매 썸네일 리스트 삭제
	int deleteAuctionImg(HashMap<String, Object> map);
	
	// 경매 입찰하기
	void insertAuctionBidding(HashMap<String, Object> map);
	
	// 현재 입찰가 변경하기
	void updateAuctionPrice(HashMap<String, Object> map);
}
