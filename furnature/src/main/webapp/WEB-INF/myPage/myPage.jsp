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
		<div id="container" class="myPage">            
            <p class="blind">마이페이지 - 내정보</p>			
			<div class="myPage-wrap">
				<div class="myPage-snb-wrap">
					<jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
				</div>
				<div class="myPage myPage-info">
					<h2 class="myPage-tit">내정보</h2>
					<div class="myPage-list">
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">아이디</p>
							</div>
							<div class="bot-box">
								<p>{{info.userId}}</p>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">이름</p>
							</div>
							<div class="bot-box">
								<p>{{info.userName}}</p>
							</div>
						</div>
						<div class="ip-list" v-if="sessionId != 'admin'">
							<div class="tit-box">
								<p class="tit">마일리지</p>
							</div>
							<div class="bot-box">
								<p>{{info.mileageTotal}}</p>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">주소</p>
							</div>
							<div class="bot-box">
								<template v-if="!editInfo">
									<p>{{info.userAddr}}</p>
								</template>
								<template v-else>
									<div class="ip-box ip-ico-box type2">
										<input type="hidden" id="postcode" placeholder="우편번호" readonly="readonly" v-model="zipCode">
										<input type="text" id="address" placeholder="주소"  readonly="readonly" v-model="address">
										<div class="btn-box type2">
											<button type="button" @click="daumPost">주소검색</button>
										</div>
									</div>
									<div class="ip-box mgt10">
										<input type="text" id="detailAddress" placeholder="상세주소" v-model="detailAddress">
									</div>
								</template>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">핸드폰 번호</p>
							</div>
							<div class="bot-box">
								<template v-if="!editInfo">
									<p>{{info.userPhone}}</p>
								</template>
								<template v-else>
									<div class="ip-box">
										<input type="text" v-model="phone" ref="phoneRef">
									</div>
								</template>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">이메일</p>
							</div>
							<div class="bot-box">
								<template v-if="!editInfo">
									<p>{{info.userEmail}}</p>
								</template>
								<template v-else>
									<div class="ip-box">
										<input type="text" v-model="email" ref="emailRef">
									</div>
								</template>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">생년월일</p>
							</div>
							<div class="bot-box">
								<p>{{info.userBirth}}</p>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">참여여부</p>
							</div>
							<div class="bot-box">
								<p>
									<template v-if="info.eventRoul == 'N'">참여완료</template>
									<template v-else>참여가능</template>
								</p>
							</div>
						</div>
						<div class="ip-list">
							<div class="tit-box">
								<p class="tit">참여여부</p>
							</div>
							<div class="bot-box">
								<p>
									<template v-if="info.eventCheck == 'N'">참여완료</template>
									<template v-else>참여가능</template>
								</p>
							</div>
						</div>
					</div>
					<div class="front-btn-box">
						<button type="button" @click="fnEdit" v-if="!editInfo">수정하기</button>
						<button type="button" @click="fnSave" v-if="editInfo">저장하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    const app = Vue.createApp({
        data() {
            return {
				sessionId : '${sessionId}',
				info : {},
				editInfo : false,
				addr: "",
				phone : "",
				email : "",
				address : "",
				detailAddress : "",
				zipCode: "",
            };
        },
        methods: {
            fnGetInfo(){
				var self = this;
				var nparmap = {sessionId: self.sessionId};
				$.ajax({
					url:"/myPage/myPage.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data);
						self.info = data.info;
					}
				});
            },
			fnEdit(){
				var self = this;
				self.editInfo = true;
			},
			fnSave(){
				var self = this;
				var check1 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일이 적합한지 검사할 정규식
				var check2 = /^\d+$/;
				
				var phone = self.phone;
				var email = self.email;
				if(self.address == "") {
					alert("주소 변경시 상세 주소만 입력하면 변경이 불가합니다.");
					return;
				}else if(phone != "" && !self.compare(check2, phone, "phoneRef","전화번호는 숫자만 작성해주세요.")){
					return;
				} else if(phone != "" && self.lengthCheck(phone, 10, "전화번호는 최소 10자리 이상 입력해주세요.")){
                    return;
                } else if(email != "" && !self.compare(check1, email, "emailRef","적합하지 않은 이메일 형식입니다")) {
					return;
				} else {
					self.addr = `\${self.address} \${self.detailAddress}`;
					if(self.addr == " "){
						self.addr = "";
					}
					console.log(self.address == "");
					if(!(self.addr == "" && self.phone == "" &&  self.email == "" && self.zipCode == "")) {
						var nparmap = {sessionId: self.sessionId, addr: self.addr, phone: self.phone, email: self.email, zipCode: self.zipCode};
						$.ajax({
							url:"/myPage/myPage-edit.dox",
							dataType:"json",	
							type : "POST", 
							data : nparmap,
							success : function(data) {
								//console.log(data);
								self.fnGetInfo();
								self.phone = "";
								self.email = "";
								self.addr = "";
								self.address = "";
								self.detailAddress = "";
								self.zipCode = "";
							}
						});
					}
					self.editInfo = false;
				}
			},
			compare(check, form, name, message) {
				var self = this;
			    if(check.test(form)) {
			        return true;
			    }
			    alert(message);
			    return false;
			},
            lengthCheck(id, cnt, message){
                if(id.length < cnt) {
                    alert(message);
                    return true;
                }
                return false;
            },
			daumPost(){
				var self = this;
			    new daum.Postcode({
			        oncomplete: function(data) {
			            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                addr = data.roadAddress;
			            } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                addr = data.jibunAddress;
			            }
			            self.zipCode = data.zonecode;
			            self.address = addr;
			            document.getElementById('detailAddress').focus();
			        }
			    }).open();
			}
        },
        mounted() {
            var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>