package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.MainService;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	// 메인 페이지
	@RequestMapping("/main.do")
	public String main(Model model) throws Exception{
		return "/main/main";
	}
	
	// 상품 정보 목록 db
	@RequestMapping(value = "/main/main-product.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchProductList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.searchProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 원데이클래스 정보 목록 db
	@RequestMapping(value = "/main/main-oneday.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchOnedayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.searchOnedayList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 경매 정보 목록 db
	@RequestMapping(value = "/main/main-auction.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchAuctionList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.searchAuctionList(map);
		return new Gson().toJson(resultMap);
	}
}
