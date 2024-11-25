package com.example.furnature.dao;

import java.util.HashMap;

public interface AdminService {
	// 유저 리스트 조회
	HashMap<String, Object> searchUserList(HashMap<String, Object> map);
	// 유저 삭제
	HashMap<String, Object> removeUser(HashMap<String, Object> map);
	// 유저 정보 수정
	HashMap<String, Object> editUser(HashMap<String, Object> map);
  // 비밀번호 초기화
	HashMap<String, Object> resetPwd(HashMap<String, Object> map);
	
	
  //원데이클래스 신청인수 등 현황 조회
  HashMap<String, Object> currentNumber(HashMap<String, Object> map);
  //원데이클래스 삭제
  HashMap<String, Object> onedayDelete(HashMap<String, Object> map);
  //원데이클래스 개별조회
  HashMap<String, Object> onedayInfo(HashMap<String, Object> map);
  
  
  // 관리자 배송 조회
  HashMap<String, Object> adminDelivery(HashMap<String, Object> map);
  // 관리자 배송 업데이트
  HashMap<String, Object> adminDeliveryUpdate(HashMap<String, Object> map);
  
  	//상품 리스트
	HashMap<String, Object> productList(HashMap<String, Object> map);
	//상품등록
	HashMap<String, Object> enrollProduct(HashMap<String, Object> map);	
	//상품삭제
	HashMap<String, Object> productDelete(HashMap<String, Object> map);	
	//상품수정 상세
	HashMap<String, Object> productUpdateList(HashMap<String, Object> map);	
	//상품수정
	HashMap<String, Object> productUpdate(HashMap<String, Object> map);	
	
	
	//디자인 관리자 목록
	HashMap<String, Object> adminDesignList(HashMap<String, Object> map);
	
	//게시판삭제
	HashMap<String, Object> qnaDelete(HashMap<String, Object> map);
	
	//커스텀리스트
	HashMap<String, Object> adminCustomList(HashMap<String, Object> map);
	
	//커스텀확정
	HashMap<String, Object> customConfirm(HashMap<String, Object> map);
}
