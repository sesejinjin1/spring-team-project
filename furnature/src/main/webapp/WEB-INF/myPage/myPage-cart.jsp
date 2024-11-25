<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
    <style>
        .myPage-wrap .myPage-img-list-wrap .myPage-img-list-box .tit-box {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
        }

        .myPage-wrap .myPage-img-list-wrap .myPage-img-list-box .tit-box .top {
            flex: 0 0 300px;
            margin-right: 10px;
        }

        .myPage-wrap .myPage-img-list-wrap .myPage-img-list-box .tit-box .middle {
            flex: 0 0 215px;
            margin-right: 10px;
            margin-left: 0;
        }

        .myPage-wrap .myPage-img-list-wrap .myPage-img-list-box .tit-box .middle2 {
            flex: 0 0 150px;
            margin-left: 0;
        }

        .myPage-wrap .myPage-img-list-wrap .myPage-img-list-box .tit-box .tit {
            font-size: 20px;
            font-weight: 500;
            line-height: 1.6;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .myPage-wrap .myPage-totalPrice {
            font-size: 36px;
            font-weight: 700;
            padding-top: 50px;
            text-align: center;
			margin-bottom : 20px;
        }

        .myPage-wrap .myPage .myPage-totalPrice {
            border-top: 1px solid var(--color-contrasty2);
        }

        .option-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        .option {
            display: flex;
            align-items: center;
            gap: 0 5px;
        }

        .ip-box {
            width: 60px;
        }

        .ip-box input {
            text-align: center;
            height: 36px;
        }

        .btn {
            border: 1px solid var(--color-contrastyC);
            font-size: 0px;
            background: center/20px auto no-repeat;
            border-radius: 4px;
            height: 36px;
            width: 36px;
            background-image: url("../../assets/images/ico/ico_plus.png");
        }

        .btn.minus {
            background-image: url("../../assets/images/ico/ico_minus.png");
        }

        .price {
            font-size: 14px;
        }

        .price b {
            font-size: 16px;
        }

        .total-box + .total-box {
            margin-top: 10px;
            border-top: 1px solid var(--color-contrastyE5);
        }

        .check {
            display: flex;
            align-items: start;
            flex-direction: row;
            justify-content: center;
        }

        .check input[type="checkbox"] {
            appearance: none;
            width: 25px;
            height: 25px;
            border: 2px solid var(--color-contrastyC);
            border-radius: 3px;
            background-color: white;
            margin-right: 5px;
            cursor: pointer;
        }

        .check input[type="checkbox"]:checked {
            background-color: black;
            border-color: black;
        }

        .check input[type="checkbox"]:checked::before {
            content: "✓";
            color: white;
            display: block;
            text-align: center;
            line-height: 25px;
            font-size: 25px;
        }

        .front-btn-box {
            display: flex;
            align-items: center;
            gap: 0 20px;
            justify-content: center;
        }

        .myPage-wrap .check .all {
            margin-top: 5px;
            margin-right: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container" class="myPage">            
            <p class="blind">마이페이지 - 장바구니</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-info">
                    <h2 class="myPage-tit">{{sessionId}}님의 장바구니 내역</h2>
                    <div v-if="!list || list.length === 0">
                        장바구니 목록이 없습니다.
                        <div><button @click="fnBuy">구매하러가기</button></div>
                    </div>
                    <div class="myPage-img-list-wrap">
						<div  class="myPage-img-list-box" >
							<div class="tit-box" style="margin-left: 250px;">
								<div class="top">
									상품명 / 옵션정보
								</div>
								<div class="middle">
									수량 / 판매가
								</div>
								<div class="middle2">
									최종 가격
								</div>
								<div class="middle">
									주문 관리
								</div>
							</div>
						</div>
                        <div v-for="(item, index) in list" class="myPage-img-list-box">
                            <div class="img-box">
                                <a href="#" @click="fnProDetail(item.productNo)">
                                    <img :src="item.productThumbnail" style="width: 200px; height: 200px">
                                </a>
                            </div>
                            <div class="tit-box">
                                <div class="top">
                                    <div class="tit">{{item.productName}}</div>
                                    <div class="tit">선택 사이즈</div>
                                    <div class="size">{{item.productSize}}</div>
                                </div>
                                <div class="middle">
                                    <div class="option-box">
                                        <div class="option">
                                            <button type="button" class="btn minus" @click="fnDown(index)">-</button>
                                            <div class="ip-box">
                                                <input type="text" v-model="item.count">
                                            </div>
                                            <button type="button" class="btn plus" @click="fnUp(index)">+</button>
                                        </div>
                                    </div>
                                    <div class="tit">판매가  {{(item.productPrice*1).toLocaleString()}}원 </div>
                                </div>
                                <div class="middle2">
                                    <div class="tit">{{(item.count * item.productPrice).toLocaleString()}}원</div> 
                                </div>
                                <div class="middle">
                                    <div class="tit">
                                        <div class="check">
                                            <input type="checkbox" v-model="selectCheck" :value="item.cartNo" @change="updateSelectCheck">
                                            <div class="front-btn-box">
                                                <button @click="fnPay">바로 구매</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-if="list && list.length > 0" class="myPage myPage-info">
                        <h2 class="myPage-totalPrice">총구매가격 : {{totalPrice.toLocaleString()}}</h2>
                        <div class="check">
                            <div class="all">전체 선택</div>
                            <div><input type="checkbox" v-model="selectAll" @change="fnSelectAll"></div>
                        </div>
                        <div class="front-btn-box">
                            <template v-if="selectAll==false">
                                <button type="button" @click="fnCheckRemove">선택 삭제</button>
                            </template>
                            <template v-if="selectAll==true">
                                <button type="button" @click="fnCheckRemove">전체 삭제</button>
                            </template>
                        </div>
                    </div>
                    <div class="front-btn-box">
                        <button @click="fnPay">선택상품 구매</button>
                        <button @click="fnPay">전체상품 구매</button>
                    </div>
                </div>
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
                sessionId: '${sessionId}',
                list: [],
                selectCheck: [],
                selectAll: true
            };
        },
        computed: {
			totalPrice() {
              var self = this;
              var total = 0;
              for (var i = 0; i < self.list.length; i++) {
                  var item = self.list[i];
                  if (self.selectCheck.includes(item.cartNo)) {
                      total += item.productPrice * item.count;
                  }
              }
              return total;
          }
        },
        methods: {
            fnGetCartList() {
                var self = this;
                var nparmap = { userId: self.sessionId };
                $.ajax({
                    url: "/myPage/mypage-cartList.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
                        //console.log(data);
                        self.list = data.cartList;
						
						self.selectCheck = self.list.map(item => item.cartNo);
                    }
                });
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
                       // console.log(data.info);
                        self.myPoint = data.info.mileageTotal;
                    }
                });
            },
            fnBuy() {
                location.href = "/product/product.do"
            },
            fnProDetail(productNo) {
                $.pageChange("/productDetail/productDetail.do", { productNo: productNo });
            },
            fnCheckRemove() {
                var self = this;

                if (self.selectCheck.length === 0) {
                    alert("삭제할 상품을 선택해주세요.");
                    return;
                }

                var fList = JSON.stringify(self.selectCheck);
                var nparmap = { selectCheck: fList };
                if (confirm('정말 선택한 상품을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: "/myPage/check-remove.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function(data) {
                            self.fnGetCartList();
                            alert("삭제되었습니다.");
                            //onsole.log(self.selectCheck);
                        }
                    });
                } else {
                    alert("취소되었습니다.");
                }
            },
            fnSelectAll() {
                var self = this;
                if (self.selectAll) {
                    self.selectCheck = [];
                    for (var i = 0; i < self.list.length; i++) {
                        var item = self.list[i];
                        self.selectCheck.push(item.cartNo);
                    }
                } else {
                    self.selectCheck = [];
                }
            },
            updateSelectCheck() {
                var self = this;
                var allChecked = true;
                for (var i = 0; i < self.list.length; i++) {
                    var item = self.list[i];
                    if (!self.selectCheck.includes(item.cartNo)) {
                        allChecked = false;
						//console.log(self.selectCheck);
                        break;
                    }
                }
                self.selectAll = allChecked;
				//console.log(self.selectCheck);
            },
            fnPay() {
				alert('아직 구현중입니다.');
//                if (confirm('선택하신 상품을 구매하시겠습니까?')) {
                    //$.pageChange("/productDetail/pay.do",{carList : self.list});
//               } else {
//                    alert('취소되었습니다');
 //               }
            },
			//수량 -
			fnUp(index) {
			    var self = this;
			    // index를 사용해 list의 item을 찾고 수량을 증가시킴
			    self.list[index].count++;
			    //console.log(self.totalPrice);
			},
			// 수량 + 버튼
			fnDown(index) {
			    var self = this;
			    // index를 사용해 list의 item을 찾고 수량을 감소시킴
			    if (self.list[index].count > 1) {
			        self.list[index].count--;
			    } else {
			        alert('수량은 1개 이상이어야 합니다!');
			    }
			    //console.log(self.totalPrice);
			}
        },
        mounted() {
            var self = this;
            self.fnGetCartList();
        }
    });
    app.mount('#app');
</script>
