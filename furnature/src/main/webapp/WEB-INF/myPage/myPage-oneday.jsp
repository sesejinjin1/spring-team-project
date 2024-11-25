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
            <p class="blind">마이페이지 - 원데이클래스</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-oneday">
					<h2 class="myPage-tit">원데이클래스 신청내역</h2>			
                    <div v-if="isCustomer">
						<div class="myPage-img-list-wrap">
							<div class="myPage-img-list-box" v-for="item in list">
								<div class="img-box"><img :src="item.filePath" :alt="item.className + '이미지'"></div>
								<div class="tit-box">
									<div class="top">
										<div class="tit">{{item.className}}</div>
										<div class="desc">신청인원 : {{item.count}} </div>
										<div class="desc">신청자 이름 : {{item.userName}} </div>
										<div class="desc" v-if="item.payStatus==1">결제상태: 결제예정</div>
										<div class="desc" v-else>
											결제상태: 결제완료 <br>
											결제번호: {{item.payId}}
										</div>
									</div>
									<div class="price-box">
										<div class="price" v-if="item.payStatus==2">결제 금액 : {{item.price}} </div>
										<div class="price" v-if="item.payStatus==1">결제 예정 금액 : {{item.price}} </div>
									</div>
									<div class="date" v-if="item.payStatus==1">신청일자: {{item.joinDay}}</div>
									<div class="date" v-if="item.payStatus==2">결제일자: {{item.payDay}}</div>
									<div class="result">
										<button type="button" @click="fnCancel(item.classNo)" v-if="item.payStatus==1">수강취소</button>
										<button type="button" @click="fnBuy(item.className, item.classNo, item.price, item.count)" v-if="item.payStatus==1">결제</button>
										<button type="button" @click="fnBuyCancel(item.classNo)" v-if="item.payStatus==2">결제 취소</button>
									</div>
								</div>
							</div>
							<div v-if="!list || list.length === 0">
								<div class="list-none-box"><div class="txt">수강신청 목록이 없습니다</div></div>
							</div>
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
	IMP.init("");
	
    const app = Vue.createApp({
        data() {
            return {
                userId: '${sessionId}',
				sessionAuth : '${sessionAuth}',
                list: [],
				isCustomer : true,
				className : "",
			    payId : "",
				price : "",
				name : "",
				payInfo: {},
				count: ""
            };
        },
        methods: {
            fnClass() {
				var self = this;
				if(self.sessionAuth=='1'){
					self.isCustomer = true;
					var nparmap = { userId: self.userId };
	                $.ajax({
	                   url: "/myPage/oneday-info.dox",
	                   dataType: "json",
	                   type: "POST",
	                   data: nparmap,
	                   success: function(data) {
	                       self.list = data.onedayInfo;
						   self.name = data.onedayInfo[0].userName;
	                   }
	               });
				}else{
					self.isCustomer = false;
				}
            },
			fnBuy(className, classNo, price, count) {
			    var self = this;
				IMP.request_pay({
					pg: "html5_inicis",
					pay_method: "card",
					merchant_uid: 'oneday' + new Date().getTime(),
					name: className,
					amount: price*count,
					buyer_name: self.name,
					buyer_tel: "01012349876",
				}, function (rsp){ 
					//console.log(rsp);
			        if (rsp.success) {
						$.ajax({
							url: "/payment/payment/" + rsp.imp_uid,
							type: "POST",
							data: {
								imp_uid : rsp.imp_uid,
								merchant_uid: rsp.merchant_uid,
                            	amount: rsp.paid_amount,
								name: rsp.buyer_name,
								phone: rsp.buyer_tel
							},
							success: function (data) {
								//console.log(data)
								$.ajax({
									url: "/payment/payment-add.dox",
									method: "POST",
									data: {
										sessionId : self.userId,
										category : "oneday",
										impUid : rsp.imp_uid,
										merchantUid: rsp.merchant_uid,
										amount: rsp.paid_amount,
										name : rsp.buyer_name,
										phone : rsp.buyer_tel,
										orderNo: classNo
									},
									success : function(data){
										self.fnClass();
									}
								});
							}
						}); 
			        } else {
			            alert(rsp.error_msg);
			        }
			    });	
			},
			fnBuyCancel(orderNo) {
				var self = this;
				confirm("결제를 취소하시겠습니까?");
				var nparmap = {classNo: orderNo, category: "oneday", sessionId: self.userId};
				$.ajax({
					url:"/payment/payment-info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.payInfo = data.payInfo;				
						$.ajax({
							url: '/payment/cancel/' + data.payInfo.paymentImpUid,
							method: 'POST',
							data: {
								imp_uid : self.payInfo.paymentImpUid,
								merchant_uid: self.payInfo.paymentMerchantUid,
								amount: self.payInfo.paymentAmount
							},
							success: function(data){
								//console.log(data);
								$.ajax({
									url: "/payment/payment-edit.dox",
									method: "POST",
									data: {
										orderNo : orderNo,
										category : "oneday",
										impUid : self.payInfo.paymentImpUid
									},
									success : function(data){
										if(data.result == 'success') {
											self.fnClass();
										}
									}
								})
							}
						})
					}
				});
			},
			fnCancel(classNo){
				var self = this;
				var nparmap = {classNo:classNo, userId:self.userId}
				if(confirm("수강 신청을 취소하시겠습니까?")){
					$.ajax({
						url:"/myPage/oneday-cancel.dox",
						dataType:"json",
						type:"POST",
						data:nparmap,
						success: function(data){
							self.fnClass();
						}
					})
				}else{
					return;
				}			
			}
        },
        mounted() {
			var self = this;
            self.fnClass();
        }
    });
    app.mount('#app');
</script>

