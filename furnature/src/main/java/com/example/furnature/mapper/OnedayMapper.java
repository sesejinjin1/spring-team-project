package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Oneday;

@Mapper
public interface OnedayMapper {
	
	//원데이클래스 목록 출력
	List<Oneday> onedayList(HashMap<String,Object> map);
	
	//원데이클래스 목록 갯수
	int totalCount(HashMap<String,Object> map);
	
	//원데이클래스 수강신청
	void onedayJoin(HashMap<String,Object> map);
	
	//원데이클래스 개별 상세 정보
	List<Oneday> onedayDetail(HashMap<String,Object> map);
	
	//원데이클래스 등록(관리자)
	void onedayReg(HashMap<String,Object> map);
	
	//원데이클래스 등록시 파일 업로드
	void onedayFile(HashMap<String,Object> map);
	
	//원데이클래스 등록시 썸네일 업로드
	void onedayThumb(HashMap<String,Object> map);
	
	//원데이클래스 인원초과 여부 확인
	Oneday numberLimit(HashMap<String,Object> map);
	
	//원데이클래스 수정(관리자)
	void onedayUpdate(HashMap<String,Object> map);
	
	//원데이클래스 수강신청 중복여부
	int onedayCheck(HashMap<String,Object> map);

}
