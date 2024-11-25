<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app">
		<div id="container">            
			<!-- repeqt는 숫자만큼 '' 안에 문자열을 출력해주는 함수-->
			<select v-model="reviewRating">
			    <option v-for="(title, index) in reviewTitle" :key="index" :value="index + 1">
			        {{ '★'.repeat(index + 1) + '☆'.repeat(5 - (index + 1)) }} - {{ title }}
			    </option>
			</select>
			<div>내용<textarea v-model="reviewContents"></textarea></div>
			<div>사진첨부<input type="file" accept=".gif,.jpg,.png" @change="fnReviewAttach"></div>
			<button @click="fnReviewInsert">리뷰등록</button>
		</div>
	</div>
</body>
</html>
<script>
	const app = Vue.createApp({
	       data() {
	           return {
				reviewTitle : ['별로에요', '그저그래요', '좋아요', '맘에들어요', '아주좋아요'],
				reviewContents : "",
				reviewRating : 5,
				productNo : '${productNo}',
				sessionId : '${sessionId}',
				file : null,
	           };
	       },
	       methods: {
			fnReviewAttach(event){
	 			this.file = event.target.files[0];
			},
           fnReviewInsert(){
			var self = this;
			var reviewIndex = self.reviewRating - 1; //선택한 셀렉 옵션 인덱스값
			var nparmap = {
				reviewTitle : self.reviewTitle[reviewIndex], //컨트롤러에 배열형식으로 넘어가서 인덱스값으로 넘겨주기 
				reviewContents : self.reviewContents,
				userId : self.sessionId,
				productNo : self.productNo,
				reviewRating : self.reviewRating
			};
			$.ajax({
				url:"/productDetail/reviewInsert.dox",
				dataType:"json",	
				type : "POST", 
				data : nparmap,
				success : function(data) {
					console.log(data);
					console.log(data.reviewNo);
					var reviewNo = data.reviewNo;
					if(self.file){
						console.log(data.reviewNo);
					  const formData = new FormData();
					  formData.append('file1', self.file);
					  formData.append('reviewNo', reviewNo);
					  $.ajax({
						url: '/productDetail/reviewImgFile.dox',
						type: 'POST',
						data: formData,
						processData: false,  
						contentType: false,  
						success: function() {
							if(data && data.reviewNo){
								alert("리뷰가 등록되었습니다.");
								window.opener.location.reload();
								window.close();
							} else{
								alert("리뷰 등록에 실패했습니다.");
							}
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