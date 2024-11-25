package com.example.furnature.dao;

import java.util.HashMap;

public interface QnaService {	
	
	HashMap<String, Object> QnaList(HashMap<String, Object> map);

	HashMap<String, Object> QnaView(HashMap<String, Object> map);
	
	HashMap<String, Object> commentRegist(HashMap<String, Object> map);
	
	HashMap<String, Object> qnaRegist(HashMap<String, Object> map);
	
	HashMap<String, Object> commentDelete(HashMap<String, Object> map);
	
	HashMap<String, Object> commentUpdate(HashMap<String, Object> map);
	
	HashMap<String, Object> qnaUpdate(HashMap<String, Object> map);
	
	HashMap<String, Object> qnaDelete(HashMap<String, Object> map);

}
