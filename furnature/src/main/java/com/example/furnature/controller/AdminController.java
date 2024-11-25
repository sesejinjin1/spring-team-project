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

import com.example.furnature.dao.AdminService;
import com.example.furnature.dao.DesignService;
import com.example.furnature.dao.MyPageService;
import com.example.furnature.dao.ProductService;
import com.example.furnature.mapper.AdminMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	@Autowired
	AdminMapper adminMapper;

	// 배달 관리
	@Autowired
	MyPageService myPageService;

	// 디자인 관리
	@Autowired
	DesignService designService;

	@Autowired
	ProductService productService;

	// 게시판목록
	@RequestMapping("/adminQna.do")
	public String adminqna(Model model) throws Exception {
		model.addAttribute("activePage", "qna");
		return "/admin/adminQna";
	}

	// 유저 정보 목록
	@RequestMapping("/admin.do")
	public String userList(Model model) throws Exception {
		model.addAttribute("activePage", "admin");
		return "/admin/adminUser";
	}
	// 커스텀 신청 목록
	@RequestMapping("/adminCustom.do")
	public String admincustom(Model model) throws Exception {
		model.addAttribute("activePage", "custom");
		return "/admin/adminCustom";
	}

	// 유저 정보 수정
	@RequestMapping("/adminEditor.do")
	public String userEdit(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map)
			throws Exception {
		model.addAttribute("activePage", "admin");
		request.setAttribute("id", map.get("id"));
		return "/admin/adminUserEditor";
	}

	// 관리자 배송 조회 페이지
	@RequestMapping("/adminDelivery.do")
	public String admindelivery(Model model) throws Exception {
		model.addAttribute("activePage", "delivery");
		return "/admin/adminDelivery";
	}

	// 상품등록
	@RequestMapping("/productRegist.do")
	public String product(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
		request.setAttribute("productNo", map.get("productNo"));
		model.addAttribute("activePage", "product");
		return "/admin/adminProductRegist";
	}

	// 상품관리
	@RequestMapping("/productmanage.do")
	public String productmanage(Model model) throws Exception {
		model.addAttribute("activePage", "product");
		return "/admin/adminProduct";
	}

	// 상품수정
	@RequestMapping("/manage/productUpdate.do")
	public String productUpdate(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
		request.setAttribute("productNo", map.get("productNo"));
		model.addAttribute("activePage", "product");
		return "/manage/manage-productUpdate";
	}

	@RequestMapping("/adminOneday.do")
	public String onedayClass(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map)
			throws Exception {
		request.setAttribute("sessionAuth", map.get("sessionAuth"));
		model.addAttribute("activePage", "oneday");
		return "/admin/adminOneday";
	}

	@RequestMapping("/admin/oneday-edit.do")
	public String onedayEdit(Model model, HttpServletRequest request, @RequestParam HashMap<String, Object> map)
			throws Exception {
		request.setAttribute("classNo", map.get("classNo"));
		model.addAttribute("activePage", "oneday");
		return "/admin/adminOnedayEditor";
	}

	// 디자인 관리자 리스트
	@RequestMapping("/adminDesign.do")
	public String adminDesign(Model model) throws Exception {
		model.addAttribute("activePage", "design");
		return "/admin/adminDesign";
	}

	// 유저 정보 목록 db
	@RequestMapping(value = "/admin/admin-user.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchUserList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.searchUserList(map);
		return new Gson().toJson(resultMap);
	}

	// 유저 정보 삭제 db
	@RequestMapping(value = "/admin/admin-user-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.removeUser(map);
		return new Gson().toJson(resultMap);
	}

	// 유저 정보 수정 db
	@RequestMapping(value = "/admin/admin-user-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = adminService.editUser(map);
		return new Gson().toJson(resultMap);
	}

	// 비밀번호 초기화 db
	@RequestMapping(value = "/admin/admin-user-pwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String resetPwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = adminService.resetPwd(map);
		return new Gson().toJson(resultMap);
	}

	// 원데이클래스 신청인수 등 현황 조회
	@RequestMapping(value = "/admin/oneday-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String currentNumber(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.currentNumber(map);
		return new Gson().toJson(resultMap);
	}

	// 원데이클래스 삭제
	@RequestMapping(value = "/admin/oneday-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.onedayDelete(map);
		System.out.println("!!!Result Map: " + resultMap);
		return new Gson().toJson(resultMap);
	}

	// 원데이클래스 개별조회
	@RequestMapping(value = "/admin/oneday-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String onedayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.onedayInfo(map);
		return new Gson().toJson(resultMap);
	}

	// 관리자 배송조회
	@RequestMapping(value = "/admin/admin-delivery.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String adminDelivery(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.adminDelivery(map);
		return new Gson().toJson(resultMap);
	}

	// 관리자 배송업데이트
	@RequestMapping(value = "/admin/admin-deliveryUpdate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deliveryUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.adminDeliveryUpdate(map);
		return new Gson().toJson(resultMap);
	}

	// 상품관리
	@RequestMapping(value = "/manage/productManage.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productmanage(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productList(map);
		return new Gson().toJson(resultMap);
	}

	// 상품수정목록
	@RequestMapping(value = "/manage/productUpdateList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productUpdateList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.productUpdateList(map);
		return new Gson().toJson(resultMap);
	}

	// 상품수정
	@RequestMapping(value = "/manage/manageProductUpdate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.productUpdate(map);
		return new Gson().toJson(resultMap);
	}

	// 상품삭제
	@RequestMapping(value = "/manage/productDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productdelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.productDelete(map);
		return new Gson().toJson(resultMap);
	}

	// 상품등록
	@RequestMapping(value = "/manage/manageProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String manageProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.enrollProduct(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("thumbnailFile") MultipartFile thumbnailFile,
			@RequestParam("descriptionFile") MultipartFile descriptionFile, @RequestParam("productNo") int productNo,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		String url = null;
		String path = System.getProperty("user.dir");
		System.out.println(path);
		try {

			HashMap<String, Object> map = new HashMap<>();
			if (!thumbnailFile.isEmpty()) {
				String originFilename = thumbnailFile.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."));
				String saveFileName = genSaveFileName(extName);
				File thumbnailFileToSave = new File(path + "\\src\\main\\webapp\\uploadImages\\product\\", saveFileName);
				thumbnailFile.transferTo(thumbnailFileToSave);
				map.put("productNo", productNo);
				map.put("productThumbnail", "../uploadImages/product/" + saveFileName);
			}

			// 설명 파일 처리
			if (!descriptionFile.isEmpty()) {
				String originFilename = descriptionFile.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."));
				String saveFileName = genSaveFileName(extName);
				File descriptionFileToSave = new File(path + "\\src\\main\\webapp\\uploadImages\\product\\",
						saveFileName);
				descriptionFile.transferTo(descriptionFileToSave);
				map.put("productDetail1", "../uploadImages/product/" + saveFileName);
			}

			adminMapper.attachProduct(map);

		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:product/product.do";
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

	/*
	 * 
	 * 
	 * 
	 * 디자인관리
	 * 
	 * 
	 * 
	 * 
	 * 
	 */

	// 디자인 관리자 리스트
	@RequestMapping(value = "/design/adminDesign.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String designAdminList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.adminDesignList(map);
		return new Gson().toJson(resultMap);
	}

	/*
	 * 
	 * 
	 * 
	 * 게시판관리
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	// 게시물 삭제
	@RequestMapping(value = "/qna/adminqnaDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String qnadelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.qnaDelete(map);
		return new Gson().toJson(resultMap);
	}
	// 커스텀리스트
	@RequestMapping(value = "/admin/adminCustomList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String adminCustomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.adminCustomList(map);
		return new Gson().toJson(resultMap);
	}
	// 커스텀확정
	@RequestMapping(value = "/admin/adminCustomConfirm.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String adminCustomConfirm(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.customConfirm(map);
		return new Gson().toJson(resultMap);
	}
}
