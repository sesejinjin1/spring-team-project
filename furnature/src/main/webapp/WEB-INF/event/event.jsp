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
            <p class="blind">이벤트 페이지</p>
			<h2 class="sub-tit">경매 리스트</h2>
			<ul class="img-list auction-list">
				<li v-for="item in auctionList" :class="item.auctionStatus == 'E' ? 'end': item.auctionStatus == 'I' ? 'ing' : 'fu'">
					<a href="javascript:void(0);" @click="fnDeatil(item.auctionNo)">
						<figure class="img"><img :src="item.auctionImgPath" :alt="item.auctionTitle + '이미지'"></figure>
					</a>
					<span class="tit">{{item.auctionTitle}}</span>
					<span class="price">
						<template v-if="item.auctionStatus == 'E'">낙찰 금액: {{item.auctionPriceCurrent}}</template>
						<template v-else>현재 경매가 : {{item.auctionPriceCurrent}}</template>
					</span>
					<span class="date">경매 기간 : <br> {{item.startDay}} ~ {{item.endDay}}</span>
					<span class="state">
						<template v-if="item.auctionStatus == 'F'">예정</template>
						<template v-else-if="item.auctionStatus == 'I'">진행중</template>
						<template v-else>종료</template>
					</span>
				</li>
			</ul>			
			<div class="front-btn-box">
				<button type="button" @click="fnRegister">경매등록</button>
			</div>			
			<h2 class="sub-tit">룰렛</h2>
			<div class="roulette-wrap">
				<div class="roulette-box">
					<div class="roulette-img" ref="roulImgBox">
						<img src="/assets/images/roulette_img.png" alt="룰렛 이미지" ref="roulImg">
					</div>
					<div class="roulette-arrow">룰렛 화살표</div>
					<button type="button" class="roulette-btn" @click="fnRouletteBtn" ref="roulBtn">START!</button>
				</div>
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
				sessionId: "${sessionId}",
				statusInfo: [],
				auctionList: [],
            };
        },
        methods: {
            fnAuctionList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/event/auction-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.auctionList = data.auctionList;
					}
				});
            },
			fnDeatil(auctionNo) {
				$.pageChange("auctionDetail.do",{auctionNo: auctionNo});
			},
			fnRouletteBtn() {
				var self = this;
				if(self.sessionId != "" && self.sessionId != 'admin') {
					var self = this;
					var nparmap = {sessionId: self.sessionId};
					$.ajax({
						url:"/event/auction-roulette.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							//console.log(data);
							if(data.roulette.eventRoul == "Y") {
								self.fnRoulette();
							} else{
								alert("오늘은 이미 참여하셨습니다.");
							}
						}
					});
				} else {
					if(self.sessionId == 'admin') {
						alert("관리자는 참여 불가합니다.");
					} else {
						alert("로그인 후 이용이 가능합니다.");						
					}
				}
			},
			fnRoulette() {
				var self = this;
				var ranNum = Math.round(Math.random() * 5) + 1;
				var num = 0;
				var rouletteRotate = setInterval(() => {
					num++;
					self.$refs.roulImgBox.style.transform = "rotate(" + 360 * num + "deg)";
					if(num == 20) {
						clearInterval(rouletteRotate);
						self.$refs.roulImg.style.transform = "rotate(" + 60 * ranNum + "deg)";
					}
				},50);
				var point;
				var alerting = setTimeout(() => {
					switch(ranNum) {
						case 2:
							alert("50포인트 당첨!");
							point = 50;
						break;
						case 4:
							alert("10포인트 당첨!");
							point = 10;
						break;
						case 6:
							alert("100포인트 당첨!");
							point = 100;
						break;
						default:
							alert("꽝! 내일 다시 도전해주세요");
					}
					var nparmap = {sessionId: self.sessionId, roulette: "N", mileage: point};
					$.ajax({
						url:"/event/auction-roulette.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							console.log(data);
						}
					});
				},2800);
			},
			fnRegister() {
				$.pageChange("auctionRegister.do",{});
			}
        },
        mounted() {
            var self = this;
			self.fnAuctionList();
        }
    });
    app.mount('#app');
</script>