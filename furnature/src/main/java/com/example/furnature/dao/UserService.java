package com.example.furnature.dao;

import java.util.HashMap;

public interface UserService {
	// 로그인 처리
	HashMap<String, Object> searchUser(HashMap<String, Object> map);
	// 아이디 중복 체크
	HashMap<String, Object> searchIdCheck(HashMap<String, Object> map);
	// 회원 가입
	HashMap<String, Object> addId(HashMap<String, Object> map);
	// 로그아웃
	HashMap<String, Object> logout();
	// 문자인증
	HashMap<String, Object> msg(HashMap<String, Object> map);
	// 아이디 찾기
	HashMap<String, Object> findInfo(HashMap<String, Object> map);
}
