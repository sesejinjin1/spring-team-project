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
                <h2 class="sub-tit">클래스 정보 </h2>                
                <div class="ip-list">
                    <div class="tit-box">
                        <p class="tit">클래스번호</p>
                    </div>
                    <div class="bot-box">
                        <div class="ip-box">
                            <p>{{classNo}}</p>
                        </div>
                    </div>
                </div>                
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
                            <input type="text" v-model="numberLimit" @input="validateNumber">
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
                            <div class="text-box"><pre><textarea v-model="description"></textarea></pre></div>
                        </div>
                    </div>
                </div>
                <div class="front-btn-box">
                    <button type="button" @click="fnUpdate">저장</button>
                    <button type="button" @click="fnBack">취소</button>
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
            classNo: "${classNo}",
            className: "",
            classDate: "",
            numberLimit: "",
            price: "",
            startDay: "",
            endDay: "",
			description : "",
			detail: {}
        };
    },
    methods: {
        validateClassName() {
            this.className = this.className.replace(/[^A-Za-z가-힣 ]+/g, '');
        },
        validatePrice(){
            this.price = this.price.replace(/[^0-9]/g, '');
        },
		validateNumber(){
			this.numberLimit = this.numberLimit.replace(/[^0-9]/g, '');
		},
        fnClass(classNo) {
            var self = this;
            var nparmap = { classNo: self.classNo };
            $.ajax({
                url: "/oneday/oneday-detail.dox",
                dataType: "json",
                type: "POST",
                data: nparmap,
                success: function(data) {
                    self.detail = data.onedayDetail;
                    // 각 필드에 detail 데이터를 할당
                    self.className = data.onedayDetail[0].className;
                    self.classDate = data.onedayDetail[0].classDate;
                    self.numberLimit = Number(data.onedayDetail[0].numberLimit);
                    self.price = data.onedayDetail[0].price;
                    self.startDay = data.onedayDetail[0].startDay;
                    self.endDay = data.onedayDetail[0].endDay;
					self.description = data.onedayDetail[0].description;
                }
            });
        },
        fnUpdate() {
            var self = this;
			self.classDate = self.classDate.replace("T", " ");
			self.startDay = self.startDay.replace("T"," ");
			self.endDay = self.endDay.replace("T", " ");
			
            var nparam = {
                classNo: self.classNo,
                className: self.className, 
                classDate: self.classDate,
                numberLimit: self.numberLimit,
                price: self.price,
                startDay: self.startDay,
                endDay: self.endDay,
				description: self.description               
            };
			
            var startDay = new Date(self.startDay);
            var endDay = new Date(self.endDay);
            var classDate = new Date(self.classDate);
            if (startDay > endDay) {
                alert("모집시작일이 모집마감일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
                return;
            }
            if (classDate < startDay) {
                alert("모집시작일이 수업일보다 뒤입니다. 올바른 날짜를 입력해주세요.");
                return;
            }
            
            if (!self.classNo || !self.className || !self.classDate || !self.numberLimit || !self.price || !self.startDay || !self.endDay || !self.description) {
                alert("빈칸을 채워주세요.");
                return;
            }
            $.ajax({
                url: "/oneday/oneday-update.dox",
                dataType: "json",    
                type: "POST", 
                data: nparam,
                success: function(data) {
                    alert("저장되었습니다.");
					$.pageChange("/oneday/oneday-join.do", {classNo:self.classNo});
                }
            });
        },
		fnBack(){
			$.pageChange("/oneday/oneday.do", {});
		}
    },
    mounted() {
		var self = this;
        self.fnClass(self.classNo);
    }
});
app.mount('#app');
</script>
