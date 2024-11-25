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
            <p class="blind">회원가입 페이지</p>
			<h2 class="sub-tit">회원가입</h2>
			<div class="join-wrap">	
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">아이디</p>
					</div>
					<div class="bot-box">
						<div class="ip-box ip-ico-box type2" placeholder="아이디는 5자 이상 입력해주세요">
							<input type="text" placeholder="아이디를 입력해주세요." v-model="id" ref="idRef" @change="idCheck = false">
							<div class="btn-box type2">
								<button type="button" @click="fnIdCheck">중복체크</button>
							</div>
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">비밀번호</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="password" v-model="pwd" ref="pwdRef" placeholder="비밀번호는 영어 숫자 특수문자를 포함해 8자 이상 입력해주세요">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">비밀번호 확인</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="password" v-model="pwdRe" ref="pwdReRef" placeholder="비밀번호를 재입력 입력해주세요">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">주소</p>
					</div>
					<div class="bot-box">
						<div class="ip-box ip-ico-box type2">
							<input type="hidden" id="postcode" placeholder="우편번호" readonly="readonly" v-model="zipCode">						
							<input type="text" id="address" placeholder="주소"  readonly="readonly" v-model="address">
							<div class="btn-box type2">
								<button type="button" @click="daumPost">주소검색</button>
							</div>
						</div>
						<div class="ip-box mgt10">
							<input type="text" id="detailAddress" placeholder="상세주소를 입력해주세요" v-model="detailAddress" ref="addrRef">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">이름</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="text" v-model="name" ref="nameRef" placeholder="이름을 입력해주세요">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">이메일</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="text" v-model="email" ref="emailRef" placeholder="이메일은 형식에 맞게 입력해주세요">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">핸드폰번호</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="text" v-model="phone" ref="phoneRef" placeholder="핸드폰 번호는 숫자만 입력해주세요">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">생일</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="date" v-model="birth" ref="birthRef" placeholder="생일을 입력해주세요">
						</div>
					</div>
				</div>
				<div class="btn-box front-box mgt20"><button type="button" @click="fnJoin">회원가입</button></div>
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
				id : "",
				pwd : "",
				pwdRe : "",
				addr: "",
				address : "",
				detailAddress : "",
				zipCode: "",
				name : "",
				email : "",
				phone : "",
				birth : "",
				idCheck : false
            };
        },
        methods: {
			fnJoin(){
				var self = this;
				if(self.idCheck) {
					var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,}$/; // 아이디 정규식
				    var check2 = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W_])[a-zA-Z0-9\W_]{8,}$/; // 패스워드 정규식
				    var check3 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일이 적합한지 검사할 정규식
				    var check4 = /^\d+$/;
				    var check5 = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
					
				    var id = self.id;
				    var pwd = self.pwd;
				    var pwdRe = self.pwdRe;
					var address = self.address;
					var detailAddress = self.detailAddress;
				    var name = self.name;
				    var phone = self.phone;
				    var email = self.email;
					var birth = self.birth;
				    /* 아이디 */
				    if(id == "") {
				        alert('아이디를 입력해주세요');
				        return;
				    } else if(!self.compare(check1,id, "idRef","아이디는 5~20자의 영문 대소문자와 숫자로만 입력해주세요.")){
				        return;
				    } else if(!self.compare(check2,pwd, "pwdRef","비밀번호는 영문, 숫자, 특수기호 조합 8자 이상 입력해주세요.")){
				        return;
				    } else if(pwd != pwdRe){
				        alert('비밀번호가 일치하지 않습니다.');
				        return;
				    } else if(address == "" || detailAddress == "") {
						alert("주소를 입력해주세요");
						self.$refs.addrRef.focus();
						return;
					} else if(name == ""){
				        alert('이름을 입력해주세요.');
				        self.$refs.nameRef.focus();
				        return;
				    } else if(!self.compare(check3, email, "emailRef","적합하지 않은 이메일 형식입니다")){
				        return;
				    } else if(self.phone == "") {
						alert("전화번호를 입력해주세요.");
					} else if(!self.compare(check4, phone, "phoneRef","전화번호는 숫자만 작성해주세요.")){
				        return;
				    } else if(birth == ""){
						alert("생일을 입력해주세요");
						self.$refs.birthRef.focus();
				        return;
				    } else {
						self.addr = `\${self.address} \${self.detailAddress}`;
					}
					
					var self = this;
					var nparmap = {id: self.id, pwd: self.pwd, zipCode: self.zipCode, addr: self.addr, name: self.name, email: self.email, phone: self.phone, birth: self.birth};
					console.log(nparmap);
					$.ajax({
						url:"/user/join.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							if(data.result == "success"){
								alert(data.message);
								location.href = "login.do";
							} else {
								alert(data.message);
							}
						}
					});
				} else {
					alert("아이디 중복체크를 확인해주세요.");
				}
            },
			fnIdCheck(){
				var self = this;
				var nparmap = {id: self.id};
				var id = self.id;
				var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,}$/; // 아이디 정규식
				if(id.value == "") {
			        window.alert('아이디를 입력해주세요');
			        id.focus();
			        return false;
			    } else if(!self.compare(check1,id, "idRef","아이디는 5~20자의 영문 대소문자와 숫자로만 입력해주세요.")){
			        return false;
			    }
				$.ajax({
					url:"/user/user-info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data.result)	
						if(data.result == "success"){
							self.idCheck = true;
						} else {
							self.idCheck = false;
						}
						alert(data.message);
					}
				});
            },
			compare(check, form, name, message) {
				var self = this;
			    if(check.test(form)) {
			        return true;
			    }
			    alert(message);
			    self.$refs[name].focus();
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
        }
    });
    app.mount('#app');
</script>