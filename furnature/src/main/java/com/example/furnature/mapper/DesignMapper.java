package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Design;

@Mapper
public interface DesignMapper {
	
	// 디자인등록
	void insertDesign(HashMap<String, Object> map);

	// 디자인 첨부등록
	void insertDesignFile(HashMap<String, Object> map);
	
	// 디자인 목록
	List<Design> selectDesign(HashMap<String, Object> map);
		
	// 디자인 삭제
	List<Design> designDelete(HashMap<String, Object> map);
	
	//디자인 추천확인
	int desginCount(HashMap<String, Object> map);
	
	//디자인 상세
	Design designDetail(HashMap<String, Object> map);
	
	//디자인 추천확인
	int designRecommend(HashMap<String, Object> map);

	//디자인 추천
	void recommend(HashMap<String, Object> map);
	
	//디자인 추천 취소
	void recommendCancel(HashMap<String, Object> map);
	
	//디자인 확정
	void designSelect(HashMap<String, Object> map);
}
