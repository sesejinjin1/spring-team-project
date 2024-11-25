<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
	<div id="app">
		<div id="container" class="myPage">            
            <p class="blind">마이페이지 - 경매 리스트</p>
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					<h2 class="myPage-tit">경매 리스트</h2>
					<div class="myPage-img-list-wrap">
						<div class="myPage-img-list-box" v-for="item in biddingList">
							<div class="img-box">
								<img :src="item.auctionImgPath" :alt="item.auctionTitle + '이미지'">
							</div>
							<div class="tit-box">
								<div class="top">
									<div class="num">No.{{item.auctionNo}}</div>
									<div class="tit">{{item.auctionTitle}}</div>
									<div class="price-box">
										<div class="myPrice">내 입찰 금액 : {{item.myBidding}}</div>
										<div class="price">최고 입찰 금액 : {{item.auctionPriceCurrent}}</div>
									</div>
									<div class="date">입찰 일자 : {{item.auctionBiddingDate}}</div>
									<div class="end-day">마감일 : {{item.endDay}}</div>
								</div>
								<div class="result">
									<template v-if="item.auctionStatus == 'E'">
										<template v-if="item.auctionPriceCurrent == item.myBidding">
											<template v-if="item.paymentStatus == '' || item.paymentStatus == null">
												<p class="desc wait">
													최고 입찰 금액으로 입찰되었습니다. <br>
													제품 구매를 진행해 주세요.
												</p>
												<button @click="fnBuy(item.auctionTitle, item.myBidding, item.userInfo.split(',')[0], item.userInfo.split(',')[1], item.auctionNo)">결제하기</button>
											</template>
											<template v-else-if="item.paymentStatus == 'P'">
												<p class="desc buy">
													결제가 완료 되었습니다. <br>
													배송 관련 정보는 마이페이지 > 배송정보에서 확인 가능합니다.
												</p>
												<button @click="fnBuyCancel(item.auctionNo)">취소하기</button>
											</template>
											<template v-else>
												<p class="desc">결제가 취소 된 입찰 품목 입니다.</p>
											</template>
										</template>
										<template v-else>
											<p class="desc">
												최고 입찰 금액 이용자에게 입찰되었습니다. <br>
												다른 경매에도 많은 참여해주세요.
											</p>
										</template>
									</template>
									<template v-else>
										<button type="button" @click="fnCancel(item.auctionNo)">입찰취소</button>
									</template>
								</div>
							</div>
						</div>
						<div v-if="!biddingList || biddingList.length === 0">
							<div class="list-none-box"><div class="txt">경매 입찰 목록이 없습니다</div></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	const userCode = ""; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				biddingList : [],
				infoList: [],
				cancelInfo: {}
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.biddingList = data.biddingList;
					}
				});
            },
			fnCancel(auctionNo){
				if(!confirm("입찰을 취소 하시겠습니까?")) return;
				var self = this;
				var nparmap = {auctionNo: auctionNo, sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/bidding-cancel.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.result =="success") {
							self.fnGetList();
							alert(data.message);
						}
					}
				});
			},
			fnBuy(title, myBidding, name, phone, orderNo){
				var self = this;
				IMP.request_pay({
	                pg: "html5_inicis",
	                pay_method: "card",
	                merchant_uid: "auction" + new Date().getTime(), // 유니크한 주문 ID 생성
	                name: title,
	                amount: myBidding,
					buyer_name: name,
					buyer_tel: phone,
	            }, function (rsp) {
					//console.log(rsp);
					if (rsp.success) {
                        $.ajax({
                            url: "/payment/payment/" + rsp.imp_uid,
                            method: "POST",
							data: {
								imp_uid : rsp.imp_uid,
								merchant_uid: rsp.merchant_uid,
                            	amount: rsp.paid_amount,
								name: name,
								phone: phone
							},
							success : function (data) {
								$.ajax({
									url: "/payment/payment-add.dox",
									method: "POST",
									data: {
										sessionId : self.sessionId,
										category : "auction",
										impUid : rsp.imp_uid,
										merchantUid: rsp.merchant_uid,
										amount: rsp.paid_amount,
										name : rsp.buyer_name,
										phone : rsp.buyer_tel,
										orderNo: orderNo
									},
									success : function(data){
										if(data.result == 'success') {
											self.fnGetList();
										}
									}
								});
							}
                        })
                    } else {
                        alert(rsp.error_msg);
                    }
	            });
			},
			fnBuyCancel(orderNo) {
				var self = this;
				var nparmap = {auctionNo: orderNo, category: "auction", sessionId: self.sessionId};
				$.ajax({
					url:"/payment/payment-info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {				
						$.ajax({
							url: '/payment/cancel/' + data.payInfo.paymentMerchantUid,
							method: 'POST',
							data: {
								imp_uid : data.payInfo.paymentImpUid,
								merchant_uid: data.payInfo.paymentMerchantUid,
								amount: data.payInfo.paymentAmount
							},
							success: function(data){
								console.log(data);
								$.ajax({
									url: "/payment/payment-edit.dox",
									method: "POST",
									data: {
										orderNo : orderNo,
										category : "auction",
									},
									success : function(data){
										if(data.result == 'success') {
											self.fnGetList();
										}
									}
								})
							}
						})
					}
				});
			},
			fnInsert(rsp){
				var self = this;
				var nparmap = {name: rsp.name, price: rsp.paid_amount, productId: rsp.merchant_uid};
				$.ajax({
					url:"/api/payment.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						//console.log(data);
					}
				});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>