<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 질문게시판</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">질문관리</h2>
					<div class="search-box">
                        <div class="ip-box ip-ico-box">
				            <input type="text" v-model="searchKeyword" placeholder="게시물제목" @keyup.enter="fnSearchItem">
							<div class="btn-box type1"><button type="button" @click="fnSearchItem">게시물</button></div>
                        </div>
                    </div>
                </div>
                <div class="contents-table">
                    <div class="flex-table qna-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">질문번호</div>
                                <div class="th">아이디</div>
                                <div class="th">제목</div>
                                <div class="th">작성일</div>
                                <div class="th">삭제</div>
                            </div>
                        </div>
						<div class="tbody">
							<div class="tr" v-for="item in list">
								<div class="td">{{item.qnaNo}}</div>
                                <div class="td">{{item.userId}}</div>
                                <div class="td">{{item.qnaTitle}}</div>
                                <div class="td">{{item.udatetime}}</div>
								<div class="tbl-btn-box">
									<button @click="fnDelete(item.qnaNo)" title="삭제" class="remove">삭제</button>
								</div>
							</div>
						</div>
                    </div>
                </div>
            </div>
			<div class="contents-bottom">
				<div class="pagenation">
					<button type="button" class="prev"   @click="fnBeforePage()">이전</button>
					<button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
						{{ page }}
					</button>
					<button type="button" class="next"  @click="fnAfterPage()">다음</button>
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
				list : [],
				searchKeyword : "",
				searchData : "",
				currentPage: 1,      
				pageSize: 11,        
				totalPages: 1,
            };
        },
        methods: {
			fnGetList(page){
				var self = this;
				self.currentPage = page;
				var startIndex = (page-1) *self.pageSize;			
				var outputNumber = self.pageSize;
				var nparmap = {
					startIndex : startIndex,
				 	outputNumber : outputNumber,
					searchData : self.searchData,
					category : self.category,
				    };
				$.ajax({
					url:"/qna/qna_list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						self.totalPages = Math.ceil(data.count/self.pageSize);
					}
				});
	        },
			fnSearchItem(){
				var self = this;
				self.searchData = self.searchKeyword;
				self.fnGetList(1);
			},
			fnDelete(qnaNo){
				var self = this;
				if (!confirm("게시글번호 "+qnaNo+"의 게시물을 삭제하시겠습니까?")) {
				        return;
				    }
				var nparmap = {
					qnaNo : qnaNo
				};
				$.ajax({
					url:"/qna/adminqnaDelete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.message="success"){
							alert("삭제되었습니다.");
							self.fnGetList(1);					
						}else{
							alert("삭제시 문제가 발생하였습니다.");
						}
					}
				});
			},
			fnBeforePage(){
				var self = this;
				if(self.currentPage == 1){
					return;					
				}
				self.currentPage = self.currentPage - 1;
				self.fnGetList(self.currentPage);
			},
			fnAfterPage(){
				var self = this;
				if(self.totalPages == self.currentPage){
					return;
				}
				self.currentPage = self.currentPage + 1;
				self.fnGetList(self.currentPage);
			}
        },
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>