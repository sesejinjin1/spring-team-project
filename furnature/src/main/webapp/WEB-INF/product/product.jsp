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
            <p class="blind">기본페이지</p>
			<!--카테고리 리스트 출력 -->
			<div class="tab-default">
				<button type="button" @click="fnCateSearchList('')" :class="cateNum == '' ? 'active':''">전체</button>
				<button type="button" @click="fnCateSearchList(item.cateNo)" v-for="(item, index) in cateList" :class="cateNum == (index+1) ? 'active':''">{{item.cateName}}</button>
			</div>
			<div class="product-search-wrap">
				<div class="ip-box ip-ico-box">
					<input type="text" v-model="searchKeyword" placeholder="상품이름 입력" @keyup.enter="fnSearchItem">
					<div class="btn-box type1"><button type="button" @click="fnSearchItem">상품검색</button></div>
				</div>
				<!--치수 측정-->
				<div class="size-box">
					<div class="ip-box">
						<input type="text" v-model="widthSize" @input="validateInput('widthSize')" placeholder="가로 width(mm) 입력" @keyup.enter="fnSearchSize">
					</div>
			  		<div class="ip-box">
						<input type="text" v-model="depthSize" @input="validateInput('depthSize')" placeholder="세로 depth(mm) 입력" @keyup.enter="fnSearchSize">
					</div>
					<div class="ip-box">
						<input type="text" v-model="heightSize" @input="validateInput('heightSize')" placeholder="높이 height(mm) 입력" @keyup.enter="fnSearchSize">
					</div>
					<button type="button" @click="fnSearchSize" class="search">치수검색</button>
				</div>
			</div>
			<!--상품 리스트출력 -->
			<ul class="img-list product-list">
				<li v-for="item in productList">
					<a href="javascript:void(0);" @click="fnPorductDetail(item.productNo)">
						<figure class="img"><img :src="item.productThumbnail"></figure>
					</a>
					<span class="tit">{{item.productName}}</span>
					<span class="price">{{item.productPrice}}원</span>
					<span class="date">{{item.productSize1}}<span>
					<template v-if="item.productCustom == 'Y'">
						<span class="custom">C</span>
					</template>
				</li>
			</ul>
			<!--페이징처리-->
			<div class="pagenation">
                <button type="button" class="prev"  @click="fnBeforPage()">이전</button>
                <button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetProductList(page)">
					{{page}}
				</button>
                <button type="button" class="next"  @click="fnNextPage()">다음</button>
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
					width : self.width,
					depth : self.depth,
					height: self.height,
					startIndex : startIndex,
			 	    outputNumber : outputNumber,
					cateNum : self.cateNum,
					keyword : self.keyword
				};
				$.ajax({
					url:"/product/productList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.productList = data.productList;
						self.totalPages = Math.ceil(data.count/self.pageSize);								
					}
				});				 
			},
            fnGetCateList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/product/cateList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.cateList = data.list;
						
					}
				});
			},
			fnCateSearchList(num){
				var self = this;
				self.cateNum = num;
				self.fnGetProductList(1);
			},
			fnSearchSize(){
				var self = this;
				if(self.widthSize.length > 4 || self.depthSize.length > 4 || self.heightSize.length > 4){
					alert("4자리 이하로 입력해주세요");
					return;
				}
				self.width = self.widthSize;
				self.depth = self.depthSize;
				self.height = self.heightSize;
				self.fnGetProductList(1);
				
			},
			//치수측정시 숫자만 입력 정규식
			validateInput(field) {
				 var self = this;
			     var value = self[field];
			     value = value.replace(/[^0-9]/g, '');
			     self[field] = value;
			},
			fnSearchItem(){
				var self = this;
				self.keyword = self.searchKeyword;
				self.fnGetProductList(1);
			},
			fnPorductDetail(productNo){
				$.pageChange("/productDetail/productDetail.do",{productNo : productNo});
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
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductList(1);
			self.fnGetCateList();
        }
    });
    app.mount('#app');
</script>