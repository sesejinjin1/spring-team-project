<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 디자인추천</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">배송현황</h2>
					<div class="search-box">
	                    <div class="ip-box ip-ico-box">
				            <input type="text" v-model="searchKeyword" placeholder="주문번호" @keyup.enter="fnSearchItem">
							<div class="btn-box type1"><button type="button" @click="fnSearchItem">주문번호검색</button></div>
	                    </div>
	                </div>
                </div>
                <div class="contents-table">
                    <div class="flex-table delivery-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">주문번호</div>
                                <div class="th">구매자아이디</div>
                                <div class="th">상품이름</div>
                                <div class="th">구매수량</div>
                                <div class="th">배달현황</div>
								<div class="th">기능</div>
                            </div>
                        </div>
						<div class="tbody">
							<div class="tr" v-for="item in list">
								<div class="td">{{item.orderId}}</div>
                                <div class="td">{{item.userId}}</div>
                                <div class="td">{{item.productName}}</div>
                                <div class="td">{{item.orderCount}}</div>
								<div class="td">
									<div class="select-box">
										<select v-model="item.deliveryCate">
											<option value="0">상품준비중</option>
											<option value="1">배송준비중</option>
											<option value="2">배송중</option>
											<option value="3">배송완료</option>
										</select>
									</div>
								</div>
								<div class="td">
                                    <div class="tbl-btn-box">
										<button  @click="fnUpdate(item.deliveryCate,item.orderId)"  title="수정" class="edit">수정</button>
                                    </div>
                                </div>
							</div>
						</div>
                    </div>
                </div>
            </div>
            <div class="contents-bottom">
				<div class="pagenation">
	                <button type="button" class="prev"  @click="fnBeforPage()">이전</button>
	                <button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnDelivery(page)">
						{{page}}
					</button>
	                <button type="button" class="next"  @click="fnNextPage()">다음</button>
	            </div>
            </div>
        </div>
	</div>
</body>
</html>
<script>
	const app = Vue.createApp({
	        data() {
	            return {
	                sessionId: '${sessionId}',
					productNo : "",
					searchKeyword : "",
					keyword : "",
					currentPage: 1,      
					pageSize: 11,        
					totalPages: 1,
	                list: []
	            };
	        },
	        methods: {
	            fnDelivery(page) {
	                var self = this;
					var startIndex = (page-1) *self.pageSize;			
					self.currentPage = page;
					var outputNumber = this.pageSize;
	                var nparmap = { 
						startIndex : startIndex,
				 	    outputNumber : outputNumber,
						keyword : self.keyword
					};
	                $.ajax({
	                    url: "/admin/admin-delivery.dox",
	                    dataType: "json",
	                    type: "POST",
	                    data: nparmap,
	                    success: function(data) {
							console.log(data);
	                        self.list = data.list;
							self.totalPages = Math.ceil(data.count/self.pageSize);
	                    }
	                });
	            },
				fnUpdate(deliveryCate,orderId){
					var self = this;
	                var nparmap = { 
						deliveryCate : deliveryCate,
						orderId : orderId
					};
	                $.ajax({
	                    url: "/admin/admin-deliveryUpdate.dox",
	                    dataType: "json",
	                    type: "POST",
	                    data: nparmap,
	                    success: function(data) {
							alert("배송이 수정 되었습니다.");
							self.fnDelivery(1);
	                    }
	                });
				},
				fnSearchItem(){
					var self = this;
					self.keyword = self.searchKeyword;
					self.fnDelivery(1);
				},
				fnBeforPage(){
					var self = this;
					if(self.currentPage == 1){
						return;
					}
					self.currentPage = self.currentPage - 1;
					self.fnDelivery(self.currentPage);
				},
				fnNextPage(){
					var self = this;
					if(self.totalPages == self.currentPage){
						return;
					}
					self.currentPage = self.currentPage + 1;
					self.fnDelivery(self.currentPage);
				},
				
	        },
	        mounted() {
	            var self = this;
				self.fnDelivery(1);
	        }
	    });
	    app.mount('#app');
</script>