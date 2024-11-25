package com.example.furnature.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.furnature.dao.QnaService;
import com.example.furnature.mapper.QnaMapper;
import com.google.gson.Gson;

@Controller
public class QnaController {
	@Autowired
	QnaService qnaService;
	
	@Autowired
	QnaMapper qnaMapper;
		//게시글 목록
		@RequestMapping("/qna/qnalist.do") 
	    public String milelist(Model model) throws Exception{

	        return "/qna/qna-list";
	    }
		//게시글 등록
		@RequestMapping("/qna/qna-regist.do") 
		public String qnaregist(Model model) throws Exception{
			
			return "/qna/qna-regist";
		}
		@RequestMapping("qna/qnaview.do") 
		public String qnaView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		    request.setAttribute("qnaNo", map.get("qnaNo"));
		    return "qna/qna-view";
		}
		
		//게시글수정
		@RequestMapping("/qna/qnaupdate.do") 
		public String qnaUpdate(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
			request.setAttribute("qnaNo", map.get("qnaNo"));
			return "/qna/qna-update";
		}
		
		//게시글 수정 리스트
		@RequestMapping(value = "/qna/qna_update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnaUpdatelist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.QnaView(map);
			return new Gson().toJson(resultMap);
		}
		//게시글 수정
		@RequestMapping(value = "/qna/qna_update_regist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnaUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.qnaUpdate(map);
			return new Gson().toJson(resultMap);
		}
		
		//게시글 댓글
		@RequestMapping(value = "/qna_comments.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnaComment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
				= new HashMap<String, Object>();
			resultMap = qnaService.commentRegist(map);
			return new Gson().toJson(resultMap);
		}
		
		//게시글목록
		@RequestMapping(value = "/qna/qna_list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnalist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.QnaList(map);
			return new Gson().toJson(resultMap);
		}	
		//게시글 상세
		@RequestMapping(value = "/qna_view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnaview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.QnaView(map);
			return new Gson().toJson(resultMap);
		}
		//게시글 등록
		@RequestMapping(value = "/qna/qna_regist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnaregist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.qnaRegist(map);
			return new Gson().toJson(resultMap);
		}
		//댓글 삭제
		@RequestMapping(value = "/qna/commentDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String commentdelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.commentDelete(map);
			return new Gson().toJson(resultMap);
		}
		//댓글 수정
		@RequestMapping(value = "/qna/commentUpdate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String commentUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.commentUpdate(map);
			return new Gson().toJson(resultMap);
		}
		//게시물 삭제
		@RequestMapping(value = "/qna/qnaDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String qnadelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
			resultMap = qnaService.qnaDelete(map);
			return new Gson().toJson(resultMap);
		}
		
		@RequestMapping("/qna-file.dox")
	    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("qnaNo") int qnaNo, HttpServletRequest request,HttpServletResponse response, Model model)
	    {
	        String path=System.getProperty("user.dir");
	        try {
	            String originFilename = multi.getOriginalFilename();
	            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
	            String saveFileName = genSaveFileName(extName);
	            if(!multi.isEmpty()){
	                File file = new File(path + "\\src\\main\\webapp\\uploadImages\\qna", saveFileName);
	                multi.transferTo(file);
	                HashMap<String, Object> map = new HashMap<String, Object>();

	                map.put("qnaFilePath", "../uploadImages/qna/" + saveFileName);
	                map.put("qnaNo", qnaNo);
	                
	                // insert 쿼리 실행
	                qnaMapper.fileRegist(map);
	                
	                model.addAttribute("filename", multi.getOriginalFilename());
	                model.addAttribute("uploadPath", file.getAbsolutePath());
	                
	            } 
	        }catch(Exception e) {
	            System.out.println(e);
	        }
	        return "redirect:/qna/qnalist.do";
	    }
	    
	    // 현재 시간을 기준으로 파일 이름 생성
	    private String genSaveFileName(String extName) {
	        String fileName = "";
	        
	        Calendar calendar = Calendar.getInstance();
	        fileName += calendar.get(Calendar.YEAR);
	        fileName += calendar.get(Calendar.MONTH);
	        fileName += calendar.get(Calendar.DATE);
	        fileName += calendar.get(Calendar.HOUR);
	        fileName += calendar.get(Calendar.MINUTE);
	        fileName += calendar.get(Calendar.SECOND);
	        fileName += calendar.get(Calendar.MILLISECOND);
	        fileName += extName;
	        
	        return fileName;
	    }
}
