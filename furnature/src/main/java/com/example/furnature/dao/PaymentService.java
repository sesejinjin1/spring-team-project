package com.example.furnature.dao;

import java.util.HashMap;

import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

public interface PaymentService {
	// 결제
	IamportResponse<Payment> payment(HashMap<String, Object> map);
	
	// 결제 취소
	IamportResponse<Payment> cancel(HashMap<String, Object> map);
	
	// 결제 내역 등록
	HashMap<String, Object> addPayment(HashMap<String, Object> map);
	
	// 결제 내역 불러오기
	HashMap<String, Object> searchPaymentInfo(HashMap<String, Object> map);
	
	// 결제 내역 수정 - 결제 취소
	HashMap<String, Object> editPayment(HashMap<String, Object> map);
}
