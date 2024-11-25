package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Admin;
import com.example.furnature.model.Design;
import com.example.furnature.model.MyPage;

@Mapper
public interface AdminMapper {
	// 유저 리스트 조회
	List<Admin> selectUserList(HashMap<String, Object> map);
	// 유저 전체 리스트수 조회
	Admin selectAllUser(HashMap<String, Object> map);
	// 유저 정보 조회
	Admin selectUser(HashMap<String, Object> map);
	// 유저 삭제
	void deleteUser(HashMap<String, Object> map);
	// 유저 정보 수정
	void updateUser(HashMap<String, Object> map);
  // 비밀번호 초기화
	
	void resetPwd(HashMap<String, Object> map);
	//원데이클래스 신청인수 등 현황 조회
	List<MyPage> currentNumber(HashMap<String, Object> map);
	//원데이클래스 삭제
	void onedayDelete(HashMap<String, Object> map);
	//원데이클래스 파일삭제
	void onedayFileDelete(HashMap<String, Object> map);
	//원데이클래스 썸네일삭제
	void onedayThumbDelete(HashMap<String,Object> map);
	//원데이클래스 개별조회
	Admin onedayInfo(HashMap<String, Object> map);
	//원데이클래스 클래스수
	int totalCount(HashMap<String,Object> map);
	
	
	int adminDeliveryCount(HashMap<String, Object> map);
	//관리자 배달현황 업데이트
	void adminDeliveryUpdate(HashMap<String, Object> map);
	// 관리자배송조회
	List<MyPage> adminDelivery(HashMap<String, Object> map);
	
	
	
	//상품등록
	void enrollProduct(HashMap<String,Object> map);
	//상품 썸네일,설명 이미지 등록
	void attachProduct(HashMap<String,Object> map);
	
	void productDelete(HashMap<String,Object> map);
	
	void productAttachDelete(HashMap<String,Object> map);
	
	void productUpdate(HashMap<String,Object> map);
	
	Admin productUpdateList(HashMap<String,Object> map);
	
	// 디자인 관리자 목록
	List<Admin> adminDesignList(HashMap<String, Object> map);
	
	//게시판삭제
	void qnaDelete(HashMap<String,Object> map);
	
	//게시판 댓글 삭제
	void commentAllDelete(HashMap<String,Object> map);

	//커스텀리스트
	List<Admin> adminCustomList(HashMap<String, Object> map);
	
	//커스텀확정
	void customConfirm(HashMap<String, Object> map);

}
