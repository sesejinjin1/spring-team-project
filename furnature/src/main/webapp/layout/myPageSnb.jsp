<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2 class="myPage-tit">마이페이지</h2>
<nav class="myPage-snb">
	<ul>
		<li><a href="/myPage/myPage.do" class="${activePage == "myPage" ? "active" : ""}">내정보</a></li>
		<li><a href="/myPage/payment.do" class="${activePage == "payment" ? "active" : ""}">상품구매 리스트</a></li>
		<li><a href="/myPage/delivery.do" class="${activePage == "delivery" ? "active" : ""}">배송정보</a></li>
		<li><a href="/myPage/oneday.do" class="${activePage == "oneday" ? "active" : ""}">원데이클래스</a></li>
		<li><a href="/myPage/bidding.do" class="${activePage == "bidding" ? "active" : ""}">경매 리스트</a></li>
		<li><a href="/myPage/mileage.do" class="${activePage == "mileage" ? "active" : ""}">마일리지 리스트</a></li>
	</ul>
</nav>