package com.example.furnature.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.furnature.dao.OnedayService;
import com.google.gson.Gson;

@Controller
public class OnedayController {
	
	@Autowired
	OnedayService onedayService;
	
	//원데이클래스 목록출력
	@RequestMapping("/oneday/oneday.do")
	 public String onedayList(Model model) throws Exception{

        return "/oneday/oneday";
    }
	
	//원데이클래스 수강신청
	@RequestMapping("/oneday/oneday-join.do")
	 public String onedayClassJoin(HttpServletRequest request, Model model, @RequestParam HashMap<String,Object> map) throws Exception{
		request.setAttribute("classNo", map.get("classNo"));
       return "/oneday/oneday-join";
   }
	
	//원데이클래스 등록(관리자)
	@RequestMapping("/oneday/oneday-register.do")
	 public String onedayFile(Model model) throws Exception{
		
		return "/oneday/oneday-register";
 }
	//원데이클래스 수정(관리자)
	@RequestMapping("/oneday/oneday-update.do")
	 public String update(HttpServletRequest request, Model model, @RequestParam HashMap<String,Object> map) throws Exception{
		request.setAttribute("classNo", map.get("classNo"));
		return "/oneday/oneday-update";	
}
	
	//원데이클래스 목록출력
	@RequestMapping(value = "/oneday/oneday-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayList(map);
		return new Gson().toJson(resultMap);
	}
	
	//원데이클래스 상세내역(각 클래스 정보 개별 출력)
	@RequestMapping(value = "/oneday/oneday-detail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	//원데이클래스 수강신청
	@RequestMapping(value = "/oneday/oneday-join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayJoin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayJoin(map);
		return new Gson().toJson(resultMap);
	}
	
	//원데이클래스 등록(관리자)
	@RequestMapping(value = "/oneday/oneday-register.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayReg(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayReg(map);
		return new Gson().toJson(resultMap);
	}
	
	// 파일 업로드
    @RequestMapping(value = "/oneday/oneday-file.dox", method = RequestMethod.POST)
    public String uploadFiles(@RequestParam("file") MultipartFile[] files, @RequestParam("classNo") int classNo, HttpServletRequest request, Model model) {
        try {
            String path = System.getProperty("user.dir") + "\\src\\main\\webapp\\uploadImages\\oneday";
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String fileName = genSaveFileName(file.getOriginalFilename());
                    File saveFile = new File(path, fileName);
                    file.transferTo(saveFile);

                    HashMap<String, Object> fileMap = new HashMap<>();
                    fileMap.put("fileName", fileName);
                    fileMap.put("filePath", "../uploadImages/oneday/" + fileName);
                    fileMap.put("fileSize", file.getSize());
                    fileMap.put("extName", getFileExtension(file.getOriginalFilename()));
                    fileMap.put("classNo", classNo);

                    onedayService.onedayFile(fileMap);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/oneday/errorPage";
        }
        return "redirect:/oneday/oneday.do";
    }

    // 썸네일 업로드
    @RequestMapping(value = "/oneday/oneday-thumb.dox", method = RequestMethod.POST)
    public String uploadThumbnail(@RequestParam("thumb") MultipartFile thumb, @RequestParam("classNo") int classNo, HttpServletRequest request, Model model) {
        try {
            String path = System.getProperty("user.dir") + "\\src\\main\\webapp\\uploadImages\\oneday\\thumb";
            if (thumb != null && !thumb.isEmpty()) {
                String fileName = genSaveFileName(thumb.getOriginalFilename());
                File saveFile = new File(path, fileName);
                thumb.transferTo(saveFile);

                HashMap<String, Object> thumbMap = new HashMap<>();
                thumbMap.put("thumbName", fileName);
                thumbMap.put("thumbPath", "../uploadImages/oneday/thumb/" + fileName);
                thumbMap.put("thumbSize", thumb.getSize());
                thumbMap.put("extName", getFileExtension(thumb.getOriginalFilename()));
                thumbMap.put("classNo", classNo);

                onedayService.onedayThumb(thumbMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/oneday/errorPage";
        }
        return "redirect:/oneday/oneday.do";
    }

    // 파일 이름 생성
    private String genSaveFileName(String originalFilename) {
        String extName = originalFilename.substring(originalFilename.lastIndexOf("."));
        return System.currentTimeMillis() + extName;
    }

    // 파일 확장자 추출
    private String getFileExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    //원데이클래스 인원초과 여부 확인
    @RequestMapping(value = "/oneday/oneday-numberLimit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  	@ResponseBody
  	public String numberLimit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
  		HashMap<String, Object> resultMap = new HashMap<String, Object>();
  		resultMap = onedayService.numberLimit(map);
  		return new Gson().toJson(resultMap);
  	}
    
    //원데이클래스 수정(관리자)
    @RequestMapping(value = "/oneday/oneday-update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayUpdate(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayUpdate(map);
		return new Gson().toJson(resultMap);
	}
    
    //원데이클래스 중복신청 여부
    @RequestMapping(value = "/oneday/oneday-check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayCheck(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = onedayService.onedayCheck(map);
		return new Gson().toJson(resultMap);
	}
    
   
	
} 