<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container" class="myPage">            
            <p class="blind">마이페이지 - 구매내역</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-info">
					<h2 class="myPage-tit">상품 구매내역</h2>			
					<div class="myPage-img-list-wrap">
						<div class="myPage-img-list-box" v-for="item in list">
							<div class="img-box">
								<a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)"><img :src="item.productThumbnail"></a>
							</div>
							<div class="tit-box">
								<div class="top">
									<div class="tit"><a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)">{{item.productName}}</a></div>
									<div class="desc">선택옵션 : {{item.orderSize}} </div>
									<div  class="desc">상품가격 : {{item.productPrice}} </div>
									<div class="desc" >주문번호: {{item.orderId}}</div>
									<div  class="desc">결제금액 : {{item.paymentAmount}} </div>
									<div v-if="item.paymentStatus=='P'" class="desc">결제상태: 결제완료</div>
									<div class="desc" v-else >결제상태: 결제취소</div>
									<div class="date">결제일자: {{item.paymentPayDate}}</div>
								</div>
								<div class="result">
									<template v-if="item.paymentStatus == 'P'">
										<p class="desc buy">
											결제가 완료 되었습니다.
										</p>
										<button @click="fnBuyCancel(item.orderNo, item.orderId)">결제 취소</button>
									</template>
									<template v-else>
										<p class="desc wait">결제가 취소 된 품목 입니다.</p>
									</template>
								</div>
							</div>
						</div>
					</div>
					<div v-if="!list || list.length === 0">
						<div class="list-none-box"><div class="txt">구매 목록이 없습니다</div></div>
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
	IMP.init("");
	
    const app = Vue.createApp({
        data() {
            return {
                userId: '${sessionId}',
                list : []
            };
        },
        methods: {
            fnOrderInfo() {
				var self = this;
				var nparmap = { userId: self.userId };
					
	                $.ajax({
	                   url: "/myPage/payment.dox",
	                   dataType: "json",
	                   type: "POST",
	                   data: nparmap,
	                   success: function(data) {
							//console.log(data);
							//console.log(data.list);
							self.list = data.list;
	                   }
	               });
			},
			fnProDetail(productNo, orderCate){
	            if(orderCate == "상품") {
	                $.pageChange("/productDetail/productDetail.do",{productNo : productNo});
	            } else if(orderCate == "경매") {
	                $.pageChange("/event/auctionDetail.do",{auctionNo : productNo});
	            }
			},
			fnBuyCancel(orderNo , orderId) {
				var self = this;
				var nparmap = {productNo: orderNo, category: "product", sessionId: self.userId, orderId : orderId};
				$.ajax({
					url:"/payment/payment-info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);				
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
										category : "product",
										userId : self.userId,
										orderId : orderId
									},
									success : function(data){
										if(data.result == 'success') {
											self.fnOrderInfo();
										}
									}
								})
							}
						})
					}
				});
			}
        },
        mounted() {
			var self = this;
            self.fnOrderInfo();
        }
    });
    app.mount('#app');
</script>

