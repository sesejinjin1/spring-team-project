package com.example.furnature.dao;

import java.util.HashMap;

public interface MyPageService {
    // 내정보 조회
    HashMap<String, Object> searchUser(HashMap<String, Object> map);
    // 내정보 수정
    HashMap<String, Object> editUser(HashMap<String, Object> map);
    // 경매 입찰 리스트 조회
    HashMap<String, Object> searchBiddingList(HashMap<String, Object> map);
    // 경매 입찰 취소
    HashMap<String, Object> cancelBidding(HashMap<String, Object> map);
    // 배송 조회
    HashMap<String, Object> selectDelivery(HashMap<String, Object> map); 
    // 마일리지 조회
    HashMap<String, Object> searchMileageList(HashMap<String, Object> map);
    // 원데이클래스 신청내역 조회(회원)
    HashMap<String, Object> onedayInfo(HashMap<String, Object> map);
	//원데이클래스 결제
	HashMap<String,Object> onedayPay(HashMap<String,Object> map);
	//원데이클래스 수강취소
	HashMap<String,Object> onedayCancel(HashMap<String,Object> map);
    //장바구니 목록
    HashMap<String, Object> searchCartList(HashMap<String, Object> map);
    //장바구니 체크 삭제
    HashMap<String, Object> removeCartCheck(HashMap<String, Object> map);
    //구매목록
    HashMap<String, Object> paymentList(HashMap<String, Object> map);
}
