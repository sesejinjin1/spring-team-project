<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container" class="payment">            
            <p class="blind">기본페이지</p>
            <h2 class="sub-tit">결제목록</h2>
            <div class="detail-top">
                <div class="thumb-wrap">
                    <div class="thumb-list">
                        <div class="thumb-box"><img :src="productDetail.productThumbnail" alt="썸네일"></div>
                    </div>
                </div>
                <div class="detail-top-info">
                    <div class="detail-box">
                        <div class="tit">상품명</div>
                        <div class="info">{{productDetail.productName}}</div>
                    </div>
                    <template v-for="item in selectedSize">
                        <div class="detail-box">
                            <div class="tit">선택 사이즈</div>
                            <div class="info">{{item.size}}</div>
                        </div>
                        <div class="detail-box">
                            <div class="tit">수량</div>
                            <div class="info">{{item.count}}</div>
                        </div>
                        <div class="detail-box">
                            <div class="tit">판매가</div>
                            <div class="info">{{ (item.price * 1).toLocaleString() }}</div>
                        </div>
                    </template>
                    <div class="detail-box">
                        <div class="tit">총 구매가격</div>
                        <div class="info">
                            <div class="total-price"><b>{{parseInt(totalPrice).toLocaleString()}}</b>원</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="detail-bottom">
                <div class="detail-bottom-box">
                    <div class="detail-box">
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">배송지 정보</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-ra-txt">
                                    <input type="radio" name="as" value="10" id="r1" @click="fnDeliveryInfo(10)" checked="checked"><label for="r1">주문자정보와 동일</label>
                                    <input type="radio" name="as" value="20" id="r2" @click="fnDeliveryInfo(20)"><label for="r2">직접입력</label> 
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">받는사람</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="name" placeholder="받는사람을 입력해주세요">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">휴대폰 번호</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">
                                    <input type="text" v-model="phone" placeholder="휴대폰 번호는 숫자만 입력해주세요">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">주소</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box ip-ico-box type2">
                                    <input type="text" id="postcode" placeholder="우편번호" readonly="readonly" v-model="postcode">                    
                                    <div class="mgt10">
                                        <input type="text" id="address" placeholder="주소" readonly="readonly" v-model="address">
                                    </div>
                                    <div class="btn-box type2">
                                        <button type="button" @click="daumPost">주소검색</button>
                                    </div>
                                </div>
                                <div class="ip-box mgt10">
                                    <input type="text" id="detailAddress" placeholder="상세주소" v-model="detailAddress" ref="addrRef">
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
							<div class="select-box">
	                            <select name="deliveryComment" id="deliveryComment" v-model="deliveryComment">
	                                <option value="">메세지 선택(선택사항)</option>
	                                <option value="1">배송 전에 미리 연락바랍니다.</option>
	                                <option value="2">부재 시 경비실에 맡겨주세요.</option>
	                                <option value="3">부재 시 문 앞에 놓아주세요.</option>
	                                <option value="4">빠른 배송 부탁드립니다.</option>
									<option value="5">직접입력</option>
	                            </select>
                                <div v-if="deliveryComment == 5" class="ip-box mgt10">
                                    <input type="text" placeholder="내용을 입력해주세요." v-model="customDeliveryComment">
                                </div>
							</div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">총 상품 금액</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">{{totalPrice.toLocaleString()}}</div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">보유 마일리지</p>{{myPoint}}
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">{{(myPoint*1).toLocaleString()}}</div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">사용 마일리지</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box ip-ico-box type2">
                                    <input type="text" placeholder="0" v-model="pointPay" @change="fnPointLimit">
                                    <div class="btn-box type2">
                                        <button type="button" @click="fnPoint">전액사용</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">최종 결제 금액</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">{{payPrice.toLocaleString()}}</div>
                            </div>
                        </div>
                        <div class="ip-list">
                            <div class="tit-box">
                                <p class="tit">구매시 적립 마일리지</p>
                            </div>
                            <div class="bot-box">
                                <div class="ip-box">{{mileage.toLocaleString()}}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="front-btn-box">
                <button type="button" @click="fnBuy(productDetail.productName, totalPrice, name, phone, productNo,mileage,pointPay)">결제하기</button>
                <button type="button" @click="fnPorductDetail">취소하기</button>
            </div>
        </div>
    </div>
    <jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //포트원 결제 api 사용
    IMP.init("");
    
    const app = Vue.createApp({
        data() {
            return {
                productNo: '${productNo}',
                productDetail: [], //상품상세정보
                totalPrice: parseFloat('${totalPrice}'.replace(/[^0-9.-]+/g,"")) || 0, // 문자열로 받아와서 숫자로 변화
                selectedSize: '${selectedSize}',
                sizeList: [],
                detailAddress: "",
                address: "",
                postCode: "",
                sessionId: "${sessionId}",
                sessionAuth: "${sessionAuth}",
                info: [],
                name: "",
                phone: "",
                postcode: "",
                deliveryInfo: "",
                myPoint: 0,
                pointPay: 0,
				deliveryComment : ""
            };
        },
        computed: {
            //주문목록 총 가격
            payPrice() {
                return Math.max(this.totalPrice - this.pointPay, 0); // 음수일 경우도 무조건 0 으로 출력
            },
            mileage() {
                if (this.pointPay > 0) { //결제시 사용하는 마일리지가 있을때 적립은 X
                    return 0;
                } else {
                    return parseInt(this.payPrice * 0.05);
                }
            }
        },
        methods: {
            fnGetProductDetail() {
                var self = this;
                var nparmap = { productNo: self.productNo , carList : "" };
                $.ajax({
                    url: "/productDetail/productDetail.dox",
                    dataType: "json",    
                    type: "POST", 
                    data: nparmap,
                    success: function(data) { 
                        //console.log(data);
                        self.productDetail = data.productDetail;
                        
                        //상품번호에 맞는 사이즈를 리스트 안에 담아주기
                        self.sizeList = [
                            data.productDetail.productSize1,
                            data.productDetail.productSize2,
                            data.productDetail.productSize3
                        ].filter(size => size != null); // null 값을 제외하고 필터링
                        
                        // selectedSize가 문자열 형식으로 넘어와서 파싱하고 배열 형태로 변환
                        if (typeof self.selectedSize === 'string') {
                            self.selectedSize = JSON.parse(self.selectedSize);
                        }
                    }
                });
            },
            daumPost() {
                var self = this;
                var addr = "";
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }
                        document.getElementById('postcode').value = data.zonecode;
                        self.address = addr;
                        document.getElementById('detailAddress').focus();
                    }
                }).open();
            },
            fnGetInfo() {
                var self = this;
                var nparmap = { sessionId: self.sessionId };
                $.ajax({
                    url: "/myPage/myPage.dox",
                    dataType: "json",    
                    type: "POST", 
                    data: nparmap,
                    success: function(data) {
                        self.info = data.info;
                        //console.log("다음찍히는 콘솔이 userinfo");
                        //console.log(data.info);
						//console.log(data.info.mileageTotal);
						if((self.myPoint == null || self.myPoint == '')){
	                        self.myPoint = data.info.mileageTotal;
						}
						self.fnDeliveryInfo(10);
                    }
                });
            },
            fnDeliveryInfo(value) {
                var self = this;
                self.deliveryInfo = value;
                if (value == 10) {
                    self.name = self.info.userName;
                    self.phone = self.info.userPhone;
                    self.address = self.info.userAddr;
                    self.postcode = self.info.userZipCode;
                } else {
                    self.name = "";
                    self.phone = "";
                    self.address = "";
                    self.postcode = "";
                }
                //console.log(value);
            },
            fnBuy(title, totalPrice, name, phone, orderNo, mileage, pointPay){
                var self = this;
				if (!self.name || !self.phone || !self.postcode || !self.address || !self.detailAddress) {
	                alert('모든 입력 항목을 채워주세요.');	
	                return;
	            }
				IMP.request_pay({
	                pg: "html5_inicis",
	                pay_method: "card",
	                merchant_uid: "product" + new Date().getTime(), // 유니크한 주문 ID 생성
	                name: title,
	                amount: "100",
					buyer_name: self.name,
					buyer_tel: self.phone,
	            }, function (rsp) {
					//console.log(rsp);
					if (rsp.success) {
                        $.ajax({
                            url: "/payment/payment/" + rsp.imp_uid,
                            method: "POST",
							data: {
								imp_uid : rsp.imp_uid,
								merchant_uid: rsp.merchant_uid,
                            	amount: rsp.paid_amount,
								name: name,
								phone: phone
							},
							success : function (data) {
								$.ajax({
									url: "/payment/payment-add.dox",
									method: "POST",
									data: {
										sessionId : self.sessionId,
										category : "product",
										impUid : rsp.imp_uid,
										merchantUid: rsp.merchant_uid,
										amount: rsp.paid_amount,
										name : rsp.buyer_name,
										phone : rsp.buyer_tel,
										orderNo: orderNo,
                                        selectedSize: JSON.stringify(self.selectedSize),
										mileage : mileage,
										pointPay : pointPay
									},
									success : function(data){
										if(data.result == 'success') {
											window.location.href = "/myPage/delivery.do";
										}
									}
								});
							}
                        })
                    } else {
                        alert(rsp.error_msg);
                    }
	            });
			},
            fnOrder() {
                var self = this;
                var orderList = JSON.stringify(self.selectedSize);
				//결제시 orderList에 담긴 배열을 JSON.stringify JSON 형식의 문자열로 변환해줍니다.
				// 이후에 컨트롤러 단에 넘겨주고 컨트롤러단에서 다시 List형식인 list에 담아주고 map에 넣어 서비스단으로 넘겨줬습니다.
				//이후 서비스단에서 리스트 길이만큼 for문 돌려서 사이즈별로 가격 개수 등을 다르게 insert 돌려주는 형식으로 처리했었어요.
                if (!self.name || !self.phone || !self.postcode || !self.address || !self.detailAddress) {
                    alert('모든 입력 항목을 채워주세요.');	
                    return;
                }
                IMP.request_pay({
                    pg: "html5_inicis.INIpayTest",
                    pay_method: "card",
                    merchant_uid: "product" + new Date().getTime(), //주문번호
                    name: self.productDetail.productName, //상품명
                    amount: 100, //가격
                }, function(rsp) { //callback
                    if (rsp.success) { // 결제 성공시
                        var msg = '결제가 완료되었습니다.';
                        msg += '주문번호 : ' + rsp.imp_uid;
                        msg += '거래ID : ' + rsp.merchant_uid;
                        msg += '결제금액 : ' + rsp.paid_amount;
                        
                        var nparmap = {
                            impUid: rsp.imp_uid,
                            orderId: rsp.merchant_uid,
                            orderPrice: rsp.paid_amount,
                            userId: self.info.userId,
                            productNo: self.productNo,
                            orderList: orderList,
                            mileage: self.mileage, //구매시 적립 마일리지
                            pointPay: self.pointPay // 구매시 사용한 마일리지
                        };
                        $.ajax({
                            url: "/productDetail/productOrder.dox",
                            dataType: "json",    
                            type: "POST", 
                            data: nparmap,
                            success: function(data) {
                            }
                        });
                    } else { //결제 실패
                        var msg = '결제를 실패하였습니다.';
                        //console.log(rsp.merchant_uid);
                        //console.log(self.info.userId);
                        //console.log(self.productNo);
                        //console.log(self.selectedSize);
                    }
                    alert(msg);
                    window.location.href = "/myPage/delivery.do";
                });
            },
            fnPoint() {
                var self = this;
                if (self.totalPrice <= self.myPoint) {
                    self.pointPay = self.totalPrice;
                } else {
                    self.pointPay = self.myPoint;
                }
            },
            fnPointLimit() {
                var self = this;
                self.pointPay = parseFloat(self.pointPay) || 0;
                if (self.pointPay <= 0) {
                    self.pointPay = 0; 
                    return;
                }
                if (self.pointPay > self.myPoint) {
                    alert('보유 금액 이상은 사용 불가능 합니다.');
                    self.pointPay = Math.min(self.myPoint, self.totalPrice);
                    return;
                }
                if (self.totalPrice < self.pointPay) {
                    alert('사용 마일리지가 구매가격을 넘었습니다.');
                    self.pointPay = Math.min(self.totalPrice, self.myPoint); // 구매가격과 보유 마일리지 중 더 작은 값으로 설정
                    return;
                }
            },
			fnPorductDetail(productNo){
				if(confirm('구매를 취소하고 돌아가시겠습니까?')){
					location.href="/product/product.do";
				}
			}
        },
        mounted() {
            var self = this;
            self.fnGetProductDetail();
            self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>
