package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.MyPage;

@Mapper
public interface MyPageMapper {
	// 내정보 조회
	MyPage selectUser(HashMap<String, Object> map);
	
	// 내정보 수정
	void updateUser(HashMap<String, Object> map);
	
	// 경매 입찰 리스트 조회
	List<MyPage> selectBiddingList(HashMap<String, Object> map);	
	
	// 경매 입찰 취소
	int deleteBidding(HashMap<String, Object> map);
	
	// 경매 최고가 조회
	MyPage selectMaxPrice(HashMap<String, Object> map);
	
	// 경매 시작가 조회
	MyPage selectPrice(HashMap<String, Object> map);
	
	// 현재 입찰가 변경하기
	void updateAuctionPrice(HashMap<String, Object> map);
	
	// 배송조회
	List<MyPage> selectDelivery(HashMap<String, Object> map);
	
	// 관리자배송조회
	List<MyPage> adminDelivery(HashMap<String, Object> map);
	
	// 마일리지 리스트 조회
	List<MyPage> selectMileageList(HashMap<String, Object> map);
	

	//원데이클래스 신청내역 조회(회원)
	List<MyPage> onedayInfo(HashMap<String, Object> map);
	
	//원데이클래스 결제
	void onedayPay(HashMap<String,Object> map);
	
	//원데이클래스 수강취소
	void onedayCancel(HashMap<String,Object> map);


	int adminDeliveryCount(HashMap<String, Object> map);
	
	//관리자 배달현황 업데이트
	void adminDeliveryUpdate(HashMap<String, Object> map);
	
	//장바구니 목록
	List<MyPage> searchCartList(HashMap<String, Object> map);
	//장바구니 체크 삭제
	void deleteCheckCart(HashMap<String, Object> map);
	// 결제 목록
	List<MyPage> paymentList(HashMap<String, Object> map);
}
