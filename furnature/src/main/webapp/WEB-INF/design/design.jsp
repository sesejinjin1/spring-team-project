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
            <p class="blind">디자인 추천 페이지</p>
			<h2 class="sub-tit">디자인추천</h2>
			<ul class="design-list">
				<li v-for="item in list">
					<a href="javascript:void(0);" @click=fnDesignDetail(item.designNo)>
						<figure class="img-box"><img :src="item.designImgPath">	</figure>
						<div class="tit-box">
							<p class="cnt">추천({{item.count}})</p>
							<p class="tit">{{item.designTitle}}</p>
						</div>
					</a>
					<p class="choice" v-if="item.designChoice == 'Y'">축하드립니다! 이달의 디자인으로 확정 되었습니다.</p>
				</li>
			</ul>
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
				sessionId : '${sessionId}',
				designNo : "",
				list : []
            };
        },
        methods: {
            fnDesignList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/design/design.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.list = data.list;
					}
				});
            },
			fnDesignRegist(){
				var self = this;
				if(self.sessionId == "" || self.sessionId == null){
					alert("로그인이 필요한 기능입니다.");
					return;	
				}
				location.href="/design/designRegist.do";
			},
			fnDesignDetail(designNo){
				$.pageChange("/design/designDetail.do",{designNo : designNo});
			}
        },
        mounted() {
            var self = this;
			self.fnDesignList();
			
        }
    });
    app.mount('#app');
</script>