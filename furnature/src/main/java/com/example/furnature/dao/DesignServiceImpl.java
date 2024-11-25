package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.DesignMapper;
import com.example.furnature.model.Design;

@Service
public class DesignServiceImpl implements DesignService{
	
	@Autowired
	DesignMapper designMapper;
	
	//디자인등록
	@Override
	public HashMap<String, Object> insertDesign(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			designMapper.insertDesign(map);
			resultMap.put("designNo",map.get("designNo"));
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
	
	//디자인 목록
	@Override
	public HashMap<String, Object> selectDesign(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Design> list = designMapper.selectDesign(map);
			resultMap.put("list",list);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> designDetail(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Design list = designMapper.designDetail(map);
			int count = designMapper.designRecommend(map);
			System.out.println("##################"+count);
			if(count >= 1) {
				resultMap.put("likeCheck", "true");
			}else {
				resultMap.put("likeCheck", "false");				
			}
			resultMap.put("list",list);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> designRecommend(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = designMapper.designRecommend(map);
			if(count >= 1) {
				resultMap.put("Flg", "true");
				designMapper.recommendCancel(map);
			}else {
				designMapper.recommend(map);
				resultMap.put("Flg","false");
			}
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> designSelect(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("@@@@@@@@@@@@이거 맵"+map);
			designMapper.designSelect(map);
			resultMap.put("result", "성공");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}


	@Override
	public HashMap<String, Object> designDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			designMapper.designDelete(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
}
