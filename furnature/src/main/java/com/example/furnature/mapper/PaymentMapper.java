package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Pay;

@Mapper
public interface PaymentMapper {
	// 결제 정보 저장
	void insertPayment(HashMap<String, Object> map);
	
	// 결제 정보 불러오기
	Pay selectPaymentInfo(HashMap<String, Object> map);
	
	// 결제 내역 수정 - 결제 취소
	void updatePayment(HashMap<String, Object> map);
	
	// 경매 주문 내역 추가
	void insertProductOrder(HashMap<String, Object> map);
	
	// 결제 내역 업데이트 - 원데이클래스
	void updateOneday(HashMap<String, Object> map);
	
	// 결재 내역 삭제 - 원데이클래스
	void deleteOneday(HashMap<String, Object> map);
	
	//상품구매 마일리지 적립
	void saveMileage(HashMap<String, Object> map);
	//상품구매 마일리지 사용
	void useMileage(HashMap<String, Object> map);
	
}
