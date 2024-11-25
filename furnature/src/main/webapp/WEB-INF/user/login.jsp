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
            <p class="blind">로그인</p>
			<h2 class="sub-tit">로그인</h2>
			<div class="login-wrap">
				<div class="login-box">
					<div class="ip-list">
						<div class="tit-box">
							<p class="tit">로그인</p>
						</div>
						<div class="bot-box">
							<div class="ip-box">
								<input type="text" placeholder="텍스트입력" v-model="id">
							</div>
						</div>
					</div>
					<div class="ip-list">
						<div class="tit-box">
							<p class="tit">비밀번호</p>
						</div>
						<div class="bot-box">
							<div class="ip-box">
								<input type="password" placeholder="비밀번호입력" v-model="pwd" @keyup.enter="login">
							</div>
						</div>
					</div>	
					<div class="btn-box front-box">
						<button type="button" @click="login">로그인</button>
					</div>
				</div>
				<div class="login-bottom">
					<div class="left-box">
						<a href="join.do">회원가입</a>
					</div>
					<div class="right-box">
						<a href="idFind.do">아이디 찾기</a>
						<span>&nbsp;/&nbsp;</span>
						<a href="pwdFind.do">비밀번호 찾기</a>
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
				id : "user3",
				pwd : "user3",
            };
        },
        methods: {
            login(){
				var self = this;
				var nparmap = {id: self.id, pwd: self.pwd};
				$.ajax({
					url:"/user/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data.result)
						if(data.result == "success") {
							$.pageChange("main.do",{});
						} else {
							alert(data.message);
						}
					}
				});
            },
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>