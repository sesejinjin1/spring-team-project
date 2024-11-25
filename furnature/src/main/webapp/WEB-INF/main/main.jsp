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
		<div id="container" class="main">            
            <p class="blind">메인페이지</p>
			<div id="main-visual">
				<div class="visual-wrap">
					<div class="visual-list">
						<div class="visual-box">
							<a href="javascript:void(0)" @click="fnMovePage('product')">
								<div class="txt-box">
									<span class="tit">furnature 가구 구매</span>
									<span class="desc">furnature만의 커스텀 가구 및 감각적인 가구를 구매</span>
								</div>
							</a>
						</div>
						<div class="visual-box">
							<a href="javascript:void(0)" @click="fnMovePage('oneday')">
								<div class="txt-box">
									<span class="tit">furnature 원데이 클래스</span>
									<span class="desc">furnature의 전문가와 함께하는 공방</span>
								</div>
							</a>
						</div>
						<div class="visual-box">
							<a href="javascript:void(0)" @click="fnMovePage('event')">
								<div class="txt-box">
									<span class="tit">furnature 이벤트</span>
									<span class="desc">furnature만에서 제공하는 이벤트</span>
								</div>
							</a>
						</div>
					</div>
				</div>
				<div class="visual-arrow">
					<button type="button" class="arrow prev">이전</button>
					<button type="button" class="arrow next">다음</button>
				</div>
			</div>
			<div id="main-contents">
				<div class="main-content">
					<h2 class="main-tit">커스텀 가구</h2>
					<div class="main-product-wrap">
						<div class="main-product-box" v-for="item in proList">
							<a href="javascript:void(0);" class="img-box" @click="fnChangePage('product', item.productNo)">
								<img :src="item.productThumbnail" :alt="item.productName + '이미지'">
								<span class="txt-box">
									<span class="tit">{{item.productName}}</span>
									<span class="price">{{item.productPrice}}원</span>
								</span>
							</a>
						</div>
					</div>
				</div>	
				<div class="main-content">
					<div class="main-divide">
						<div class="left">
							<h2 class="main-tit">원데이 클래스</h2>
							<div class="divide-wrap">
								<div class="divide-box" v-for="item in oneList">
									<a href="javascript:void(0);" class="img-box" @click="fnChangePage('class', item.classNo)">
										<img :src="item.thumbPath" :alt="item.className + '이미지'">
									</a>
									<div class="txt-box">
										<p class="tit">{{item.className}}</p>
										<p class="price">수강료: {{item.price}}원</p>
										<p class="date">강의 일자: {{item.classDate}}</p>
									</div>
								</div>
							</div>
						</div>
						<div class="right">
							<h2 class="main-tit">이벤트 경매</h2>
							<div class="divide-wrap">
								<div class="divide-box" v-for="item in aucList">
									<a href="javascript:void(0);" class="img-box" @click="fnChangePage('auction', item.auctionNo)">
										<img :src="item.auctionImgPath" :alt="item.auctionTitle + '이미지'">
									</a>
									<div class="txt-box">
										<p class="tit">{{item.auctionTitle}}</p>
										<p class="price">경매가: {{item.auctionPriceCurrent}}원</p>
										<p class="date">경매 종료 일자: {{item.endDay}}</p>
									</div>
								</div>
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
<script>
    const app = Vue.createApp({
        data() {
            return {
				proList: [],
				oneList: [],
				aucList: []
            };
        },
        methods: {
            fnProList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/main/main-product.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.proList = data.list;
					}
				});
            },
			fnOneList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/main/main-oneday.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.oneList = data.list;
					}
				});
            },
			fnAucList() {
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/main/main-auction.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.aucList = data.list;
					}
				});
            },
			fnChangePage(category, num) {
				if(category == "product") {
					$.pageChange("/productDetail/productDetail.do", {productNo: num});
				} else if(category == "class") {
					$.pageChange("/oneday/oneday-join.do", {classNo: num});
				} else if(category == "auction") {
					$.pageChange("/event/auctionDetail.do", {auctionNo: num});
				}
			},
			fnMovePage(tit) {
				$.pageChange("/"+ tit +"/" + tit + ".do", {});
			}
        },
        mounted() {
            var self = this;
			self.fnProList();
			self.fnOneList();
			self.fnAucList();
			$.mainSlider();
        }
    });
    app.mount('#app');
</script>