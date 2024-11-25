<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="snb">
	<li><a href="/admin.do" class="${activePage == "admin" ? "active" : ""}">유저 정보</a></li>
	<li><a href="/productmanage.do" class="${activePage == "product" ? "active" : ""}">상품 관리</a></li>
	<li><a href="/adminDelivery.do" class="${activePage == "delivery" ? "active" : ""}">배송 관리</a></li>
	<li><a href="/adminOneday.do" class="${activePage == "oneday" ? "active" : ""}">원데이 클래스 정보</a></li>
	<li><a href="/adminDesign.do" class="${activePage == "design" ? "active" : ""}">디자인추천 관리</a></li>
	<li><a href="/adminQna.do" class="${activePage == "qna" ? "active" : ""}">질문 게시판 관리</a></li>
	<li><a href="/adminCustom.do" class="${activePage == "custom" ? "active" : ""}">커스텀 신청 관리</a></li>
</ul>

