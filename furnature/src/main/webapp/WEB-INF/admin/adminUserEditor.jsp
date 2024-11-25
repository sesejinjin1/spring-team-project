<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 유저 정보 등록 및 수정</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents editor-mode">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">유저 정보 수정</h2>
                </div>
                <div class="contents-editor">
                    <div class="editor-wrap">
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">아이디</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" disabled :value="info.userId">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">이름</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" disabled :value="info.userName">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">주소</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" disabled :value="info.userAddr">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">전화번호</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="phone">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">이메일</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="email">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">생년월일</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" disabled :value="info.userBirth">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">회원등급</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" disabled :value="info.userAuth">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">이벤트 참여여부</p>
                            </div>
                            <div class="bot-box">
                                <div class="select-box">
                                    <select name="" id="" v-model="roul">
                                        <option value="Y">참여가능</option>
                                        <option value="N">참여완료</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">비밀번호 초기화</p>
                            </div>
                            <div class="bot-box">
                                <button type="button" class="admin-btn" @click="fnPwd">비밀번호 초기화</button>
                                <p class="ico-info mgt20">비밀번호는 초기화 후 1234로 변경됩니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" class="admin-btn" @click="fnSave">수정</button>
                    <button type="button" class="admin-btn" @click="fnBack">취소</button>
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
                id: "${id}",
                info: {},
                phone: "",
                email: "",
                roul: "",
            };
        },
        methods: {
            fnGetInfo() {
				var self = this;
				var nparmap = {id: self.id};
				$.ajax({
					url:"/admin/admin-user.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        console.log(data);
                        self.info = data.info;
                        self.phone = data.info.userPhone;
                        self.email = data.info.userEmail;
                        self.roul = data.info.eventRoul;
					}
				});
            },
            fnPwd() {
                if(!confirm("비밀번호를 초기화 하겠습니까?")) return;
                var self = this;
				var nparmap = {id: self.id};
				$.ajax({
					url:"/admin/admin-user-pwd.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
                        console.log(data);
                        alert("비밀번호가 초기화 되었습니다.");
					}
				});
            },
            fnSave() {
                var self = this;
                var self = this;
				var check1 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일이 적합한지 검사할 정규식
				var check2 = /^\d+$/;
				
				var phone = self.phone;
				var email = self.email;

                if(phone != "" && !self.compare(check2, phone, "phoneRef","전화번호는 숫자만 작성해주세요.")){
                    return;
				} else if(phone != "" && self.lengthCheck(phone, 10, "전화번호는 최소 10자리 이상 입력해주세요.")){
                    return;
                } else if(email != "" && !self.compare(check1, email, "emailRef","적합하지 않은 이메일 형식입니다")) {
					return;
				} else {
                    var nparmap = {id: self.id, phone: self.phone, email: self.email, roul: self.roul};
                    if(!(self.email == "" && self.phone == "")){
                        $.ajax({
                            url:"/admin/admin-user-edit.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) {
                                alert("수정 완료되었습니다.");
                                self.fnGetInfo();
                            }
                        });
                    }
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
            lengthCheck(id, cnt, message) {
                if(id.length < cnt) {
                    alert(message);
                    return true;
                }
                return false;
            },
            fnBack() {
                history.back(-1);
            }
        },
        mounted() {
            var self = this;
            self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>