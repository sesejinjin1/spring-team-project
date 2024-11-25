<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="header">
	<div class="header-wrap">
		<h1 class="h-logo"><a href="/main.do">메인로고</a></h1>
		<nav class="nav">
			<ul>
				<li><a href="/product/product.do">가구구매</a></li>
				<li><a href="/oneday/oneday.do">원데이클래스</a></li>
				<li><a href="/event/event.do">이벤트</a></li>
				<li><a href="/design/design.do">디자인추천</a></li>
				<li><a href="/qna/qnalist.do">질문게시판</a></li>
				<template v-if="sessionId != ''">
					<li><a href="javascript:void(0);" @click="logout">로그아웃</a></li>
                    <template v-if="sessionId != 'admin'">
                        <li><a href="/myPage/myPage.do">마이페이지</a></li>
                    </template>
				</template>
				<template v-else>
					<li><a href="/login.do">로그인</a></li>
					<li><a href="/join.do">회원가입</a></li>
				</template>
                <template v-if="sessionId == 'admin'">
                    <li><a href="/admin.do">관리자 페이지</a></li>
                </template>
			</ul>
		</nav>
	</div>
</div>
<script>
	const header = Vue.createApp({
        data() {
            return {
                sessionId: "${sessionId}",
                sessionAuth: "${sessionAuth}"
            };
        },
        methods: {
            logout() {
                var self = this;
                var nparmap = {};
                $.ajax({
                    url: "/user/logout.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
                        console.log('Logged out successfully', data);
                        window.location.href = '/login.do'; // 로그아웃 후 로그인 페이지로 리다이렉션
                    },
                    error: function(xhr, status, error) {
                        console.error('Logout failed', status, error);
                    }
                });
            }
        },
        mounted() {
        }
    });
    header.mount('#header');
</script>