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
				<h2 class="sub-tit">질문 수정</h2>			
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">제목</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="text" v-model="title">	
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">내용</p>
					</div>
					<div class="bot-box">
						<div class="text-box">
							<textarea v-model="contents">{{contents}}</textarea>
						</div>
					</div>
				</div>
				<div class="front-btn-box">
					<button @click="fnRegist()">등록</button>
					<button @click="fnCancel()">취소</button>
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
				sessionId : '${sessionId}',
				sessionAuth : '${sessionAuth}',
				qnaNo : '${qnaNo}',
				title : "",
				contents : "",
				category : "1",
				list : {}
				
            };
        },
        methods: {
			fnView(){
				var self = this;
				var nparam = {
					qnaNo : self.qnaNo
				}
				$.ajax({
					url:"/qna/qna_update.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						self.list = data.list;
						self.title = self.list.qnaTitle;
						self.contents = self.list.qnaContents;
					}
				});
			},
			fnRegist(){
				var self = this;
				if(self.title == ""){
					alert("제목을 입력해주세요");
					return;
				}else if(self.contents == ""){
					alert("내용을 입력해주세요");
					return;
				}else if(self.category == ""){
					alert("카테고리를 선택해주세요");
					return;
				}
				var nparam = {
					qnaTitle : self.title,
					qnaContents : self.contents,
					qnaNo : self.qnaNo
				}
				$.ajax({
					url:"/qna/qna_update_regist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						alert("수정되었습니다.");
						location.href="qnalist.do"
						
					}
				});
			 },
			 fnCancel(){
				var confirmed = confirm("수정하던 게시글을 취소 하시겠습니까?");
			      if (confirmed) {
			        history.back();
			      }
			 }
        },
		       
        mounted() {
			var self = this;
			self.fnView();
        }
    });
    app.mount('#app');
</script>