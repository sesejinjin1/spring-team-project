<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/headlink.jsp"></jsp:include>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
    <jsp:include page="/layout/header.jsp"></jsp:include>
    <div id="app">
        <div id="container" class="myPage">            
            <p class="blind">마이페이지 - 배송정보</p>
            <div class="myPage-wrap">
                <div class="myPage-snb-wrap">
                    <jsp:include page="/layout/myPageSnb.jsp"></jsp:include>
                </div>
                <div class="myPage myPage-delivery">
                    <h2 class="myPage-tit">배송정보</h2>
                    <div class="myPage-img-list-wrap">
                        <div class="myPage-img-list-box" v-for="item in list">
                            <template v-if="item.orderCate =='상품'">
                                <div class="img-box">
                                    <a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)"><img :src="item.productThumbnail"></a>
                                </div>
                                <div class="tit-box">
                                    <div class="top">
                                        <div class="num">Order Id. {{item.orderId}}</div>
                                        <div class="num">Product No. {{item.productNo}}</div>
                                        <div class="tit"><a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)">{{item.productName}}</a></div>
                                        <div class="delivery-box">
                                            <div class="delivery-state" :class="'state' + item.deliveryCate">{{item.cateName}}</div>
                                            <div class="delivert-cnt">{{item.orderCount}}개</div>
                                        </div>
                                    </div>
                                </div>
                            </template>	
                            <template v-if="item.orderCate =='경매'">
                                <div class="img-box">
                                    <a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)"><img :src="item.productThumbnail"></a>
                                </div>
                                <div class="tit-box">
                                    <div class="top">
                                        <div class="num">Order Id. {{item.orderId}}</div>
                                        <div class="num">Auction No. {{item.productNo}}</div>
                                        <div class="tit"><a href="javascript:void(0);" @click="fnProDetail(item.productNo, item.orderCate)">{{item.productName}}</a></div>
                                        <div class="delivery-box">
                                            <div class="delivery-state">{{item.cateName}}</div>
                                            <div class="delivert-cnt">{{item.orderCount}}개</div>
                                        </div>                                        	
                                    </div>
                                </div>
                            </template>	
                        </div>
                    </div>
                    <div v-if="!list || list.length === 0">
                       <div class="list-none-box"><div class="txt">배송 목록이 없습니다</div></div>
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
				productNo : "",
                list: []
            };
        },
        methods: {
            fnDelivery() {
                var self = this;
                var nparmap = { 
					userId : self.sessionId
				};
                $.ajax({
                    url: "/myPage/mypage-delivery.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
						//console.log(data);
                        self.list = data.list;
                    }
                });
            },
			fnProDetail(productNo, orderCate){
                if(orderCate == "상품") {
                    $.pageChange("/productDetail/productDetail.do",{productNo : productNo});
                } else if(orderCate == "경매") {
                    $.pageChange("/event/auctionDetail.do",{auctionNo : productNo});
                }
			}
      
        },
        mounted() {
            var self = this;
			self.fnDelivery();
        }
    });
    app.mount('#app');
</script>

