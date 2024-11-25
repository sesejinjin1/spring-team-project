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
	            <p class="blind">원데이클래스</p>		
				<h2 class="sub-tit">원데이클래스 등록</h2>				
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
						<div class="text-box">
							<textarea v-model="description" rows="10" cols="200"></textarea>
						</div>
					</div>
				</div>				
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">썸네일 업로드</p>
					</div>
					<div class="ip-box">
					<input type="file" @change="fnThumbUpload">
					</div>
					<div class="tit-box">
						<p class="tit">파일 업로드</p>
					</div>
					<div class="ip-box">
					<input type="file" multiple @change="fnFileUpload">
					<span v-if="file.length > 0">파일 {{file.length}}개</span>
					</div>
					<div>
						<div class="front-btn-box">
							<button type="button" @click="fnSave">저장</button>
							<button type="button" @click="fnBack">취소</button>
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
					classNo: "",
	                className: "",
	                classDate: "",
	                numberLimit: "",
	                price: "",
	                startDay: "",
	                endDay: "",
					description: "",
					file: [],
					thumb: ""
	            };
	        },
	        methods: {
				validateClassName() {
				      this.className = this.className.replace(/[^A-Za-z가-힣 ]+/g, '');
				    },
				validatePrice(){
					this.price = this.price.replace(/[^0-9]/, '');
				},
				validateNumber(){
					this.numberLimit = this.numberLimit.replace(/[^0-9]/g, '');
				},
				fnThumbUpload(event){
					this.thumb = event.target.files[0];
				},
				fnFileUpload(event){
					this.file = event.target.files; 
				},
				
				fnSave(){
					var self = this;
					var startDay = new Date(self.startDay);
					var endDay = new Date(self.endDay);
					var classDate = new Date(self.classDate);
					
					if (startDay > endDay) {
						alert("모집 시작일이 모집 마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return;
					}
					if (classDate < startDay) {
						alert("모집 시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
						return;
					}
					if (classDate < endDay) {
						alert("수업일이 모집 마감일 전입니다. 올바른 날짜를 입력해주세요.");
						return;
					}
					
					if (!self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay || !self.description) {
					        alert("빈칸을 채워주세요.");
					        return;
					}
					if(!self.thumb){
						alert("썸네일을 등록해주세요.");
						return;
					}
					if(self.file.length<2){
						alert("파일을 2개 이상 업로드해주세요.");
						return;
					}

					// 클래스 정보 저장
					var nparam = {
						className: self.className,
						classDate: self.classDate.replace('T', ' '),
						numberLimit: self.numberLimit,
						price: self.price,
						startDay: self.startDay.replace('T', ' '),
						endDay: self.endDay.replace('T', ' '),
						description: self.description
					};

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
										//console.log('썸네일 업로드 성공!');
									}
								});
							}

							// 파일 업로드
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
										//console.log('파일 업로드 성공!');
										$.pageChange("/adminOneday.do", {});
									}
								});
							}
						}
					});
			 	},
				fnBack(){
					$.pageChange("/oneday/oneday.do", {});
				}
			},
			mounted() {
				var self = this;
            }
        });
	    app.mount('#app');
</script>
