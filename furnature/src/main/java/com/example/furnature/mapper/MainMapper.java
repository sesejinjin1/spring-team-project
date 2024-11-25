package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Event;
import com.example.furnature.model.Oneday;
import com.example.furnature.model.Product;

@Mapper
public interface MainMapper {
	// 상품 리스트 불러오기
	List<Product> selectProductList(HashMap<String, Object> map);
	
	// 원데이클래스 리스트 불러오기
	List<Oneday> selectOnedayList(HashMap<String, Object> map);
	
	// 경매 리스트 불러오기
	List<Event> selectAuctionList(HashMap<String, Object> map);
}
