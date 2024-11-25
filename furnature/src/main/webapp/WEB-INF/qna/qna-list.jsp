<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="/layout/headlink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/layout/header.jsp"></jsp:include>
		<div id="app">
			<div id="container">
				<p class="blind">질문 게시판 페이지</p>
				<h2 class="sub-tit">질문 게시판</h2>
				<div class="board-search-box">
					<div class="select-box">
						<select name="cate" v-model="category">
							<option value="" selected>전체</option>
							<option value="cateTitle">제목</option>
							<option value="cateUser">작성자</option>
						</select>
					</div>
					<div class="ip-box ip-ico-box">
						<input type="text" v-model="searchData" placeholder="검색어를 입력해주세요" @keyup.enter="fnGetList(1)">
						<div class="btn-box type1">
							<button @click="fnGetList(1)" >검색</button>
						</div>
					</div>
				</div>
				<table class="table-type1">
					<colgroup>
						<col style="width: 7%;">
						<col style="width: 12%;">
						<col style="width: 66%;">
						<col style="width: 15%;">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>작성자</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="item in list">
							<td>{{item.qnaNo}}</td>
							<!-- <td v-if="item.qnaCategory == 1"><p>Q&A질문</p></td> -->
							<td>{{item.userName}}</td>
							<td>
								<a href="javascript:void(0);" @click="fnView(item.qnaNo)">
									{{item.qnaTitle}} <template v-if="item.commentCount > 0">[{{item.commentCount}}]</template>
								</a>
							</td>
							<td>{{item.udatetime}}</td>
						</tr>
					</tbody>
				</table>
				<div class="front-btn-box">
					<button @click="fnInsert()" v-if="sessionId !== userId">게시글작성</button>
				</div>
				<div class="pagenation">
					<button type="button" class="prev" @click="fnBeforePage()" :disabled="currentPage == 1">이전</button>
					<button type="button" class="num" v-for="page in totalPages" :class="{active: page == currentPage}"
						@click="fnGetList(page)">
						{{ page }}
					</button>
					<button type="button" class="next" :disabled="currentPage == totalPages" @click="fnAfterPage()">다음</button>
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
				list: [],
				qnaNo: "",
				title: "",
				userId: "",
				searchData: "",
				category: "",
				number: "",
				sessionId: '${sessionId}',
				currentPage: 1,
				pageSize: 10,
				totalPages: 1,
				cntValue: 5,
				selectItem: []
			};
		},
		methods: {
			fnGetList(page) {
				var self = this;
				self.currentPage = page;
				var startIndex = (page - 1) * self.pageSize;
				var outputNumber = self.pageSize;
				var nparmap = {
					startIndex: startIndex,
					outputNumber: outputNumber,
					searchData: self.searchData,
					category: self.category
				};
				$.ajax({
					url: "/qna/qna_list.dox",
					dataType: "json",
					type: "POST",
					data: nparmap,
					success: function (data) {
						//console.log(data);
						self.list = data.list;
						self.totalPages = Math.ceil(data.count / self.pageSize);
					}
				});
			},
			fnView(qnano) {
				var self = this;
				$.pageChange("/qna/qnaview.do", { qnaNo: qnano });
			},
			fnBeforePage() {
				var self = this;
				if(self.currentPage == 1){
					return;
				}
				self.currentPage = self.currentPage - 1;
				self.fnGetList(self.currentPage);
			},
			fnAfterPage() {
				var self = this;
				if(self.totalPages == self.currentPage){
					return;
				}
				self.currentPage = self.currentPage + 1;
				self.fnGetList(self.currentPage);
			},
			fnInsert() {
				location.href = "qna-regist.do";
			}

		},

		mounted() {
			var self = this;
			self.fnGetList(1);
		}
	});
	app.mount('#app');
</script>