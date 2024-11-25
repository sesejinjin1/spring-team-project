package com.example.furnature.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.UserMapper;
import com.example.furnature.model.User;

import jakarta.persistence.PersistenceException;
import jakarta.servlet.http.HttpSession;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	HttpSession session;

	// 로그인 처리
	@Override
	public HashMap<String, Object> searchUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			User user = userMapper.selectId(map);
			if(user == null) {
				resultMap.put("result", "fail");
				resultMap.put("message", "없는 아이디 입니다.\n아이디를 확인해 주세요.");
			} else {
				user = userMapper.selectUser(map);
				if(user == null) {
					resultMap.put("result", "fail");
					resultMap.put("message", "비밀번호를 확인해 주세요.");
				} else {
					session.setAttribute("sessionId", user.getUserId());
					session.setAttribute("sessionAuth", user.getUserAuth());
					resultMap.put("result", "success");
					resultMap.put("message", ResMessage.RM_SUCCESS);
				}
				
			}
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

	// 아이디 중복 체크
	@Override
	public HashMap<String, Object> searchIdCheck(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			User user = userMapper.selectId(map);
			if(user == null) {
				resultMap.put("result", "success");
				resultMap.put("message", "사용 가능한 아이디 입니다.");
			} else {
				resultMap.put("result", "fail");
				resultMap.put("message", "이미 사용중인 아이디 입니다.");				
			}
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

	// 회원가입
	@Override
	public HashMap<String, Object> addId(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			int id = userMapper.insertId(map);
			if(id == 0) {
				resultMap.put("result", "fail");
				resultMap.put("message", "가입에 실패하였습니다. 다시시도해주세요.");
			} else {
				resultMap.put("result", "success");
				resultMap.put("message", "가입이 완료되었습니다.");
			}
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

	// 로그아웃
	@Override
	public HashMap<String, Object> logout() {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			session.invalidate();
			resultMap.put("result", "success");
			resultMap.put("message", "로그아웃 되었습니다.");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	// 랜덤 숫자 6자리 만들기
	static String ranMsg() {
		String ran = "";
		for(int i=0; i < 6; i++) {
			ran += (int)(Math.random()*10);
		}
		return ran;
	}
	
	@Override
	public HashMap<String, Object> msg(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSHXQO3OAHZUOMV", "ZDYOZP2QELY0HMJA6VJY7NT0G3BXLDI0", "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		String msgText = ranMsg();
		String phoneNum = (String) map.get("phone");
		Message message = new Message();
		message.setFrom("01046548947");
		message.setTo(phoneNum);
		message.setText("인증번호를 입력해주세요.\n" + msgText);

		try {
		  // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
		  messageService.send(message);
		  resultMap.put("msg", msgText);
		  resultMap.put("result", "성공");
		} catch (NurigoMessageNotReceivedException exception) {
		  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		  System.out.println(exception.getFailedMessageList());
		  System.out.println(exception.getMessage());
		} catch (Exception exception) {
		  System.out.println(exception.getMessage());
		}
		return resultMap;
	}

	// 아이디 찾기 / 비밀번호 찾기
	@Override
	public HashMap<String, Object> findInfo(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			User id = userMapper.findInfo(map);
			if(id == null) {
				resultMap.put("result", "fail");
				resultMap.put("message", "입력하신 정보에 해당하는 아이디가 없습니다.");
			} else {
				if(map.get("id") == null) {					
					resultMap.put("findInfo", id.getUserId());
					resultMap.put("message", "아이디 찾기에 성공하였습니다.");
				} else {
					resultMap.put("findInfo", id.getUserPwd());
					resultMap.put("message", "비밀번호 찾기에 성공하였습니다.");
				}
				resultMap.put("result", "success");
			}
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
}