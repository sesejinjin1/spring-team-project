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
				<h2 class="sub-tit">원데이클래스</h2>
				
				<ul class="img-list oneday-list">
					<li v-for = "item in list" :key="item.classNo">
						<a href="javascript:void(0);" @click="fnChange(item.classNo)">
							<figure class="img"><img :src="item.thumbPath" :alt="item.className + '이미지'"></figure>
						</a>
						<span class="tit">{{item.className}}</span>
						<span class="price">수강료 <br> {{Number(item.price).toLocaleString()}}원 </span>
						<span class="date">수업일자 <br> {{item.classDate}} </span>
						<span class="date">모집기간 <br> {{item.startDay}} ~ {{item.endDay}}</span>
						<span class="state">
							<template v-if="item.message1=='모집 중' && parseInt(item.numberLimit)>parseInt(item.currentNumber)">모집 중</template>
							<template v-else="item.message1=='모집 종료' || item.numberLimit==item.currentNumber">모집 종료</template>
						</span>
					</li>
				</ul>
	
				<div class="pagenation">
                   <button type="button" class="prev" :disabled="currentPage == 1" @click="fnPageChange(currentPage - 1)">이전</button>
                   <button type="button" class="num" v-for="item in totalPages" :class="{active: item == currentPage}" @click="fnPageChange(item)">{{item}}</button>
                   <button type="button" class="next" :disabled="currentPage == totalPages" @click="fnPageChange(currentPage + 1)">다음</button>
               </div>
			   <div class="front-btn-box">
		   			<button type="button" @click="fnRegister" v-if="isAdmin">클래스 등록</button>
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
				classNo : "",
				list : [],
				message1 : "",
				endDay : "",
				numberLimit : "",
				currentNumber : "",
				currentPage : 1,
				totalPages : "",
				pageSize: 8,
				totalCount : "",
				isAdmin : false,
				sessionAuth: "${sessionAuth}"
            };
        },
        methods: {
			fnGetList(page){
				var self = this;
				var startIndex = (page-1)*self.pageSize;
				var outputNumber = self.pageSize;
				self.currentPage = page;
				var nparmap = {startIndex:startIndex, outputNumber:outputNumber};
				$.ajax({
					url : "/oneday/oneday-list.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data){
						
						self.list = [];
						for(var i=0; i<data.onedayList.length; i++){
							self.list.push(data.onedayList[i]);
						}
						self.totalCount = data.totalCount;
						self.totalPages = Math.ceil(self.totalCount / self.pageSize);
						for(var i = 0; i < self.list.length; i++) {
						    var endDay = new Date(self.list[i].endDay);
						    var today = new Date();	
						    if(endDay < today) {
						        self.list[i].message1 = "모집 종료";
						    } else {
						        self.list[i].message1 = "모집 중";
						    }   
						    self.fnCheckNumberLimit(self.list[i].classNo, i); 
						}
						
					}
					
				})
			},
			fnCheckNumberLimit(classNo, index) {
			    var self = this;
			    var nparmap = { classNo: classNo };	
			    $.ajax({
			        url: "/oneday/oneday-numberLimit.dox",
			        dataType: "json",
			        type: "POST",
			        data: nparmap,
			        success: function(data) {
			            if (data.numberLimit) {
			                self.list[index].currentNumber = data.numberLimit.currentNumber;
			                self.list[index].numberLimit = data.numberLimit.numberLimit;
			            }
			        }
			    })
			},
			fnChange(classNo){
				$.pageChange("/oneday/oneday-join.do", {classNo:classNo});
			},
			changePage(page) {
				if (page < 1 || page > this.totalPages){
					return;
				}
				this.fnGetList(page);
			},
			fnRegister(){
				$.pageChange("/oneday/oneday-register.do", {});	
			},
			fnPageChange(item) {
              var self = this;
              self.currentPage = item;
              self.fnGetList(item);
          }
        },
        mounted() {
			var self = this;
			self.isAdmin = self.sessionAuth=='2';
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>