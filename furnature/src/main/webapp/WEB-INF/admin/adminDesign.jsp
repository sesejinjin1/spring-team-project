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
                    <h2 class="admin-tit">디자인 추천</h2>
                </div>
                <div class="contents-table">
                    <div class="flex-table design-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">디자인번호</div>
                                <div class="th">사용자</div>
                                <div class="th">디자인타이틀</div>
                                <div class="th">디자인선택</div>
                                <div class="th">등록날짜</div>
                                <div class="th">삭제</div>
                            </div>
                        </div>
						<div class="tbody">
							<div class="tr" v-for="item in designList">
								<div class="td">{{item.designNo}}</div>
                                <div class="td">{{item.userId}}</div>
                                <div class="td">{{item.designTitle}}</div>
                                <div class="td">{{item.designChoice}}</div>
                                <div class="td">{{item.designCdateTime}}</div>
								<div class="tbl-btn-box">
									<button @click="fnDelete(item.designNo)" title="삭제" class="remove">삭제</button>
								</div>
							</div>
						</div>
                    </div>
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
				designList : [],
				cateList : [],
				searchKeyword : "",
				keyword : "",
				cateNum : "",
				width : "",
				depth : "",
				height : "",
				currentPage: 1,      
				pageSize: 11,        
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
					url:"/design/adminDesign.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						
						self.designList = data.list;
						self.totalPages = Math.ceil(data.count/self.pageSize);								
					}
				});				 
			},
			fnSearchItem(){
				var self = this;
				self.keyword = self.searchKeyword;
				self.fnGetProductList(1);
			},
			fnDelete(designNo){
				var self = this;
				if (!confirm("디자인 번호 "+designNo+"의 게시물을 삭제하시겠습니까?")) {
				        return;
				    }
				var nparmap = {
					designNo : designNo
				};
				$.ajax({
					url:"/design/designDelete.dox",
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
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductList(1);
        }
    });
    app.mount('#app');
</script>