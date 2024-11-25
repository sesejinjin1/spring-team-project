package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.AdminMapper;
import com.example.furnature.mapper.DesignMapper;
import com.example.furnature.mapper.ProductMapper;
import com.example.furnature.model.Admin;
import com.example.furnature.model.MyPage;
import com.example.furnature.model.Product;

import jakarta.persistence.PersistenceException;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;
	@Autowired
	ProductMapper productmapper;
	@Autowired
	DesignMapper designMapper;

	// 유저 리스트 조회
	@Override
	public HashMap<String, Object> searchUserList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			if(map.get("id") == null) {				
				List<Admin> userList = adminMapper.selectUserList(map);
				Admin userAllList = adminMapper.selectAllUser(map);
				resultMap.put("userList", userList);
				resultMap.put("userAllList", userAllList);
			} else {
				Admin info = adminMapper.selectUser(map);
				resultMap.put("info", info);
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

	// 유저 삭제
	@Override
	public HashMap<String, Object> removeUser(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.deleteUser(map);
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

	// 유저 정보 수정
	@Override
	public HashMap<String, Object> editUser(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.updateUser(map);
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

  // 비밀번호 초기화
	@Override
	public HashMap<String, Object> resetPwd(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.resetPwd(map);
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
	
    //원데이클래스 신청현황 조회(관리자)
	@Override
	public HashMap<String, Object> currentNumber(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			List<MyPage> currentNumber = adminMapper.currentNumber(map);
			int totalCount = adminMapper.totalCount(map);
			resultMap.put("currentNumber", currentNumber);
			resultMap.put("totalCount", totalCount);
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
	//원데이클래스 삭제
	@Override
	public HashMap<String, Object> onedayDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.onedayFileDelete(map);
			adminMapper.onedayDelete(map);
			adminMapper.onedayThumbDelete(map);
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

	//원데이클래스 정보 불러오기
	@Override
	public HashMap<String, Object> onedayInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			Admin onedayInfo = adminMapper.onedayInfo(map);
			resultMap.put("onedayInfo", onedayInfo);
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
	
	//관리자 배송조회
	@Override
	public HashMap<String, Object> adminDelivery(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>();
	        try {
	        	List<MyPage> list = adminMapper.adminDelivery(map);
	        	int count = adminMapper.adminDeliveryCount(map);
	        	resultMap.put("count",count);
	            resultMap.put("list", list);
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
	//관리자 배송 업데이트
	@Override
	public HashMap<String, Object> adminDeliveryUpdate(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>();
	        try {
	        	adminMapper.adminDeliveryUpdate(map);
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
	
	
	//상품등록
	@Override
	public HashMap<String, Object> enrollProduct(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println("################################"+map);
			adminMapper.enrollProduct(map);
			resultMap.put("productNo",map.get("productNo"));
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	//상품삭제,첨부파일 삭제
	@Override
	public HashMap<String, Object> productDelete(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println("################################"+map);
			adminMapper.productDelete(map);
			adminMapper.productAttachDelete(map);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	@Override
	public HashMap<String, Object> productUpdateList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			Admin list =adminMapper.productUpdateList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> productUpdate(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println("@@@@@@@@@@@@@@@@@@@@map@@@@"+map);
			adminMapper.productUpdate(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
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
	
	@Override
	public HashMap<String, Object> adminDesignList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Admin> list = adminMapper.adminDesignList(map);
			int count = designMapper.desginCount(map);
			resultMap.put("count", count);
			resultMap.put("list", list);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
	
	//게시물 삭제
	@Override
	public HashMap<String, Object> qnaDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			adminMapper.commentAllDelete(map);
			adminMapper.qnaDelete(map);
			resultMap.put("message", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", "fail");
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> adminCustomList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Admin> list = adminMapper.adminCustomList(map);
			resultMap.put("list", list);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}

	//커스텀확정
	@Override
	public HashMap<String, Object> customConfirm(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("커스텀!!!!"+map);
			adminMapper.customConfirm(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
}
