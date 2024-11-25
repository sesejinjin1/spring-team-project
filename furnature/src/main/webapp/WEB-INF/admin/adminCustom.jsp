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
                    <h2 class="admin-tit">커스텀 신청 목록</h2>
                </div>
                <div class="contents-table">
                    <div class="flex-table custom-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">신청아이디</div>
                                <div class="th">커스텀 제품이름</div>
                                <div class="th">상품번호</div>
                                <div class="th">전화번호</div>
                                <div class="th">확정</div>
                            </div>
                        </div>
						<div class="tbody">
							<div class="tr" v-for="item in list">
								<div class="td">{{item.userId}}</div>
                                <div class="td">{{item.productName}}</div>
                                <div class="td">{{item.productNo}}</div>
                                <div class="td">{{item.userPhone}}</div>
								<div class="td">
				                    <div class="tbl-btn-box">
										<button  @click="fnCustom(item.userId,item.productNo)"  title="커스텀확정" class="check">커스텀확정</button>
				                    </div>
				                </div>
							</div>
						</div>
                    </div>
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
					userId : "",
					productNo : "",
	                list: []
	            };
	        },
	        methods: {
	            fnDelivery() {
	                var self = this;
	                var nparmap = { 
					};
	                $.ajax({
	                    url: "/admin/adminCustomList.dox",
	                    dataType: "json",
	                    type: "POST",
	                    data: nparmap,
	                    success: function(data) {
							console.log(data);
	                        self.list = data.list;
	                    }
	                });
	            },
				fnCustom(userId,productNo){
					var self = this;
					var nparmap = { 
						userId : userId,
						productNo : productNo
					};
	                $.ajax({
	                    url: "/admin/adminCustomConfirm.dox",
	                    dataType: "json",
	                    type: "POST",
	                    data: nparmap,
	                    success: function(data) {
							console.log(data);
							alert("커스텀이 확정되었습니다");
	                    }
	                });					
				}
	        },
	        mounted() {
	            var self = this;
				self.fnDelivery();
	        }
	    });
	    app.mount('#app');
</script>