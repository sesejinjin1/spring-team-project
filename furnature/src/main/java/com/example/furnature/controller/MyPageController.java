package com.example.furnature.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.MyPageService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MyPageController {
    @Autowired
    MyPageService myPageService;
 
    // 마이페이지
    @RequestMapping("/myPage/myPage.do")
    public String myPage(Model model) throws Exception{
    	model.addAttribute("activePage","myPage");
        return "/myPage/myPage";
    }

    //원데이클래스 신청내역 조회 페이지
    @RequestMapping("/myPage/oneday.do")
    public String onedayInfo(HttpServletRequest request, Model model, @RequestParam HashMap<String,Object> map) throws Exception{
    	model.addAttribute("activePage","oneday");
    	request.setAttribute("classNo", map.get("classNo"));
        return "/myPage/myPage-oneday";
    }
    
    // 경매 입찰 리스트 조회 페이지
    @RequestMapping("/myPage/bidding.do")
    public String bidding(Model model) throws Exception{
    	model.addAttribute("activePage","bidding");
        return "/myPage/myPage-bidding";
    }
    
    // 배송 조회 페이지
    @RequestMapping("/myPage/delivery.do")
    public String delivery(Model model) throws Exception{
    	model.addAttribute("activePage","delivery");
    	return "/myPage/myPage-delivery";
    }
    
    // 마일리지 리스트 조회 페이지
    @RequestMapping("/myPage/mileage.do")
    public String mileage(Model model) throws Exception{
    	model.addAttribute("activePage","mileage");
    	return "/myPage/myPage-mileage";
    }


    // 장바구니 리스트 조회 페이지
    @RequestMapping("/myPage/cart.do")
    public String cart(Model model) throws Exception{
    	model.addAttribute("activePage","cart");
    	return "/myPage/myPage-cart";
    }
    
    // 상품 구매 리스트 조회 페이지
    @RequestMapping("/myPage/payment.do")
    public String payment(Model model) throws Exception{
    	model.addAttribute("activePage","payment");
    	return "/myPage/myPage-payment";
    }
    
    // 마이페이지 리스트 db
    @RequestMapping(value = "/myPage/myPage.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String searchUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchUser(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 마이페이지 정보 수정 db
    @RequestMapping(value = "/myPage/myPage-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String editUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	System.out.println(map);
    	resultMap = myPageService.editUser(map);
    	return new Gson().toJson(resultMap);
    }

    // 경매 입찰 리스트 조회 db
    @RequestMapping(value = "/myPage/bidding-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String searchBidding(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchBiddingList(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 경매 입찰 취소 db
    @RequestMapping(value = "/myPage/bidding-cancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String cancelBidding(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.cancelBidding(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 배송 조회
    @RequestMapping(value = "/myPage/mypage-delivery.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String mypageDelivery(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.selectDelivery(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 배송 조회
    @RequestMapping(value = "/myPage/mileage-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String mypageMileage(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchMileageList(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 원데이클래스 수강신청 내역 조회(회원)
    @RequestMapping(value = "/myPage/oneday-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String onedayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap = myPageService.onedayInfo(map);
        return new Gson().toJson(resultMap);
    }
    
  //원데이클래스 결제(고객)
  	@RequestMapping(value = "/myPage/oneday-pay.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  	@ResponseBody
  	public String onedayPay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
  		HashMap<String, Object> resultMap = new HashMap<String, Object>();
  		resultMap = myPageService.onedayPay(map);
  		return new Gson().toJson(resultMap);
  	}
  //원데이클래스 수강취소(고객)
  	@RequestMapping(value = "/myPage/oneday-cancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  	@ResponseBody
  	public String onedayCancel(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
  		HashMap<String, Object> resultMap = new HashMap<String, Object>();
  		resultMap = myPageService.onedayCancel(map);
  		return new Gson().toJson(resultMap);
  	}
    // 장바구니 목록 조회
    @RequestMapping(value = "/myPage/mypage-cartList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String cartList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchCartList(map);
    	System.out.println("CCCCCCCC"+map);
    	return new Gson().toJson(resultMap);
    }
    //장바구니 선택삭제
	@RequestMapping(value = "/myPage/check-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check_remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("selectCheck").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println("CCCCCCCCCCCCCCCCCCCCCC"+map);
		resultMap = myPageService.removeCartCheck(map);
		return new Gson().toJson(resultMap);
	}
    // 장바구니 목록 조회
    @RequestMapping(value = "/myPage/payment.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String payment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.paymentList(map);
    	System.out.println("CCCCCCCC"+map);
    	return new Gson().toJson(resultMap);
    }

}






