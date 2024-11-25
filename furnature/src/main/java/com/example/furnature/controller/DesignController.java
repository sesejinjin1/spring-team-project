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

import com.example.furnature.dao.DesignService;
import com.example.furnature.mapper.DesignMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class DesignController {
	@Autowired
	DesignService designService;
	@Autowired
	DesignMapper designMapper;
	
	//디자인추천 메인
	@RequestMapping("/design/design.do")
	public String design(Model model) throws Exception{
		return "/design/design";
	}
	
	//디자인등록
	@RequestMapping("/design/designRegist.do")
	public String designRegist(Model model) throws Exception{
		return "/design/designRegist";
	}
	
	
	//디자인삭제
	@RequestMapping(value = "/design/designDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designdelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.designDelete(map);
		return new Gson().toJson(resultMap);
	}
	//디자인등록
	@RequestMapping(value = "/design/designRegist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.insertDesign(map);
		return new Gson().toJson(resultMap);
	}
	//디자인추천
	@RequestMapping(value = "/design/designRecommend.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designRecommend(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.designRecommend(map);
		return new Gson().toJson(resultMap);
	}
	//디자인확정
	@RequestMapping(value = "/design/designSelect.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designSelect(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.designSelect(map);
		return new Gson().toJson(resultMap);
	}
	//디자인 상세정보 페이지
	@RequestMapping("/design/designDetail.do")
	 public String designDetail(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
        request.setAttribute("designNo", map.get("designNo"));
		return "/design/designDetail";
    }
	//디자인 상세정보 페이지
	@RequestMapping(value = "/design/designDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.designDetail(map);
		return new Gson().toJson(resultMap);
	}
	//디자인등록
	@RequestMapping(value = "/design/design.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = designService.selectDesign(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/design/designFile.dox")
    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("designNo") int designNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String path=System.getProperty("user.dir");
        try {
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            String saveFileName = genSaveFileName(extName);
            if(!multi.isEmpty()){
                File file = new File(path + "\\src\\main\\webapp\\uploadImages\\design", saveFileName);
                multi.transferTo(file);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("fileName", saveFileName);
                map.put("filePath", "../uploadImages/design/" + saveFileName);
                map.put("designNo", designNo);
                
                // insert 쿼리 실행
                designMapper.insertDesignFile(map);
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
            } 
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:design.do";
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
