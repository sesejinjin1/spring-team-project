package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.ProductMapper;
import com.example.furnature.model.Product;

import jakarta.persistence.PersistenceException;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productmapper;
	

	// 상품 이미지 url 모든 리스트
	@Override
	public HashMap<String, Object> searchImgUrl(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> urlList = productmapper.selectProductImg(map);
			resultMap.put("urlList", urlList);
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
	//상품 리스트
	@Override
	public HashMap<String, Object> productList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.productList(map);
			int count = productmapper.productCnt(map);
			System.out.println("@@@@@@@@@@@@@@@@@"+count);
			resultMap.put("productList", list);
			resultMap.put("count", count);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	
	// 상품 클릭시 상품번호 받아서 번호에 맞는 상품정보 가져오기
	@Override
	public HashMap<String, Object> searchProductDetail(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			Product productDetail = productmapper.selectProductDetail(map);
			resultMap.put("productDetail", productDetail);
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

	//카테고리 리스트
	@Override
	public HashMap<String, Object> cateList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.cateList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	//상품 결제정보 DB넘기기
	@Override
	public HashMap<String, Object> productOrder(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		List<HashMap<String, Object>> orderList = (List<HashMap<String, Object>>) map.get("list");
		HashMap <String, Object> orderMap = new HashMap<>();
		
		System.out.println("SERVICECCSSSSSSSS"+map);
		try {
			
			for(int i=0 ;i<orderList.size();i++) {
				orderMap.put("orderId", map.get("orderId"));
				orderMap.put("productNo", map.get("productNo"));
				orderMap.put("orderPrice", map.get("orderPrice"));
				orderMap.put("userId", map.get("userId"));
				orderMap.put("orderSize", map.get("orderSize"));
				orderMap.put("orderCount", map.get("orderCount"));
				orderMap.put("orderSize", orderList.get(i).get("size")); // orderSize는 size로 수정
				orderMap.put("orderCount", orderList.get(i).get("count")); // count 가져오기
				orderMap.put("sizePrice", orderList.get(i).get("price")); // price 가져오기
				//System.out.println("SERVICECCSSSSSSSS newMapppppppp"+orderMap);
				productmapper.productOrder(orderMap);
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
	//리뷰 목록
	@Override
	public HashMap<String, Object> productReview(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> reviewList = productmapper.productReview(map);
			System.out.println("REVEIWSSSSSSSSSSSS"+map);
			int count = productmapper.reviewCnt(map);
			int reviewInsertCnt = productmapper.reviewInsertCnt(map);
			System.out.println(count);
			System.out.println("reviewInsertCntreviewInsertCntreviewInsertCnt"+reviewInsertCnt);
			
			resultMap.put("reviewList", reviewList);
			resultMap.put("reviewInsertCnt", reviewInsertCnt);
			resultMap.put("count", count);
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
	//리뷰작성
	@Override
	public HashMap<String, Object> insertReview(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.reviewInsert(map);
			resultMap.put("reviewNo",map.get("reviewNo"));
			System.out.println("serviceSSSSSSSS"+map);
			System.out.println("serviceSSSSSSSS"+resultMap);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	//리뷰 삭제
	@Override
	public HashMap<String, Object> deleteReview(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.deleteReview(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	//리뷰 수정
	@Override
	public HashMap<String, Object> updateReview(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.updateReview(map);
			resultMap.put("reviewNo",map.get("reviewNo"));
			System.out.println("SSSSSSSSSSSSSSSSSSUPDATE"+map);
			System.out.println("SSSSSSSSSSSSSSSSSSUPDATE"+resultMap);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	//리뷰 수정 전 내용 불러오기
	@Override
	public HashMap<String, Object> reviewInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("reviewInfOOOOOOOOOOOOOOOO"+map);
			Product reviewInfo = productmapper.reviewInfo(map);
			resultMap.put("reviewInfo", reviewInfo);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	//장바구니 담기
	@Override
	public HashMap<String, Object> insertCart(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.insertCart(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	@Override
	public HashMap<String, Object> recommend(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println("RECOMMENDSSSSSSSS"+map);
			List<Product> list = productmapper.recommend(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	//유저저
	@Override
	public HashMap<String, Object> searchUser(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.searchUser(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	//커스텀
	@Override
	public HashMap<String, Object> productCustom(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.productCustom(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	//커스텀
	@Override
	public HashMap<String, Object> productCustomCheck(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = productmapper.productCustomCheck(map);
			Product list = productmapper.customCheck(map);
			System.out.println("커스텀!@!!!!!!"+map);
			if(count >= 1) {
				resultMap.put("message", ResMessage.RM_SUCCESS);
				resultMap.put("customFlg", "true");
				resultMap.put("list",list);
			}else {
				resultMap.put("customFlg", "false");								
				resultMap.put("list",list);
			}
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	//커스텀취소
	@Override
	public HashMap<String, Object> productCustomCancel(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.productCustomCancel(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
}
