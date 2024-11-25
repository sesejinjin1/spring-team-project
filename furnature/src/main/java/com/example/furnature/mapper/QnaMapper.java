package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Qna;


@Mapper
public interface QnaMapper {
	List<Qna> QnaList(HashMap<String,Object> map);

	List<Qna> commentView(HashMap<String,Object> map);
	 
	Qna QnaView(HashMap<String,Object> map);
	
	int listCount(HashMap<String,Object> map);
	
	void commentRegist(HashMap<String,Object> map);
	
	void qnaRegist(HashMap<String,Object> map);
	
	void fileRegist(HashMap<String,Object> map);
	
	void commentDelete(HashMap<String,Object> map);
	
	void commentUpdate(HashMap<String,Object> map);
	
	void qnaUpdate(HashMap<String,Object> map);
	
	void qnaDelete(HashMap<String,Object> map);
	
	void commentAllDelete(HashMap<String,Object> map);
}
