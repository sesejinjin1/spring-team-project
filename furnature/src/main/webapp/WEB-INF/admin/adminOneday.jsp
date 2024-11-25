<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 원데이클래스 정보</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">원데이클래스 현황</h2>
                    <div class="search-box">
                        <div class="select-box">
                            <select name="searchOption" id="searchOption" v-model="searchOption">
                                <option value="all">전체</option>
                                <option value="className">클래스명</option>
                                <option value="endDay">마감일</option>
                            </select>
                        </div>
                        <div class="ip-box ip-ico-box">
                            <input type="text" placeholder="클래스명을 입력해주세요" v-model="keyword" @keyup.enter="fnPageChange(1)">
                            <div class="btn-box type1"><button type="button" @click="fnPageChange(1)">검색버튼</button></div>
                        </div>
                    </div>
                </div>
				
                <div class="contents-table">
                    <div class="flex-table oneday-table">
                        <div class="thead">
                            <div class="tr">
								<div class="th">번호</div>
								<div class="th">클래스명</div>
                                <div class="th">수업일자</div>
                                <div class="th">마감일자</div>
                                <div class="th">신청인원</div>
                                <div class="th">정원</div>
								<div class="th">기능</div>
                            </div>
                        </div>
                        <div class="tbody">
                            <div class="tr" v-for="item in list">
                                <div class="td">{{item.classNo}}</div>
                                <div class="td">{{item.className}}</div>
                                <div class="td">{{item.classDate}}</div>
                                <div class="td">{{item.endDay}}</div>
                                <div class="td">{{item.currentNumber}}</div>
                                <div class="td">{{item.numberLimit}}</div>
                                <div class="td">
                                    <div class="tbl-btn-box" v-if="item.userId != 'admin'">
                                        <button type="button" @click="fnEdit(item.classNo)" title="수정" class="edit">수정</button>
                                        <button type="button" @click="fnRemove(item.classNo)" title="삭제" class="remove">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn" @click="fnRegister">등록</button>
                </div>
            </div>
            <div class="contents-bottom">
				<div class="pagenation">
                   <button type="button" class="prev" :disabled="currentPage == 1" @click="fnPageChange(currentPage - 1)">이전</button>
                   <button type="button" class="num" v-for="item in totalPages" :class="{active: item == currentPage}" @click="fnPageChange(item)">{{item}}</button>
                   <button type="button" class="next" :disabled="currentPage == totalPages" @click="fnPageChange(currentPage + 1)">다음</button>
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
                currentPage: 1,
                pageSize: 11,
                totalPages: 0,
                keyword: "",
				searchOption : 'all',
				totalCount : ""
            };
        },
        methods: {
	
			fnGetList(page){
				var self = this;	
				var startIndex = (page-1)*self.pageSize;
				var outputNumber = self.pageSize;
				self.currentPage = page;
				var nparmap = {searchOption:self.searchOption, keyword:self.keyword.trim(), startIndex:startIndex, outputNumber:outputNumber};
				$.ajax({
	               url: "/admin/oneday-list.dox",
	               dataType: "json",
	               type: "POST",
	               data: nparmap,
	               success: function(data) {
					self.list = data.currentNumber;
					self.totalCount = data.totalCount;
					self.totalPages = Math.ceil(self.totalCount / self.pageSize);
	               }
	           });
			},
			fnPageChange(item) {
              var self = this;
              self.currentPage = item;
              self.fnGetList(item);
          },
            fnRemove(classNo) {
                if(!confirm("삭제 하시겠습니까?")) return;
                var self = this;
                var nparmap = {classNo: classNo};
				$.ajax({
					url:"/admin/oneday-delete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						alert("삭제되었습니다.");
                        self.fnGetList(1);
					}
				});
            },
            fnEdit(classNo) {
                $.pageChange("/admin/oneday-edit.do", {classNo: classNo});
            },
			fnRegister(){
				$.pageChange("/admin/oneday-edit.do", {});
			}
        },
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>