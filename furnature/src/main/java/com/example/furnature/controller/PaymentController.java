package com.example.furnature.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.furnature.dao.PaymentServiceImpl;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class PaymentController {
	@Autowired
	PaymentServiceImpl paymentService;
	
	
	// 결제
	@PostMapping("/payment/payment/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		return paymentService.payment(map);	
	}
	
	// 결제 취소
	@PostMapping("/payment/cancel/{imp_uid}")
	public IamportResponse<Payment> cancelPaymentByImpUid(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		return paymentService.cancel(map);	
	}
	
	// 결제 내역 등록
	@RequestMapping(value = "/payment/payment-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addPayment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    //selectSize 없을경우에는 실행안함 ( 원데이클래스 String json 선언할때 널값이라고 오류나와서 if묶어놨습니다.
	    if (map.containsKey("selectedSize") && map.get("selectedSize") != null) {
	        String json = map.get("selectedSize").toString(); 
	        ObjectMapper mapper = new ObjectMapper();
	        List<Object> selectedSize = mapper.readValue(json, new TypeReference<List<Object>>() {});
	        map.put("selectedSize", selectedSize);
	    }
	    resultMap = paymentService.addPayment(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 결제 취소 전 정보 불러오기
	@RequestMapping(value = "/payment/payment-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchPayment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = paymentService.searchPaymentInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// 결제 내역 수정 - 결제 취소
	@RequestMapping(value = "/payment/payment-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editPayment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = paymentService.editPayment(map);
		return new Gson().toJson(resultMap);
	}
	
}
