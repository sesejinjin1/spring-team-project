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
		<div id="container">            
            <p class="blind">경매 상세 페이지</p>
			<div class="detail-top">
				<div class="thumb-wrap auction-detail-thumb-list">
					<div class="thumb-list">
						<div class="thumb-box" v-for="(item, index) in detailImgListPath">
							<img :src="item" :alt="detailInfo.auctionTitle + ' 썸네일이미지' + (index+1)">
						</div>
					</div>
					<div class="thumb-arrow">
						<button type="button" class="prev">이전</button>
						<button type="button" class="next">다음</button>
					</div>
				</div>
				<div class="detail-top-info">
					<div class="detail-box">
						<div class="tit">입찰</div>
						<div class="info">
							<template v-if="detailInfo.auctionStatus == 'F'">
								<div>경매 시작 전 입니다.</div>
							</template>
							<template v-else-if="detailInfo.auctionStatus == 'I'">
								<div class="ip-box ip-ico-box type2">
									<input type="text" placeholder="입찰 금액을 입력해주세요" v-model="biddingPrice">
									<div class="btn-box type2"><button type="button" @click="fnBidding">입찰</button></div>
								</div>
							</template>
							<template v-else-if="detailInfo.auctionStatus == 'E'">
								<div>종료 된 경매입니다.</div>
							</template>
						</div>
					</div>
					<div class="detail-box">
						<div class="tit">경매번호</div>
						<div class="info">{{detailInfo.auctionNo}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">제목</div>
						<div class="info">{{detailInfo.auctionTitle}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">시작 금액</div>
						<div class="info">{{detailInfo.auctionPrice}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">현재 금액</div>
						<div class="info">{{detailInfo.auctionPriceCurrent}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">경매 기간</div>
						<div class="info">{{detailInfo.startDay}} ~ {{detailInfo.endDay}}</div>
					</div>
				</div>
			</div>
			<div class="detail-tab">
				<button type="button" @click="fnTab(1)" :class="bottomBox == '1' ? 'active' : ''">상세 정보 설명</button>
				<button type="button" @click="fnTab(2)" :class="bottomBox == '2' ? 'active' : ''">배송 및 교환 정보</button>
			</div>
			<div class="detail-bottom">
				<div class="detail-bottom-box" v-if="bottomBox == '1'">
					<img :src="detailInfo.auctionContentsImgPath" :alt="detailInfo.auctionTitle + '상세이미지'">
					<div>{{detailInfo.auctionContents}}</div>
				</div>
				<div class="detail-bottom-box" v-if="bottomBox == '2'">
					<jsp:include page="/layout/delivery.jsp"></jsp:include>
				</div>
			</div>
			<div class="front-btn-box">				
				<template v-if="sessionAuth > 1">					
					<button type="button" @click="fnEdit(auctionNo)">수정</button>
					<button type="button" @click="fnRemove(auctionNo)">삭제</button>
				</template>
				<button type="button" @click="fnListMove">목록</button>
			</div>	
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : "${sessionId}",
				sessionAuth : "${sessionAuth}",
				auctionNo : "${auctionNo}",
				detailImgList : [],
				detailImgListPath : [], 
				detailInfo : {},
				biddingPrice : "",
				bottomBox : 1
            };
        },
        methods: {
            fnAuctionDetail(){
				var self = this;
				var nparmap = {auctionNo: self.auctionNo};
				$.ajax({
					url:"/event/auction-detail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						for(var img of data.detailList) {
							self.detailImgList.push(img.auctionImgName);
							self.detailImgListPath.push(img.auctionImgPath);
						}
						self.detailInfo = data.detailList[0];	
						self.updateData();					
					}
				});
            },
			fnEdit(auctionNo) {
				$.pageChange("auctionRegister.do", {auctionNo: auctionNo});
			},
			fnRemove(auctionNo) {
				if(!confirm("삭제하시겠습니까?")) return;
				var self = this;
				var imgList = JSON.stringify(self.detailImgList);
				var nparmap = {auctionNo: self.auctionNo, auctionTumb: self.detailImgList, auctionDetail: self.detailInfo.auctionContentsImgName};
				$.ajax({
					url:"/event/auction-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.result == "success") {
							$.pageChange("event.do",{});
						} else {
							alert(data.file);
						}
					}
				});
			},
			fnBidding(){
				var self = this;
				if(self.sessionId != "") {
					if(self.sessionId == 'admin') {
						alert("관리자는 입찰 불가합니다"); 
						return;
					}
					if(self.biddingPrice < 0) {
						alert("입찰 금액은 음수는 입력이 불가합니다.");
						return;
					} else if(self.biddingPrice <= self.detailInfo.auctionPriceCurrent) {
						alert("현재 입찰가보다 큰 금액이어야 입찰에 가능합니다.");
						return;
					}
					var nparmap = {auctionNo: self.auctionNo, sessionId: self.sessionId, biddingPrice: self.biddingPrice};
					$.ajax({
						url:"/event/auction-bidding.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							console.log(data);
							if(data.result == "success") {
								self.detailImgList = [];
								self.detailImgListPath = []; 
								self.detailInfo = {};
								self.fnAuctionDetail();
								alert("입찰 되었습니다.");
							}
						}
					});
				} else {
					alert("로그인 후 입찰이 가능합니다.");
				}
			},
			updateData() {
				var self = this;
				self.$nextTick(() => {
					$.sliderEvent();
				});
			},
			fnTab(num) {
				var self = this;
				self.bottomBox = num;
			},
			fnListMove() {
				$.pageChange("/event/event.do", {});
			}		
        },
        mounted() {
			var self = this;
			self.fnAuctionDetail();	
        }
    });
    app.mount('#app');		
</script>