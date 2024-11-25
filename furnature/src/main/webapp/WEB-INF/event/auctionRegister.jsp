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
            <p class="blind">경매등록 페이지</p>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 이름</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="text" v-model="title">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 시작가</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="text" v-model="price">
			        </div>
			    </div>
			</div>
			<template v-if="auctionNo == ''">
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">경매 썸네일 이미지</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="file" multiple @change="fnFileChange($event, 'thumbFile')">
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">경매 상세 이미지</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="file" @change="fnFileChange($event, 'contentsFile')">
						</div>
					</div>
				</div>
			</template>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 상세 설명</p>
			    </div>
			    <div class="bot-box">
			        <div class="text-box">
			            <textarea v-model="contents"></textarea>
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 시작 시간</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="datetime-local" v-model="startDay">
			        </div>
			    </div>
			</div>
			<div class="ip-list">
			    <div class="tit-box">
			        <p class="tit">경매 종료 시간</p>
			    </div>
			    <div class="bot-box">
			        <div class="ip-box">
			            <input type="datetime-local" v-model="endDay">
			        </div>
			    </div>
			</div>
			<div class="front-btn-box">
				<button type="button" @click="fnAuction">경매 등록 하기</button>
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
				title : "",
				price : "",
				currentPrice: "",
				thumbFile : [],
				contentsFile : "",
				contents : "",
				startDay : "",
				endDay : "",
				status : "",
				sessionId : "${sessionId}",
				auctionNo : "${auctionNo}",
            };
        },
        methods: {
            fnAuction(){
				var self = this;
				var check = /[0-9]/;
				/* 오늘 날짜 체크용 */
				var time = new Date();
				var year = time.getFullYear();
				var month = String(time.getMonth()+1).padStart(2, "0");
				var day = String(time.getDate()).padStart(2, "0");
				var hour = String(time.getHours()).padStart(2, "0");
				var minutes = String(time.getMinutes()).padStart(2, "0");
				var today = year + "-" + month + "-" + day + "T00:00";
				var todayFull = year + "-" + month + "-" + day + "T" + hour + ":" + minutes;

				if(self.startDay.indexOf("T")<0) {
					self.startDay = self.startDay.replace(" ","T");
				}

				if(self.auctionNo != "") {
					if(self.price > self.currentPrice) {
						alert("현재 경매가보다 큰 금액으로 시작가를 수정하는것은 불가합니다. \n 현재 경매가는 " + self.currentPrice + "원 입니다.");
						return;
					}
				}
				
				if(self.compare(self.title, "경매 제목을 입력해주세요.")){
					return false;
				} else if (self.compare(self.price, "시작가를 입력해주세요.")) {
					return false;
				} else if (self.compare2(check, self.price, "시작가는 숫자만 입력해주세요.")) {
					return false;
				} else if(self.price <= 0){
					alert("시작가는 0원보다 커야 입력이 가능합니다.");
					return false;
				} else if (self.compare(self.startDay, "시작일을 입력해주세요.")) {
					return false;
				} else if (self.compare(self.endDay, "종료일을 입력해주세요.")) {
					return false;
				} 
				
				if(self.status != "I") {
					if (today > self.startDay) {
						alert("시작일은 오늘 일자보다 늦은 일자로 선택해주세요");
						return false;
					}
				}
				if (self.startDay >= self.endDay) {
					alert("종료일 시작일 보다 늦은 일자로 선택해주세요");
					return false;
				} 
				
				if(self.auctionNo == '') {
					 if (self.compare(self.thumbFile, "경매 썸네일 이미지 파일을 등록해주세요.")) {
						return false;
					} else if (self.compare(self.contentsFile, "경매 상세 이미지 파일을 등록해주세요.")) {
						return false;
					} 
				}
				
				if(self.startDay <= todayFull) {
					self.status = "I";
				} else {
					self.status = "F";
				}
				
				self.startDay = self.startDay.replace("T"," ");
				self.endDay = self.endDay.replace("T"," ");
				var nparmap = {title: self.title, price: self.price, id: self.sessionId, startDay: self.startDay, endDay: self.endDay, contents: self. contents, auctionNo: self.auctionNo, status: self.status};
				$.ajax({
					url:"/event/auction-register.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						var auctionNo = data.auctionNo;
						if(self.auctionNo == ''){
							if (self.thumbFile) {
								const formData = new FormData();
								for (var i = 0; i < self.thumbFile.length; i++) {
									formData.append('thumbFile', self.thumbFile[i]);
								}
								formData.append('contentsFile', self.contentsFile);
								formData.append('auctionNo', auctionNo);
								  $.ajax({
									url: '/event/thumbUpload.dox',
									type: 'POST',
									data: formData,
									processData: false,  
									contentType: false,  
									success: function(data) {
										console.log('업로드 성공!');
										$.pageChange("/event/event.do",{});
									},
									error: function(jqXHR, textStatus, errorThrown) {
										console.error('업로드 실패!', textStatus, errorThrown);
									}
							   });
							}
						} else {
							$.pageChange("/event/auctionDetail.do",{auctionNo: self.auctionNo});
						}
					}
				});
            },
			compare(form, message) {
				if(form == "" || form == undefined) {
					alert(message);
					return true;
				}
				return false;
			},
			compare2(check, form, message) {
				if(!check.test(form)) {
					alert(message);
					return true;
				}
				return false;
			},
			fnFileChange(event, targeting) {
				var self = this;
				if(targeting == "thumbFile") {
					self.thumbFile = event.target.files;
				} else if (targeting == "contentsFile") {
					self.contentsFile = event.target.files[0];
				}
			},
			fnGetInfo() {
				var self = this;
				if(self.auctionNo != '') {
					var nparmap = {auctionNo: self.auctionNo};
					$.ajax({
					url:"/event/auction-edit.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.title = data.editInfo.auctionTitle;
						self.price = data.editInfo.auctionPrice;
						self.currentPrice = parseInt(data.editInfo.auctionPriceCurrent);
						self.contents = data.editInfo.auctionContents;
						self.startDay = data.editInfo.startDay;
						self.endDay = data.editInfo.endDay;
						self.status = data.editInfo.auctionStatus;
					}
				});
				}
			}
        },
        mounted() {
            var self = this;
			self.fnGetInfo();
        }
    });
    app.mount('#app');		
</script>