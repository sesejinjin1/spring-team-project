<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="/layout/headlink.jsp"></jsp:include>
	</head>
	<body>
		<div id="app" class="admin">
	        <p class="blind">관리자 페이지 - 원데이 클래스 정보 등록 및 수정</p>
	        <div id="admin-header">
	            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
	            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
	        </div>
	        <div id="admin-container">    
	            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
	            <div class="contents editor-mode">
	                <div class="contens-tit-wrap">
	                    <h2 class="admin-tit">원데이 클래스 정보 수정</h2>
	                </div>
	                <div class="contents-editor">
	                    <div class="editor-wrap">
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">클래스명</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							            <input type="text" v-model="className" @input="validateClassName">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">수업일자</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							            <input type="datetime-local" v-model="classDate">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">수강인원</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							            <input type="text" v-model="numberLimit">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">수강료</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							           <input type="text" v-model="price" @input="validatePrice">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">모집시작일</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							           <input type="datetime-local" v-model="startDay">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">모집마감일</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
							           <input type="datetime-local" v-model="endDay">
							        </div>
							    </div>
							</div>
							
							<div class="ip-list">
							    <div class="tit-box">
							        <p class="tit">상세설명</p>
							    </div>
							    <div class="bot-box">
							        <div class="ip-box">
										<div class="text-box">
											<textarea v-model="description"></textarea>
										</div>
									</div>
							    </div>
							</div>
							
							<div class="ip-list" v-if="isRegist">
								<div class="tit-box">
							        <p class="tit">썸네일업로드</p>
							    </div>
								<div class="ip-box">
								   <input type="file" @change="fnThumbUpload">
								</div>
							    <div class="tit-box">
							        <p class="tit">파일업로드</p>
							    </div>
								<div class="ip-box">
								   <input type="file" multiple @change="fnFileUpload">
								   <span v-if="file.length > 0"></span>
								</div>		
							</div>
						</div> 
					</div> 
					<div class="btn-box">
						<button type="button" class="admin-btn" @click="fnSave" v-if="isRegist">등록</button>
	                    <button type="button" class="admin-btn" @click="fnUpdate" v-if="!isRegist">수정</button>
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
					classNo : '${classNo}',
	                className: "",
	                classDate: "",
	                numberLimit : "",
	                price: "",
	                startDay: "",
	                endDay: "",
					description : "",
					isRegist : false,
					file : [],
					thumb : "",
					sessionAuth : '${sessionAuth}'
	            };
	        },
	        methods: {
				fnGetInfo(){
					var self = this;
					var nparam = {classNo:self.classNo};
					$.ajax({
						url: "/admin/oneday-info.dox",
						dataType: "json",
						type: "POST",
						data: nparam,
						success: function(data){
							self.className = data.onedayInfo.className;
							self.classDate = data.onedayInfo.classDate;
							self.numberLimit = data.onedayInfo.numberLimit;
							self.price = data.onedayInfo.price;
							self.startDay = data.onedayInfo.startDay;
							self.endDay = data.onedayInfo.endDay;
							self.description = data.onedayInfo.description;
						}
					});
				},
				validateClassName() {
				      this.className = this.className.replace(/[^A-Za-z가-힣 ]+/g, '');
				    },
				validatePrice(){
					this.price = this.price.replace(/[^0-9]/, '');
					
				},
				validateNumber(){
					this.numberLimit = this.numberLimit.replace(/[^0-9]/g, '');
				},
				fnFileUpload(event){
					this.file = event.target.files; 
				},
				fnThumbUpload(event){
					this.thumb = event.target.files[0];
				},
				fnValidate(){
					var self = this;
					var startDay = new Date(self.startDay);
					var endDay = new Date(self.endDay);
					var classDate = new Date(self.classDate);
					
					if (startDay > endDay) {
						alert("모집 시작일이 모집 마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return false;
					}
					if (classDate < startDay) {
						alert("모집 시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return false;
					}
					if (classDate < endDay) {
						alert("수업일이 모집 마감일 전입니다. 올바른 날짜를 입력해주세요.");
						return false;
					}
					
					if (!self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay || !self.description) {
					        alert("빈칸을 채워주세요.");
					        return false;
					}
					return true;
				},
				fnNparam() {
				    var self = this;
				    return {
				        classNo: self.classNo, 
				        className: self.className,
				        classDate: self.classDate.replace('T', ' '),
				        numberLimit: self.numberLimit,
				        price: self.price,
				        startDay: self.startDay.replace('T', ' '),
				        endDay: self.endDay.replace('T', ' '),
				        description: self.description
				    };
				},
				
				fnSave(){
					var self = this;
					if(!self.fnValidate()) return;
					
					if(!self.thumb){
						alert("썸네일을 등록해주세요.");
						return;
					}
					if(self.file.length<2){
						alert("파일을 2개 이상 업로드해주세요.");
						return;
					}
					var nparam = self.fnNparam();

					$.ajax({
						url: "/oneday/oneday-register.dox",
						dataType: "json",
						type: "POST",
						data: nparam,
						success: function(data) {
							var classNo = data.classNo;
							// 썸네일 업로드
							if (self.thumb) {
								const formDataThumb = new FormData();
								formDataThumb.append('thumb', self.thumb);
								formDataThumb.append('classNo', classNo);		
								$.ajax({
									url: '/oneday/oneday-thumb.dox',
									type: 'POST',
									data: formDataThumb,
									processData: false,
									contentType: false,
									success: function() {									
									}
								});
							}
							if (self.file.length > 0) {
								const formDataFile = new FormData();
								for (var i = 0; i < self.file.length; i++) {
									formDataFile.append('file', self.file[i]);
								}
								formDataFile.append('classNo', classNo);
								$.ajax({
									url: '/oneday/oneday-file.dox',
									type: 'POST',
									data: formDataFile,
									processData: false,
									contentType: false,
									success: function() {
										$.pageChange("/adminOneday.do", {});
									}
								});
							}
						}
					});
			 	},
				fnUpdate(){
					var self = this;
					if(!self.fnValidate()) return;					
					var nparam = self.fnNparam();
					$.ajax({
						url: "/oneday/oneday-update.dox",
						dataType: "json",
						type: "POST",
						data: nparam,
						success: function(data){
							$.pageChange("/adminOneday.do", {});
						}
					});	
				},
				fnBack(){
					$.pageChange("/adminOneday.do", {});
				}
			},
			
			mounted() {
				var self = this;
				if(self.classNo==''){
					self.isRegist = true;
				}
				self.fnGetInfo();
				if(self.sessionAuth=='' || self.sessionAuth==1){
					$.pageChange("/oneday/oneday.do", {});
				}
            }
        });
	    app.mount('#app');
	</script>