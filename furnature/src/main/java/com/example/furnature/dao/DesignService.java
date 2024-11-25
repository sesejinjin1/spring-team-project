package com.example.furnature.dao;

import java.util.HashMap;

public interface DesignService {
	
	//디자인등록
	HashMap<String, Object> insertDesign(HashMap<String, Object> map);

	//디자인목록
	HashMap<String, Object> selectDesign(HashMap<String, Object> map);
	
	//디자인상세
	HashMap<String, Object> designDetail(HashMap<String, Object> map);

	//디자인상세
	HashMap<String, Object> designRecommend(HashMap<String, Object> map);
	
	//디자인 확정
	HashMap<String, Object> designSelect(HashMap<String, Object> map);
	
	//디자인 삭제
	HashMap<String, Object> designDelete(HashMap<String, Object> map);

}
