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
			<h2 class="sub-tit">디자인 등록</h2>
			<div class="ip-list">
				<div class="tit-box">
					<p class="tit">나의 가구 이름</p>
				</div>
				<div class="bot-box">
					<div class="ip-box">
						<input type="text" placeholder="상품의 이름을 입력해주세요" v-model="designTitle">
					</div>
				</div>
			</div>
			<div class="ip-list">
				<div class="tit-box">
					<p class="tit">나의 가구 소개</p>
				</div>
				<div class="bot-box">
					<div class="text-box">
						<textarea placeholder="상품을 소개해주세요" v-model="designContents"></textarea>
					</div>
				</div>
			</div>
			<div class="ip-list">
				<div class="tit-box">
					<p class="tit">디자인 첨부</p>
				</div>
				<div class="bot-box">
					<div class="ip-box">
						<input type="file" accept=".gif,.jpg,.png" @change="fnDesignAttach">
					</div>
				</div>
			</div>
			<div class="front-btn-box">
				<button @click="fnDesignRegist">디자인등록</button>
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
				designTitle : "",
				designContents : "",
				sessionId : '${sessionId}',
				file : null
            };
        },
        methods: {
			fnDesignAttach(event){
	 			this.file = event.target.files[0];
			},
            fnDesignRegist(){
				var self = this;
				if(self.file == null){
					alert("파일을 첨부해주세요");
					return;
				}
				var nparmap = {
					designTitle : self.designTitle,
					designContents : self.designContents,
					userId : self.sessionId
				};
				$.ajax({
					url:"/design/designRegist.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						console.log(data.designNo);
						var designNo = data.designNo;
						if(self.file){
							console.log(data.designNo);
						  const formData = new FormData();
						  formData.append('file1', self.file);
						  formData.append('designNo', designNo);
						  $.ajax({
							url: '/design/designFile.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,  
							success: function() {
							  alert("게시글을 등록하였습니다.");
							  location.href="/design/design.do"
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
						  });
						}
					}
				});
            },
			
        },
        mounted() {
            var self = this;
			
        }
    });
    app.mount('#app');
</script>