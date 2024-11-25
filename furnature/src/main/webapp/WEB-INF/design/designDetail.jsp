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
            <p class="blind">기본페이지</p>
			<table class="table-type2">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 40%;">
					<col style="width: 10%;">
					<col style="width: 40%;">
				</colgroup>
				<tbody>
					<tr>
						<th>디자이너</th>
						<td>{{list.userId}}</td>
						<th>디자인 제목</th>
						<td>{{list.designTitle}}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<div class="contents">
								<img :src="list.designImgPath">
								<p class="desc">{{list.designContents}}</p>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="front-btn-box">
				<template v-if="checklist =='false' "><button @click="fnRecommend()">추천하기</button></template>
				<template v-if="checklist =='true' "><button @click="fnRecommend()">취소하기</button></template>
										
				<template v-if="sessionId == 'admin'">
					<button @click="fnDesignSelect()">추천확정</button>			
				</template>
				<template v-if="sessionId == list.userId">
					<button @click="fnDelete(list.designNo)">게시물삭제</button>			
				</template>
					<button @click="fnList">목록</button>
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
				designNo : '${designNo}',
				sessionId : '${sessionId}',
				designCheck : false,
				list : {},
				checklist : {},
				btnChange: false
            };
        },
        methods: {
            fnDesignDetail(){
				var self = this;
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designDetail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						self.list = data.list;
						self.checklist = data.likeCheck
					}
				});
            },
			fnRecommend(){
				var self = this;
				if(self.sessionId == '' || self.sessionId == null){
					alert("로그인이 필요한 기능입니다.");
					return;
				}
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designRecommend.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						if(data.Flg == "true"){
							alert("추천을 취소하였습니다.");
							self.fnDesignDetail();
						}else{
							alert("디자인을 추천하였습니다.");
							self.fnDesignDetail();
						}
						console.log(data);
					}
				});
			},
			fnDesignSelect(){
				var self = this;
				if(self.designCheck == false){
					if (!confirm("이 디자인으로 확정을 시키겠습니까?")) {
					       return;
					  }					
				}else{
					alert("이미 확정된 디자인 입니다.");
					return;
				}
				var nparmap = {
					designNo : self.designNo,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designSelect.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data);
						if(data.result == '성공'){
							alert("대상 디자인으로 선정하셨습니다.");
							self.designCheck = true;
						}
						
					}
				});
			},
			fnDelete(designNo){
				var self = this;
				if (!confirm("게시물을 삭제하시겠습니까?")) {
				        return;
				    }
				var nparmap = {
					designNo : designNo
				};
				$.ajax({
					url:"/design/designDelete.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						if(data.message="success"){
							alert("삭제되었습니다.");
							location.href="/design/design.do"					
						}else{
							alert("삭제시 문제가 발생하였습니다.");
						}
					}
				});
			},
			fnList(){
				location.href="/design/design.do"
			}	
        },
        mounted() {
            var self = this;
			self.fnDesignDetail();
        }
    });
    app.mount('#app');
</script>