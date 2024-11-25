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
                    <h2 class="admin-tit">유저 정보</h2>
                    <div class="search-box">
                        <div class="ip-box ip-ico-box">
                            <input type="text" placeholder="이름을 입력해주세요" v-model="keyword" @keyup.enter="fnPageChange(1)">
                            <div class="btn-box type1"><button type="button" @click="fnPageChange(1)">검색버튼</button></div>
                        </div>
                    </div>
                </div>
                <div class="contents-table">
                    <div class="flex-table user-table">
                        <div class="thead">
                            <div class="tr">
                                <div class="th">아이디</div>
                                <div class="th">이름</div>
                                <div class="th">주소</div>
                                <div class="th">전화번호</div>
                                <div class="th">이메일</div>
                                <div class="th">생년월일</div>
                                <div class="th">회원등급</div>
                                <div class="th">룰렛 참여 현황</div>
                                <div class="th">기능</div>
                            </div>
                        </div>
                        <div class="tbody">
                            <div class="tr" v-for="(item, index) in userList">
                                <div class="td">{{item.userId}}</div>
                                <div class="td">{{item.userName}}</div>
                                <div class="td">{{item.userAddr}}</div>
                                <div class="td">{{item.userPhone}}</div>
                                <div class="td">{{item.userEmail}}</div>
                                <div class="td">{{item.userBirth}}</div>
                                <div class="td">{{item.userAuth}}</div>
                                <div class="td">
                                    <template v-if="item.userId != 'admin'">{{item.eventRoul}}</template>
                                </div>
                                <div class="td">
                                    <div class="tbl-btn-box" v-if="item.userId != 'admin'">
                                        <button type="button" @click="fnEdit(item.userId)" title="수정" class="edit">수정</button>
                                        <button type="button" @click="fnRemove(item.userId)" title="삭제" class="remove">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                userList: [],
                currentPage: 1,
                pageSize: 11,
                totalPages: 0,
                keyword: "",
            };
        },
        methods: {
            fnGetList(page) {
				var self = this;
                var page = (page - 1) * self.pageSize;
				var nparmap = {currentPage: page, pageSize: self.pageSize, keyword: self.keyword};
				$.ajax({
					url:"/admin/admin-user.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        //console.log(data);
                        self.userList = data.userList;
                        self.totalPages = Math.ceil(data.userAllList.allUser / self.pageSize);
					}
				});
            },
            fnPageChange(item) {
                var self = this;
                self.currentPage = item;
                self.fnGetList(item);
            },
            fnRemove(id) {
                if(!confirm("삭제 하시겠습니까?")) return;
                var self = this;
                var nparmap = {id: id};
				$.ajax({
					url:"/admin/admin-user-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        if(data.result == "success") {
                            alert("삭제 완료되었습니다.")
                            self.fnGetList(1);
                        }
					}
				});
            },
            fnEdit(id) {
                $.pageChange("adminEditor.do", {id: id});
            }
        },
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>