package com.example.furnature.dao;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.PaymentMapper;
import com.example.furnature.model.Pay;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.annotation.PostConstruct;
import jakarta.persistence.PersistenceException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	PaymentMapper paymentMapper;
	
	@Value("${imp_key}")
	private String impKey;

    @Value("${imp_secret}")
    private String impSecret;
    
    private IamportClient iamportClient;
    	
    @PostConstruct
	public void init() {
        this.iamportClient = new IamportClient(impKey, impSecret);
    }

    // 결제
	@Override
	public IamportResponse<Payment>payment(HashMap<String, Object> map) {
		IamportResponse<Payment> paymentResponse = null;
		String imp_uid = (String) map.get("imp_uid");
		try {
			paymentResponse = this.iamportClient.paymentByImpUid(imp_uid);
			//System.out.println(paymentResponse);
			//TODO : 처리 로직
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO : 401 Unauthorized 
				break;
			case 404 :
				//TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
			 	break;
			case 500 :
				//TODO : 서버 응답 오류
				break;
			}
		} catch (IOException e) {
			//서버 연결 실패
			e.printStackTrace();
		}
		return paymentResponse;
	}

	// 결제 취소
	@Override
	public IamportResponse<Payment> cancel(HashMap<String, Object> map) {
		IamportResponse<Payment> paymentResponse = null;
		String imp_uid = (String) map.get("imp_uid");
		try {
			paymentResponse = this.iamportClient.cancelPaymentByImpUid(new CancelData(imp_uid, true));
			//System.out.println(paymentResponse);
			//TODO : 처리 로직
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO : 401 Unauthorized 
				break;
			case 404 :
				//TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
			 	break;
			case 500 :
				//TODO : 서버 응답 오류
				break;
			}
		} catch (IOException e) {
			//서버 연결 실패
			e.printStackTrace();
		}
		return paymentResponse;
	}

	// 결제 내역 등록 + 경매 주문 내역 추가 + 원데이 클래스 결제 내역 추가
	@Override
	public HashMap<String, Object> addPayment(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println(map);
			paymentMapper.insertPayment(map);
			if(map.get("category").toString().equals("oneday")) {
				paymentMapper.updateOneday(map);
			} else if(map.get("category").toString().equals("product")) {
				System.out.println(map);
				if(Integer.parseInt(map.get("pointPay").toString()) > 0) {
					//사용 마일리지가 0이상일땐 마일리지 사용
					paymentMapper.useMileage(map);
					paymentMapper.insertProductOrder(map);
				}else {
					//사용 마일리지가 없을땐 마일리지 적립
					paymentMapper.saveMileage(map);
					paymentMapper.insertProductOrder(map);
				}
			} else {
				paymentMapper.insertProductOrder(map);
			}
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (DataAccessException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	// 결제 내역 불러오기
	@Override
	public HashMap<String, Object> searchPaymentInfo(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			Pay payInfo = paymentMapper.selectPaymentInfo(map);
			System.out.println(payInfo);
			resultMap.put("payInfo", payInfo);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (DataAccessException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail"); 
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	// 결제 내역 수정 - 결제 취소
	@Override
	public HashMap<String, Object> editPayment(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			paymentMapper.updatePayment(map);
			if(map.get("category").toString().equals("oneday")) {
				paymentMapper.deleteOneday(map);
			} else {
				
			}
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (DataAccessException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail"); 
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

}
