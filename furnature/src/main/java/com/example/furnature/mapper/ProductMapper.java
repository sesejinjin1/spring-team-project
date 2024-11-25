package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Product;

@Mapper
public interface ProductMapper {
	
	// 상품 이미지 url 모든 리스트
	List<Product> selectProductImg(HashMap<String, Object> map);
	
	// 클릭한 상품 디테일 정보
	Product selectProductDetail(HashMap<String, Object> map);

	//상품 리스트
	List<Product> productList(HashMap<String, Object> map);
	
	//상품 카운트
	int productCnt(HashMap<String,Object> map);
	
	//카테고리 리스트
	List<Product> cateList(HashMap<String, Object> map);
	
	//상품 결제
	void productOrder(HashMap<String, Object> map);
	
	//리뷰 목록
	List<Product> productReview(HashMap<String, Object> map);
	
	//리뷰 작성
	void reviewInsert(HashMap<String, Object> map);
	
	//리뷰 이미지 첨부
	void insertReviewImg(HashMap<String, Object> map);
	
	//상품구매 마일리지 적립
	void saveMileage(HashMap<String, Object> map);
	//상품구매 마일리지 사용
	void useMileage(HashMap<String, Object> map);
	
	//리뷰 삭제
	void deleteReview(HashMap<String, Object> map);
	
	//리뷰 수정
	void updateReview(HashMap<String, Object> map);
	//리뷰 카운트 (페이징)
	int reviewCnt(HashMap<String,Object> map);
	//장바구니 담기
	void insertCart(HashMap<String, Object> map);
	
	//추천상품 리스트
	List<Product> recommend(HashMap<String, Object> map);
	
	//구매 사용자 정보가져오기
	List<Product> searchUser(HashMap<String, Object> map);
	
	//수정할 리뷰정보
	Product reviewInfo(HashMap<String, Object> map);
	
	//커스텀체크
	int productCustomCheck(HashMap<String, Object> map);
	
	//커스텀취소
	void productCustomCancel(HashMap<String, Object> map);
	
	//커스텀
	void productCustom(HashMap<String,Object> map);

	//커스텀리스트확인
	Product customCheck(HashMap<String, Object> map);
	
	//리뷰중복확인
	int reviewInsertCnt(HashMap<String, Object> map);
}
