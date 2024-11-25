<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/layout/headlink.jsp"></jsp:include>
</head>
<body>
	<div id="app" class="admin">
        <p class="blind">관리자 페이지 - 상품 등록</p>
        <div id="admin-header">
            <h1 class="a-logo"><a href="/admin.do">관리자 페이지 로고</a></h1>
            <jsp:include page="/layout/adminSnb.jsp"></jsp:include>
        </div>
        <div id="admin-container">    
            <div class="contents-top"><a href="/main.do">메인페이지 이동</a></div>
            <div class="contents editor-mode">
                <div class="contens-tit-wrap">
                    <h2 class="admin-tit">
                        상품 등록 
                        <template v-if="id == ''">등록</template>
                        <template v-else>수정</template>
                    </h2>
                </div>
			 <div v-if="productNo == ''">	
                <div class="contents-editor">
                    <div class="editor-wrap">
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*상품이름</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productName" placeholder="상품이름">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*가로길이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productWidth" placeholder="width(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*세로길이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productLength" placeholder="depth(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*높이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productHeight" placeholder="height(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*가격</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productPrice" placeholder="가격">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*색상</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productColor" placeholder="색상">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 1</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize1"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 2</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize2"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 3</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize3"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*커스텀 유무</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="custom" v-model=productCustom value="Y" id="r12"><label for="r12">가능</label>
					                <input type="radio" name="custom" v-model=productCustom value="N" id="r22"><label for="r22">불가능</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*카테고리1</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="category1" v-model=productCate1 value="1" id="r32"><label for="r32">거실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="2" id="r42"><label for="r42">욕실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="3" id="r52"><label for="r52">주방</label>
					                <input type="radio" name="category1" v-model=productCate1 value="4" id="r62"><label for="r62">침실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="5" id="r72"><label for="r72">오피스</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*카테고리2</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="category2" v-model=productCate2 value="1" id="r82"><label for="r82">거실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="2" id="r92"><label for="r92">욕실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="3" id="r102"><label for="r102">주방</label>
					                <input type="radio" name="category2" v-model=productCate2 value="4" id="r112"><label for="r112">침실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="5" id="r122"><label for="r122">오피스</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*썸네일</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="file" accept=".gif,.jpg,.png" @change="fnFileChange($event, 'thumbnail')">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*상품설명</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="file" accept=".gif,.jpg,.png" @change="fnFileChange($event, 'description')">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<div v-if="productNo != ''">	
                <div class="contents-editor">
                    <div class="editor-wrap">
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*상품이름</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productName" placeholder="상품이름">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*가로길이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productWidth" placeholder="width(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*세로길이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productLength" placeholder="depth(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*높이</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productHeight" placeholder="height(mm)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*가격</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productPrice" placeholder="가격">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*색상</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productColor" placeholder="색상">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 1</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize1"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 2</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize2"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">상품 사이즈 3</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="productSize3"placeholder="100mmX100mmX100mm(가로,세로,높이)">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*커스텀 유무</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="custom" v-model=productCustom value="Y" id="r12"><label for="r12">가능</label>
					                <input type="radio" name="custom" v-model=productCustom value="N" id="r22"><label for="r22">불가능</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*카테고리1</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="category1" v-model=productCate1 value="1" id="r32"><label for="r32">거실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="2" id="r42"><label for="r42">욕실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="3" id="r52"><label for="r52">주방</label>
					                <input type="radio" name="category1" v-model=productCate1 value="4" id="r62"><label for="r62">침실</label>
					                <input type="radio" name="category1" v-model=productCate1 value="5" id="r72"><label for="r72">오피스</label>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">*카테고리2</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
									<input type="radio" name="category2" v-model=productCate2 value="1" id="r82"><label for="r82">거실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="2" id="r92"><label for="r92">욕실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="3" id="r102"><label for="r102">주방</label>
					                <input type="radio" name="category2" v-model=productCate2 value="4" id="r112"><label for="r112">침실</label>
					                <input type="radio" name="category2" v-model=productCate2 value="5" id="r122"><label for="r122">오피스</label>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
			</div>
				<div v-if="productNo==''">
	                <div class="btn-box">
	                    <button type="button"  @click="fnEnrollProduct" class="admin-btn">등록</button>
						<button type="button" @click="fnCancel()" class="admin-btn">취소</button>
	                </div>					
				</div>
				<div v-if="productNo!=''">
	                <div class="btn-box">
	                    <button type="button"  @click="fnUpdateProduct()" class="admin-btn">수정</button>
						<button type="button" @click="fnCancel()" class="admin-btn">취소</button>
	                </div>					
				</div>
				
            </div>
        </div>
	</div>
</body>
</html>
<script>
	const app = Vue.createApp({
        data() {
            return {
				productList : {},
				productName : "",
				productWidth : "",
				productLength : "",
				productHeight : "",
				productPrice : "",
				productColor : "",
				productSize1 : "",
				productSize2 : "",
				productSize3 : "",
				productCustom : "",
				productCate1 : "",
				productCate2 : "",
				thumbnailFile: null,
				productNo : '${productNo}',
                descriptionFile: null
            };
        },
        methods: {
			fnFileChange(event,type) {
				if (type === 'thumbnail') {
                    this.thumbnailFile = event.target.files[0];
                } else if (type === 'description') {
                    this.descriptionFile = event.target.files[0];
                }
			},
            fnEnrollProduct(){
				var self = this;
				if(self.productName == ""){
					alert("상품이름을 입력해주세요");
					return;
				}else if(self.productWidth=="" || self.productLength=="" || self.productHeight==""){
					alert("치수는 입력해주세요.");
					return;
				}else if(self.productPrice==""){
					alert("가격을 입력해주세요");
					return;
				}else if(self.productCustom==""){
					alert("커스텀 유무를 선택해주세요");
					return;
				}else if(self.productCate1 ==""){
					alert("카테고리를 선택해주세요");
					return;
				}else if (self.productCate1 == self.productCate2){
					alert("각각 다른 카테고리를 선택해주세요");
					return;
				}else if(self.productSize1==""){
					alert("사이즈를 입력해주세요");
					return;
				}else if(self.thumbnailFile == null){
					alert("썸네일 이미지를 첨부해주세요");
					return;
				}else if(self.descriptionFile == null){
					alert("상품설명 이미지를 첨부해주세요");
					return;
				}
				var nparmap = {
					productName : self.productName,
					productWidth : self.productWidth,
					productLength : self.productLength,
					productHeight : self.productHeight,
					productPrice : self.productPrice,
					productColor : self.productColor,
					productSize1 : self.productSize1,
					productSize2 : self.productSize2,
					productSize3 : self.productSize3,
					productCustom : self.productCustom,
					productCate1 : self.productCate1,
					productCate2 : self.productCate2
				};
				$.ajax({
					url:"/manage/manageProduct.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						var productNo = data.productNo
						  const formData = new FormData();
						  if (self.thumbnailFile) {
                              formData.append('thumbnailFile', self.thumbnailFile);
                          }
                          if (self.descriptionFile) {
                              formData.append('descriptionFile', self.descriptionFile);
                          }
						  formData.append('productNo', productNo);
						  $.ajax({
							url: '/fileUpload.dox',
							type: 'POST',
							data: formData,
							processData: false,  
							contentType: false,  
							success: function() {
							  alert("상품이 등록 되었습니다");
							  location.href="/productmanage.do";
							},
							error: function(jqXHR, textStatus, errorThrown) {
							  console.error('업로드 실패!', textStatus, errorThrown);
							}
					  });
					}
				});
            },
			fnProductList(){
				var self = this;
				
				var nparmap = {
					productNo : self.productNo
				};
				$.ajax({
					url:"/manage/productUpdateList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
						self.productList = data.list;
						self.productName = self.productList.productName;
						self.productWidth = self.productList.productWidth;
						self.productLength = self.productList.productLength;
						self.productHeight = self.productList.productHeight;
						self.productPrice = self.productList.productPrice;
						self.productColor = self.productList.productColor;
						self.productSize1 = self.productList.productSize1;
						self.productSize2 = self.productList.productSize2;
						self.productSize3 = self.productList.productSize3;
						self.productCate1 = self.productList.productCate1;
						self.productCate2 = self.productList.productCate2;
					}
				});				 
			},
			fnUpdateProduct(productNo){
				var self = this;
				if(self.productName == ""){
					alert("상품이름을 입력해주세요");
					return;
				}else if(self.productWidth=="" || self.productLength=="" || self.productHeight==""){
					alert("치수는 입력해주세요.");
					return;
				}else if(self.productPrice==""){
					alert("가격을 입력해주세요");
					return;
				}else if(self.productCustom==""){
					alert("커스텀 유무를 선택해주세요");
					return;
				}else if(self.productCate1 == ""){
					alert("카테고리를 선택해주세요");
					return;
				}else if (self.productCate1 == self.productCate2){
					alert("각각다른 카테고리를 선택해주세요");
					return;
				}else if(self.productSize1==""){
					alert("사이즈를 입력해주세요");
					return;
				}
				var nparmap = {
					productNo : self.productNo,
					productName : self.productName,
					productWidth : self.productWidth,
					productLength : self.productLength,
					productHeight : self.productHeight,
					productPrice : self.productPrice,
					productColor : self.productColor,
					productSize1 : self.productSize1,
					productSize2 : self.productSize2,
					productSize3 : self.productSize3,
					productCustom : self.productCustom,
					productCate1 : self.productCate1,
					productCate2 : self.productCate2
				};
				$.ajax({
					url:"/manage/manageProductUpdate.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) {
					 	if(data.result=="success"){
							alert("수정되었습니다");
							location.href="/productmanage.do";
						}else{
							alert("실패!");
						}
					}
				});
			},
			fnCancel(){
				history.back();
			}															
        },
        mounted() {
            var self = this;
			if(self.productNo != ''){
				self.fnProductList();
			}
			
        }
    });
    app.mount('#app');
</script>