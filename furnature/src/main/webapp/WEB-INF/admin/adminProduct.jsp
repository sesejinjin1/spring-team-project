<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 유저 정보</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">상품 정보</h2>
                    <div class="search-box">
                        <div class="ip-box ip-ico-box">
				            <input type="text" v-model="searchKeyword" placeholder="상품이름" @keyup.enter="fnSearchItem">
							<div class="btn-box type1"><button type="button" @click="fnSearchItem">상품검색</button></div>
                        </div>
                    </div>
                </div>
                <div class="contents-table">
                    <div class="flex-table product-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">상품번호</div>
                                <div class="th">상품명</div>
                                <div class="th">상품가격</div>
                                <div class="th">색상</div>
                                <div class="th">커스텀유무</div>
                                <div class="th">삭제</div>
                            </div>
                        </div>
						<div class="tbody">
							<div class="tr" v-for="item in productList">
								<div class="td">{{item.productNo}}</div>
                                <div class="td">{{item.productName}}</div>
                                <div class="td">{{item.productPrice}}</div>
                                <div class="td">{{item.productColor}}</div>
                                <div class="td">{{item.productCustom}}</div>
								<div class="td">
                                    <div class="tbl-btn-box">
										<button  @click="fnUpdate(item.productNo)"  title="수정" class="edit">수정</button>
										<button  @click="fnDelete(item.productNo)" title="삭제" class="remove">삭제</button>     
                                    </div>
                                </div>
							</div>
						</div>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn" @click="fnRegist">등록</button>
                </div>
            </div>
            <div class="contents-bottom">
				<div class="pagenation">
	                <button type="button" class="prev"  @click="fnBeforPage()">이전</button>
	                <button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetProductList(page)">
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
				productList : [],
				cateList : [],
				searchKeyword : "",
				keyword : "",
				cateNum : "",
				width : "",
				depth : "",
				height : "",
				currentPage: 1,      
				pageSize: 12,        
				totalPages: 1,
				widthSize : "",
				depthSize : "",
				heightSize: ""
            };
        },
        methods: {
			fnGetProductList(page){
				var self = this;
				var startIndex = (page-1) *self.pageSize;			
				self.currentPage = page;
				var outputNumber = this.pageSize;
				var nparmap = {
					startIndex : startIndex,
			 	    outputNumber : outputNumber,
					cateNum : self.cateNum,
					keyword : self.keyword
				};
				$.ajax({
					url:"/manage/productManage.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.productList = data.productList;
						self.totalPages = Math.ceil(data.count/self.pageSize);								
					}
				});				 
			},
			fnSearchItem(){
				var self = this;
				self.keyword = self.searchKeyword;
				self.fnGetProductList(1);
			},
			fnUpdate(productno){
				var self = this;
				$.pageChange("/productRegist.do",{productNo : productno});
			},
			fnDelete(productno){
				var self = this;
				if (!confirm("상품번호"+productno+"의 게시물을 삭제하시겠습니까?")) {
				        return;
				    }
				var nparmap = {
					productNo : productno
				};
				$.ajax({
					url:"/manage/productDelete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.message="success"){
							alert("삭제되었습니다.");
							self.fnGetProductList(1);					
						}else{
							alert("삭제시 문제가 발생하였습니다.");
						}
					}
				});
			},
			fnBeforPage(){
				var self = this;
				if(self.currentPage == 1){
					return;
				}
				self.currentPage = self.currentPage - 1;
				self.fnGetProductList(self.currentPage);
			},
			fnNextPage(){
				var self = this;
				if(self.totalPages == self.currentPage){
					return;
				}
				self.currentPage = self.currentPage + 1;
				self.fnGetProductList(self.currentPage);
			},
			fnRegist(){
				location.href="/productRegist.do"
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductList(1);
        }
    });
    app.mount('#app');
</script>