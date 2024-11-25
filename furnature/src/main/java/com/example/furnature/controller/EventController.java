package com.example.furnature.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.dao.EventService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class EventController {
	@Autowired
	EventService eventService;
	
	// 이벤트 목록 페이지
	@RequestMapping("/event/event.do")
	public String eventList(Model model) throws Exception{
		return "/event/event";
	}
	
	// 경매 등록 페이지
	@RequestMapping("/event/auctionRegister.do")
	public String eventInsert(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("auctionNo", map.get("auctionNo"));
		return "/event/auctionRegister";
	}
	
	// 경매 상세 페이지
	@RequestMapping("/event/auctionDetail.do")
	public String eventDetail(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("auctionNo", map.get("auctionNo"));
		return "/event/auctionDetail";
	}
		
	// 룰렛 조회 db
	@RequestMapping(value = "/event/auction-roulette.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String searchRoulette(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.searchRoulette(map);
		return new Gson().toJson(resultMap);
	}
		
	// 경매 조회 db
	@RequestMapping(value = "/event/auction-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.searchAuctionList();
		return new Gson().toJson(resultMap);
	}
	
	// 경매 상세 페이지 조회 db
	@RequestMapping(value = "/event/auction-detail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.searchAuctionDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	// 경매 수정 페이지 조회 db
	@RequestMapping(value = "/event/auction-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.searchEditInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// 경매 등록 db
	@RequestMapping(value = "/event/auction-register.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionRegister(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.addAuction(map);
		return new Gson().toJson(resultMap);
	}
	
	// 경매 입찰 db
	@RequestMapping(value = "/event/auction-bidding.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionBidding(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = eventService.addAuctionBidding(map);
		return new Gson().toJson(resultMap);
	}
	
	// 경매 삭제 db
	@RequestMapping(value = "/event/auction-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String auctionRemove(Model model, @RequestParam("auctionTumb") String[] thumbList, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//resultMap = eventService.addAuction(map);
		
		try {
			String path=System.getProperty("user.dir");
			String uploadpath = path + "\\src\\main\\webapp\\uploadImages\\event\\";
			
			System.out.println(map);
			for(String thumb : thumbList) {
				File file = new File(uploadpath + "thumb\\" + thumb);
				file.delete();
			}
			
			String detailName = map.get("auctionDetail").toString(); 
			if(detailName != "" || !detailName.isEmpty()) { 
				File file = new File(uploadpath + detailName);
				file.delete(); 
			}
			 
			map.remove("auctionTumb");
			map.remove("auctionDetail");
			System.out.println(map);
			resultMap = eventService.removeAuction(map);
			resultMap.put("file", ResMessage.RM_REMOVE);
		} catch (Exception e) {
			resultMap.put("file", ResMessage.RM_FAIL);
		}
		return new Gson().toJson(resultMap);
	}
	
	// 경매 관련 이미지 등록 db
	@RequestMapping(value = "/event/thumbUpload.dox")
    public String thumbFile(@RequestParam("thumbFile") MultipartFile[] thumbFile, @RequestParam("contentsFile") MultipartFile contentsFile, @RequestParam("auctionNo") int auctionNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String path=System.getProperty("user.dir");
        try {
        	String uploadpath = path + "\\src\\main\\webapp\\uploadImages\\event";
        	for (MultipartFile file : thumbFile) {
        		if(!file.isEmpty()){
        			System.out.println(file);
	            	String originFilename = file.getOriginalFilename();
	            	String extName = originFilename.substring(originFilename.lastIndexOf("."));
	            	long size = file.getSize();
	            	String saveFileName = genSaveFileName(extName);

	                File serverFile = new File(uploadpath+ "\\thumb", saveFileName);
	                file.transferTo(serverFile);
	                
	                HashMap<String, Object> map = new HashMap<String, Object>();
	                map.put("auctionNo", auctionNo);
	                map.put("auctionImgName", saveFileName);
	                map.put("auctionImgOrgName",originFilename);
	                map.put("auctionImgPath", "../../uploadImages/event/thumb/" + saveFileName);
	                map.put("auctionImgSize", size);
	                //map.put("fileExt", extName);
	                
	                // insert 쿼리 실행
	                eventService.addAuctionImg(map);
	                
	                model.addAttribute("filename", file.getOriginalFilename());
	                model.addAttribute("uploadPath", serverFile.getAbsolutePath());	                
	            }
        	}
    		if(!contentsFile.isEmpty()){
    			String originFilename = contentsFile.getOriginalFilename();
    			String extName = originFilename.substring(originFilename.lastIndexOf("."));
    			String saveFileName = genSaveFileName(extName);
    			File serverFile = new File(uploadpath, saveFileName);
    			contentsFile.transferTo(serverFile);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("auctionNo", auctionNo);
                map.put("auctionContentsImgPath", "../../uploadImages/event/" + saveFileName);
                map.put("auctionContentsImgName", saveFileName);
                
                // insert 쿼리 실행
                eventService.editAuctionPath(map);
                
                model.addAttribute("filename", contentsFile.getOriginalFilename());
                model.addAttribute("uploadPath", serverFile.getAbsolutePath());	                
            }
        	model.addAttribute("message", "파일 업로드가 완료되었습니다.");
        	return "redirect:event.do";
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:event.do";
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
