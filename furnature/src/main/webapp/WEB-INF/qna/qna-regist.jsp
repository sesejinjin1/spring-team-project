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
				<h2 class="sub-tit">질문 등록</h2>
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
							<textarea v-model="contents"></textarea>
						</div>
					</div>
				</div>
				<div class="ip-list">
					<div class="tit-box">
						<p class="tit">파일 첨부</p>
					</div>
					<div class="bot-box">
						<div class="ip-box">
							<input type="file" accept=".gif,.jpg,.png" @change="fnAttach">
						</div>
					</div>
				</div>
				<div class="front-btn-box">
					<button type="button" @click="fnRegist">등록 하기</button>
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
				title : "",
				contents : "",
				file : null
            };
        },
        methods: {
			fnAttach(event){
	 			this.file = event.target.files[0];
			},
			fnRegist(){
				var self = this;
				if(self.title == ""){
					alert("제목을 입력해주세요");
					return;
				}else if(self.contents == ""){
					alert("내용을 입력해주세요");
					return;
				}
				var nparam = {
					userId : self.sessionId,
					qnaTitle : self.title,
					qnaContents : self.contents,
				}
				$.ajax({
					url:"/qna/qna_regist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						var qnaNo = data.qnaNo
						if(self.file){
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('qnaNo', qnaNo);
						  $.ajax({
							url: '/qna-file.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,
							success: function() {
							  alert("게시글을 등록하였습니다.");
							  location.href="/qna/qnalist.do";
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
						  });
						}else{
							alert("게시글을 등록하였습니다.");
							location.href="/qna/qnalist.do";
						}
					}
				});
			 }	 
        },
		       
        mounted() {
			var self = this;
        }
    });
    app.mount('#app');
</script>