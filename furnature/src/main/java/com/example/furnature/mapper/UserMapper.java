package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.User;

@Mapper
public interface UserMapper {
	// 아이디 확인
	User selectId(HashMap<String, Object> map);
	// 로그인 처리
	User selectUser(HashMap<String, Object> map);
	// 회원가입 처리
	int insertId(HashMap<String, Object> map);
	// 아이디 찾기 + 비밀번호 찾기
	User findInfo(HashMap<String, Object> map);
}
