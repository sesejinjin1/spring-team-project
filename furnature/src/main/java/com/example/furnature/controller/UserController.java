package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.UserService;
import com.google.gson.Gson;

@Controller
public class UserController {
	@Autowired
	UserService userService;
	
	// 로그인 화면
	@RequestMapping("/login.do")
	public String login(Model model) throws Exception{
		return "/user/login";
	}
	
	// 회원가입 화면
	@RequestMapping("/join.do")
	public String join(Model model) throws Exception{
		return "/user/join";
	}
	
	// 아이디 찾기 화면
	@RequestMapping("/idFind.do")
	public String idFind(Model model) throws Exception{
		return "/user/idFind";
	}
	
	// 비밀번호 찾기 화면
	@RequestMapping("/pwdFind.do")
	public String pwdFind(Model model) throws Exception{
		return "/user/pwdFind";
	}
	
	// 로그인 처리 db
	@RequestMapping(value = "/user/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.searchUser(map);
		return new Gson().toJson(resultMap);
	}
	
	// 아이디 중복체크 db
	@RequestMapping(value = "/user/user-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.searchIdCheck(map);
		return new Gson().toJson(resultMap);
	}
	
	// 회원가입 db
	@RequestMapping(value = "/user/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String join(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.addId(map);
		return new Gson().toJson(resultMap);
	}
	
	// 로그아웃 db
	@RequestMapping(value = "/user/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.logout();
		return new Gson().toJson(resultMap);
	}
	
	// 문자인증
	@RequestMapping(value = "/user/msg.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String msg(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.msg(map);
		return new Gson().toJson(resultMap);
	}
	
	// 아이디 찾기 / 비밀번호 찾기
	@RequestMapping(value = "/user/findInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idFind(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.findInfo(map);
		return new Gson().toJson(resultMap);
	}
}
