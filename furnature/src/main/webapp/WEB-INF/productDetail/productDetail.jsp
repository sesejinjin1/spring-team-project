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
            <p class="blind">샘플페이지</p>
			<div class="detail-top">
				<div class="thumb-wrap auction-detail-thumb-list">
					<div class="thumb-list">
						<div class="thumb-box"><img :src="productDetail.productThumbnail" alt="썸네일"></div>
					</div>
					<div class="thumb-arrow">
						<button type="button" class="prev">이전</button>
						<button type="button" class="next">다음</button>
					</div>
				</div>
				<div class="detail-top-info">
					<div class="detail-box">
						<div class="tit">상품명</div>
						<div class="info">{{productDetail.productName}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">상품 가격</div>
						<div class="info">{{parseInt(productDetail.productPrice).toLocaleString()}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">색상</div>
						<div class="info">{{productDetail.productColor}}</div>
					</div>
					<div class="detail-box">
						<div class="tit">사이즈 선택</div>
						<div class="info">
							<div class="select-box">
								<select v-model="sizeSelect" @change="fnSelectSize">
									<option value="">사이즈 선택</option>
									<option v-for="(item,index) in sizeList" :value="index">
										<template v-if="index=='0'">{{item}}</template>
										<template v-if="index=='1'">{{item}} : + 20000 원</template>
										<template v-if="index=='2'">{{item}} : + 40000 원</template>
									</option>					
								</select>
							</div>
						</div>
					</div>
					<div class="detail-box" v-if="selectedSize != null">
						<div class="tit">선택 된 사이즈</div>
						<div class="info">								
							<div class="total-wrap">
								<div class="total-box" v-for="(item,index) in selectedSize">
									<p class="tit">{{productDetail.productName}} {{ item.size }}번 사이즈	</p>
									<div class="option-box">
										<div class="option">
											<button type="button" class="btn minus" @click="fnDown(index)">-</button>
											<div class="ip-box">
												<input type="text" v-model="item.count">
											</div>
											<button type="button" class="btn plus" @click="fnUp(index)">+</button>
										</div>
										<p class="price"><b>{{(item.price * item.count).toLocaleString()}}</b>원</p>
										<button type="button" class="" @click="fnDelteOption(index)">X</button>
									</div>
								</div>
							</div>						
						</div>
					</div>
					<div class="detail-box">
						<div class="tit">총 합</div>
						<div class="info">
							<div class="total-price">총 합계: <b>{{ totalPrice }}</b>원</div>
						</div>
					</div>
					<div class="btn-box">
						<button type="button" @click="fnPay(1)">구매하기</button>
						<button type="button" @click="fnPay(2)">장바구니</button>
						<template v-if="productDetail.productCustom == 'Y' && customFlg !='true' ">
							<button type="button" @click="fnCustom()">커스텀신청</button>
						</template>
						<template v-if="productDetail.productCustom == 'Y' && customFlg =='true' ">
							<button type="button" @click="fnCustomCancel()">커스텀취소</button>
						</template>
					</div>				
				</div>
			</div>
			<div class="detail-tab">
				<button type="button" @click="fnTab(1)" :class="bottomBox == '1' ? 'active' : ''">상세 정보 설명</button>
				<button type="button" @click="fnTab(2)" :class="bottomBox == '2' ? 'active' : ''">배송 및 교환 정보</button>
				<button type="button" @click="fnTab(3)" :class="bottomBox == '3' ? 'active' : ''">관련 추천 상품</button>
				<button type="button" @click="fnTab(4)" :class="bottomBox == '4' ? 'active' : ''">후기</button>
			</div>			
			<div class="detail-bottom">
				<div class="detail-bottom-box" v-if="bottomBox == '1'">
					<img :src="productDetail.productDetail1" alt="제품상세정보">
				</div>
				<div class="detail-bottom-box" v-if="bottomBox == '2'">
					<jsp:include page="/layout/delivery.jsp"></jsp:include>
				</div>
				<div class="detail-bottom-box" v-if="bottomBox == '3'">
					<ul class="img-list product-list" v-if="recommendList && Array.isArray(recommendList) && recommendList.length > 0">
					     <li v-for="item in recommendList" :key="item.productNo">
					         <a href="javascript:void(0);" @click="fnPorductDetail(item.productNo)">
					             <figure class="img"><img :src="item.productThumbnail"></figure>
					         </a>
					         <span class="tit">{{item.productName}}</span>
					         <span class="price">{{(item.productPrice * 1).toLocaleString()}}원~</span>
					     </li>
					 </ul>
					 <ul v-else>
					     <li>
					         <span class="tit">관련 추천 상품이 없습니다.</span>
					     </li>
					 </ul>
				</div>
				<div class="detail-bottom-box" v-if="bottomBox == '4'">
					<div id="review"> 
						<div class="front-btn-box"><button type="button" @click="fnReviewInsert" v-if="reviewFlag==true">리뷰작성하기</div>
						<div class="popup-wrap" v-if="insertModal">
							<div class="popup-box">
								<p class="popup-tit">리뷰 작성</p>
								<div class="ip-list">
									<div class="tit-box">
										<p class="tit">평점</p>
									</div>
									<div class="bot-box">
										<div class="select-box">
											<select v-model="reviewRating">												
												<option v-for="(title, index) in reviewTitle" :key="index" :value="5-index">
													{{ '★'.repeat(5 - (index)) + '☆'.repeat(index) }} - {{ title }}
												</option>
											</select>
										</div>
									</div>
								</div>
								<div class="ip-list">
									<div class="tit-box">
										<p class="tit">내용</p>
									</div>
									<div class="bot-box">
										<div class="ip-box" v-if="updateModal">
											<div class="text-box"><textarea v-model="reviewContents"></textarea></div>
										</div>
										<div class="ip-box" v-else>
											<div class="text-box"><textarea v-model="reviewContents"></textarea></div>
										</div>
									</div>
								</div>
								<div class="ip-list" v-if="!updateModal">
									<div class="tit-box">
										<p class="tit">사진첨부</p>
									</div>
									<div class="bot-box">
										<div class="ip-box">
											<input type="file" accept=".gif,.jpg,.png" @change="fnReviewAttach">
										</div>
									</div>
								</div>
								<div class="popup-btn-box">
									<template v-if="updateModal"><button @click="fnReviewUpdateSave(updateReviewNo)">수정완료</button></template>
									<template v-else><button @click="fnReviewInsertSave">리뷰작성</button></template>
									<button @click="fnCancel">취소</button>
								</div>	
							</div>							
						</div>
						<div class="star-wrap">
							<div class="star-box">
								<div class="bg-box">기본별</div>
								<div class="bg-box active" :style="{width: (100/5*ratingAvg) + '%'}">active별</div>
							</div>
							<div class="tit-box"><b>{{ratingAvg}}</b>/5.0</div>
						</div>
						<div class="review-wrap"><!-- 보고있는 페이지의 상품번호와 맞는 리뷰 목록들 출력-->
							<div class="review-box" v-for="item in reviewList">
								<template v-if="item.productNo==productDetail.productNo">
									<div class="img-box" v-if="item.reviewImgPath != null"><img :src="item.reviewImgPath"></div>
									<div class="info-box">
										<div class="desc-box">
											<div class="date">{{item.reviewCdateTime}}</div>
											<div class="star-wrap2">
												<div class="star-box">
													<div class="bg-box">기본별</div>
													<div class="bg-box active" :style="{width: (100/5*item.reviewRating) + '%'}">active별</div>
												</div>
											</div>
										</div>										
										<div class="contents">{{item.reviewContents}}</div>
										<template v-if="item.userId==sessionId">
											<div class="btn-box">
												<button type="button" @click="fnReviewUpdate(item.reviewNo)">수정</button>
												<button type="button" @click="fnReviewDelete(item.reviewNo)">삭제</button>
											</div>
										</template>
									</div>
								</template>
							</div>
							<div class="pagenation" v-if="!(reviewList == null || reviewList.length  === 0)">
								<button type="button" class="prev" @click="fnBeforPage()" :disabled="currentPage == 1">이전</button>
								<button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetReviewList(page)">
									{{page}}
								</button>
								<button type="button" class="next" @click="fnNextPage()" :disabled="currentPage == totalPages">다음</button>
							</div>
						</div>
						<!--보고있는 페이지의 상품번호와 맞는 리뷰 없을때-->
						<div v-if="reviewList == null || reviewList.length  === 0">등록된 리뷰가 없습니다.</div>
					</div>
				</div>
			</div>
			<div class="front-btn-box">
				<button type="button" @click="fnListMove">목록</button>
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
				urlList : [],		//모든 이미지 url 리스트 (사용안하는 샘플 fnGetUrlList 사용하는 변수)
				productDetail : [],	// 상품 번호에 맞는 상품의 상세정보
				sizeList : [],		// 현재 상품의 상품 각 사이즈를 리스트에 담아 관리
				sizeSelect : "",	// select v-model 사용하기 위한 변수
				addPrice :	"",		// 사이즈에 가격 넣기위한 변수
				productNo : '${productNo}', //상품페이지 에서 클릭한 상품번호 받아오는 변수
				productName : "",
				selectedSize : [],	// 선택된 select 변수로 저장하기위한 리스트
				sessionId: "${sessionId}",
				sessionAuth: "${sessionAuth}",
				reviewList : [],
				customFlg : "",
				insertModal : false,
				updateModal : false,
				reviewTitle : ['아주좋아요', '맘에들어요', '좋아요', '그저그래요', '별로에요'],	//리뷰제목
				reviewContents : "",	//리뷰내용
				reviewRating : 5,	//리뷰평점
				file : null,
				updateReviewNo : "",
				currentPage: 1,      
				pageSize: 4,        
				totalPages: 1,
				ratingAvg : 0,
				bottomBox : 1,
				recommendList : [],
				customCheckList : [],
				userInfo : [],
				reviewFlag : false,
				reviewInsertCnt : ""
            };
        },
		computed: {
			//주문목록 총 가격
		    totalPrice() {
				var self = this;
				//self.selectedSize.reduce(...) -> selectedSize 배열을 순회해서 total에 누적값 넣어줌
				//for문 사용하지 않아도 됨
		        return self.selectedSize.reduce((total, item) => {
		            return total + (item.price * item.count);
		        }, 0).toLocaleString();
		    } 
		},
        methods: {
            fnGetProductDetail(){
				var self = this;
				var nparmap = {productNo : self.productNo};
				$.ajax({
					url:"/productDetail/productDetail.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						//console.log("pruductdetail");
						//console.log(data);
						self.productDetail = data.productDetail;
						self.productName = self.productDetail.productName;
						//상품번호에 맞는 사이즈를 리스트 안에 담아주기
						self.sizeList = [
						     data.productDetail.productSize1,
						     data.productDetail.productSize2,
						     data.productDetail.productSize3
						 ].filter(size => size != null); // null 값을 제외하고 필터링
						//console.log(self.sizeList);
						self.updateData();
						self.FnRecommend();
						self.fnGetInfo();
					}
				});
            },
			// 모든 이미지 출력 함수 (사용 안하는 샘플입니다.)
			fnGetUrlList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/productDetail/samplesejin.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						self.urlList = data.urlList;
					}
				});
          	},
			// 커스텀 버튼
			fnCustom(){
				var self = this;
				if(self.sessionId == null || self.sessionId == ''){
					alert('로그인 후 이용 가능합니다.');
					window.location.reload();
					return;
				}
				if(confirm('커스텀 신청하시겠습니까?')){ 
					var nparmap = {
						productNo : self.productNo,
						productName : self.productName,
						userId	: self.sessionId
					};
					$.ajax({
						url:"/productDetail/productCustom.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) { 
							//console.log(data);
							alert("커스텀 신청이 완료되었습니다. 관리자를 통해 2~3일 이내로 연락이 옵니다.");
							self.customContentFlg = false;
						}
					});
					window.location.reload();
				}
			},
			//커스텀체크
			fnCustomCheck(){
				var self = this;
				var nparmap = {
					productNo : self.productNo,
					userId	: self.sessionId
				};
				$.ajax({
					url:"/productDetail/productCustomCheck.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.customFlg = data.customFlg;
						self.customCheckList = data.list;
					}
				});
			},
			fnCustomCancel(){
				var self = this;
				if(confirm('커스텀신청을 취소하시겠습니까?')){
					if(self.customCheckList.customCon == 'Y'){
						alert("이미 커스텀이 진행중임으로 취소할수없습니다.");
						return;
					}else{
						var nparmap = {
							productNo : self.productNo,
							userId	: self.sessionId
						};
						$.ajax({
							url:"/productDetail/productCustomCancel.dox",
							dataType:"json",	
							type : "POST", 
							data : nparmap,
							success : function(data) { 
								alert("커스텀신청을 취소하셨습니다.");
								self.fnCustomCheck();
							}
						});
					}
				}
				window.location.reload();
			},
			// 결제 , 장바구니 버튼    shoppingCart
			fnPay(buttonNo){
				var self = this;
				if(self.sessionId == null || self.sessionId == ''){
					alert('로그인 후 이용 가능합니다.');
					window.location.reload();
				}else{
					if(self.selectedSize == null || self.selectedSize ==''){
						alert('선택된 상품이 없습니다.');
						//console.log("???"+self.selectedSize);
					}else{
						
						for(var i=0; i<self.selectedSize.length;i++){	//선택 순서에 따라 담긴 list에 맞는 사이즈로 변경 
							for(var j=0; j<self.sizeList.length;j++){
								if(self.selectedSize[i].size==j){
									self.selectedSize[i].size = self.sizeList[j];
								}
							}
						}
						if(buttonNo ==1){
							if(confirm('선택하신 상품을 구매하시겠습니까?')){
								$.pageChange("pay.do",{productNo : self.productNo , totalPrice : self.totalPrice , selectedSize : self.selectedSize});
							}
						}if(buttonNo==2){
							if(confirm('선택하신 상품을 장바구니에 담으시겠습니까?')){
								//$.pageChange("basket.do",{productNo : self.productNo , totalPrice : self.totalPrice , selectedSize : self.selectedSize});
								var nparmap = {
									productNo : self.productNo,
									userId : self.sessionId,
									selectedSzie : JSON.stringify(self.selectedSize) //리스트라 JSON형식으로 변환
								};
								$.ajax({
									url:"/productDetail/cart.dox",
									dataType:"json",
									type : "POST", 
									data : nparmap,
									success : function(data) { 
									}
								});
								if(confirm('장바구니 목록으로 이동하시겠습니까?')){
									location.href = "/myPage/cart.do";
								}else{
									window.location.reload();
								}
							}
						}
					}
				}
			},
			// 사이즈 선택 
			fnSelectSize(){
				var self = this;
				var isDuplicate = false;	// 중복 체크 확인 변수
				// selectedSize 배열 중복 체크
				for (var i = 0; i < self.selectedSize.length; i++) {
				    if (self.selectedSize[i].size === self.sizeSelect) {
				        isDuplicate = true;	//중복시 true로 변경
				        break; // 중복 발견시 종료
				    }
				}
				// 중복시 알림창
				if (isDuplicate) {
				    alert('이미 선택된 사이즈입니다.');
				    self.sizeSelect = '';
				    return;
				}
				
				// 사이즈 선택시 상세정보에 sizeList 리스트에 담아둔 사이즈를 인덱스 값에 따라 가격 추가 
				if (self.sizeSelect === 0) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10); // 문자열을 숫자로 변환
				} else if (self.sizeSelect === 1) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 20000;
				} else if (self.sizeSelect === 2) {
				    self.addPrice = parseInt(self.productDetail.productPrice, 10) + 40000;
				}
				
				 if (self.sizeSelect !== '') {
				            self.selectedSize.push({
				                size: self.sizeSelect,
				                price: self.addPrice,
								count : 1
				            });
				}
				
				self.sizeSelect = '';
				//console.log(self.sizeSelect);
				//console.log(self.selectedSize);
			},
			//수량 - 버튼
			fnUp(index){
				var self=this;
				self.selectedSize[index].count ++;
				//console.log(self.totalPrice);
			},
			// 수량 + 버튼
			fnDown(index){
				var self=this;
				self.selectedSize[index].count --;
				if(self.selectedSize[index].count <1){
					alert('수량은 1개 이상 !');
					self.selectedSize[index].count = 1;
				}
					//console.log(self.totalPrice);
			},
			//리뷰 목록 출력
			fnGetReviewList(page){
				var self = this;
				var startIndex = (page-1) *self.pageSize;		
				self.currentPage = page;
				var outputNumber = this.pageSize;
				var nparmap = {
					productNo : self.productNo,
					startIndex : startIndex,
			 	    outputNumber : outputNumber,
					userId : self.sessionId
				};
				$.ajax({
					url:"/productDetail/productReview.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						//console.log(data);
						self.reviewList = data.reviewList ;
						self.totalPages = Math.ceil(data.count/self.pageSize);
						self.reviewInsertCnt = data.reviewInsertCnt;
						if(data != null && data.reviewList.length > 0){
							self.ratingAvg = data.reviewList[0].avgRating
						}
					}
				});
	      	},
			//리뷰 작성 모달버튼
			fnReviewInsert() {
			    var self = this;
			    if (self.sessionId != "") {
			        // 리뷰 중복 확인
			        if (self.reviewInsertCnt > 0) {
			            alert('이미 리뷰를 작성하셨습니다.');
			            return;
			        }
			        if (self.reviewFlag == false) {
			            alert('상품을 구매하셔야 리뷰작성이 가능합니다.');
			            return;
			        }
			        if (confirm('리뷰를 작성하시겠습니까?')) {
			            self.reviewContents = "";
			            self.insertModal = !self.insertModal;
			            //console.log(self.reviewFlag);
			            self.updateModal = false;
			        }
			        // location.href='/productDetail/reviewInsert.do?productNo=' + encodeURIComponent(self.productNo);
			    } else {
			        alert('로그인 후 이용해주세요.');
			    }
			},
			//리뷰 수정 모달버튼
			fnReviewUpdate(reviewNo){
				var self = this;
				if(confirm('리뷰를 수정하시겠습니까?')){
					self.reviewContents = "";
				  	self.updateReviewNo = reviewNo; // 현재 수정할 리뷰 번호 저장
				  	self.insertModal = true;
					self.updateModal = true;
					self.fnGetReviewInfo(reviewNo);
				}else{
					self.insertModal = false;
					self.updateModal = false;
				}
			},
			//리뷰 삭제버튼
			fnReviewDelete(reviewNo){
				var self = this;
				var nparmap = {reviewNo : reviewNo};
				if (confirm('정말 삭제하시겠습니까?')) {
					$.ajax({
						url:"/productDetail/deleteReview.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							self.fnGetProductDetail();
							window.location.reload();
						}
					});
				}
			},
			fnReviewAttach(event){
				this.file = event.target.files[0];
			},
			//리뷰작성 모달내 리뷰저장
			fnReviewInsertSave(){
			var self = this;
			var reviewIndex = self.reviewRating - 1; //선택한 셀렉 옵션 인덱스값
			var nparmap = {
				reviewTitle : self.reviewTitle[reviewIndex], //컨트롤러에 배열형식으로 넘어가서 인덱스값으로 넘겨주기 
				reviewContents : self.reviewContents,
				userId : self.sessionId,
				productNo : self.productNo,
				reviewRating : self.reviewRating
			};
			if(self.reviewContents == null || self.reviewContents == ''){
				alert('리뷰내용을 입력해주세요!');
				return;
			}
			$.ajax({
				url:"/productDetail/reviewInsert.dox",
				dataType:"json",	
				type : "POST", 
				data : nparmap,
				success : function(data) {
					//console.log(data);
					//console.log(data.reviewNo);
					var reviewNo = data.reviewNo;
					if(self.file){
						//console.log(data.reviewNo);
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
								window.location.reload();
								self.insertModal = false;
							} else{
								alert("리뷰 등록에 실패했습니다.");
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
						  //console.error('업로드 실패!', textStatus, errorThrown);
						}
					  });
					}
					alert('리뷰가 등록되었습니다.');
					window.location.reload();
				}
			});
			},
			//리뷰 수정모달내 저장버튼 위에 코드랑 중복이라 if문으로 수정일때,그냥 작성일때 url 다르게 선언해주고 넣어주는 형식으로 바꾸기 
			fnReviewUpdateSave(reviewNo){
				var self = this;
				var reviewIndex = self.reviewRating - 1; //선택한 셀렉 옵션 인덱스값
				var nparmap = {
					reviewNo : reviewNo,
					reviewTitle : self.reviewTitle[reviewIndex], //컨트롤러에 배열형식으로 넘어가서 인덱스값으로 넘겨주기 
					reviewContents : self.reviewContents,
					reviewRating : self.reviewRating
				};
				if(self.reviewContents == null || self.reviewContents == ''){
					alert('수정할 리뷰내용을 입력해주세요!');
					return;
				}
				if (confirm('정말 수정하시겠습니까?')) {
					$.ajax({
						url:"/productDetail/updateReview.dox",
						dataType:"json",	
						type : "POST", 
						data : nparmap,
						success : function(data) {
							//console.log(data);
							//console.log(data.reviewNo);
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
										alert("리뷰가 수정되었습니다.");
										window.location.reload();
										self.updateModal = false;
									} else{
										alert("리뷰 수정에 실패했습니다.");
									}
								},
								error: function(jqXHR, textStatus, errorThrown) {
								 // console.error('업로드 실패!', textStatus, errorThrown);
								}
							  });
							}
						}
					});
					window.location.reload();
					alert("리뷰가 수정되었습니다.");
				}
			},
			//취소 버튼
			fnCancel(){
				var self = this;
				self.updateModal = false;
				self.insertModal = false;
				self.contents = "";
			},
			fnBeforPage(){
				var self = this;
				self.currentPage = self.currentPage - 1;
				self.fnGetReviewList(self.currentPage);
			},
			fnNextPage(){
				var self = this;
				self.currentPage = self.currentPage + 1;
				self.fnGetReviewList(self.currentPage);
			},
			updateData() {
					var self = this;
					self.$nextTick(() => {
						$.sliderEvent();
					});
				},
			fnTab(num) {
				var self = this;
				self.bottomBox = num;
			},
			FnRecommend(){
				var self = this;
				var nparmap = {
					cate1 : self.productDetail.productCate1,
					cate2 : self.productDetail.productCate2
				};
				$.ajax({
					url:"/productDetail/productRecommend.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						//console.log(data);
						self.recommendList = data.list;
						self.fnrandomList(self.recommendList);
					}
				});
			},
			fnPorductDetail(productNo){
				$.pageChange("/productDetail/productDetail.do",{productNo : productNo});
			},
			fnrandomList(list) {
				if (Array.isArray(list) && list.length > 0) {
				    for (var i = list.length - 1; i > 0; i--) {
				        var j = Math.floor(Math.random() * (i + 1));
				        [list[i], list[j]] = [list[j], list[i]];
				    }
				}
			},
			fnGetInfo() {
			      var self = this;
			      var nparmap = { sessionId: self.sessionId , productNo : self.productNo};
			      $.ajax({
			          url: "/productDetail/userInfo.dox",
			          dataType: "json",    
			          type: "POST", 
			          data: nparmap,
			          success: function(data) {
			              self.userInfo = data.list;
			              //console.log(data);

						  // 최근 주문 확인
						  var dateLimte = new Date();
						  dateLimte.setDate(dateLimte.getDate() - 14); // 14일 전 날짜로 설정

						  for (var i = 0; i < self.userInfo.length; i++) {
						      var orderDate = new Date(self.userInfo[i].orderDate); // 주문 날짜를 Date 객체로 변환
						      if (orderDate >= dateLimte) {
						          self.reviewFlag = true; //  최근 주문이 있고, 2주 지나지 않았으면 true
						          break;
						      }
						  }

						  // hasRecentOrder가 true이면 최근 주문이 있는 것입니다.
						  if (self.reviewFlag) {
						     // console.log("최근 주문이 있습니다.");
						  } else {
						      //console.log("최근 주문이 없습니다.");
						  }
			          }
			      });
			},
			fnListMove() {
				$.pageChange("/product/product.do",{});
			},
			fnDelteOption(index) {
				var self = this;
				self.selectedSize.splice(index, 1); // .splice() 해당 인덱스의 1개 항목을 제거
				//console.log('삭제된 후 selectedSize:', this.selectedSize);
			},
			fnGetReviewInfo(reviewNo){
				var self = this;
				var nparmap = {reviewNo : reviewNo};
				$.ajax({
					url:"/productDetail/reviewInfo.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) {
						//console.log(data); 
						self.reviewContents = data.reviewInfo.reviewContents;
					}
				});
			}
        },
        mounted() {
            var self = this;
			self.fnGetProductDetail();
			self.fnGetReviewList(1);
			self.fnCustomCheck();
        }
    });
    app.mount('#app');
</script>