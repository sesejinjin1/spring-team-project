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
				<div class="sub-tit">
				질문게시판
				</div>
				<table class="table-type2">
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 40%;">
						<col style="width: 10%;">
						<col style="width: 40%;">
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
							<td colspan="3">{{list.qnaTitle}}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>{{list.userName}}</td>
							<th>작성일</th>
							<td>{{list.udatetime}}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3">
								<div class="contents">
									<img :src="list.qnaFilePath">
									<p class="desc">{{list.qnaContents}}</p>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<p class="comment-tit">댓글 입력</p>
				<div class="ip-box ip-ico-box type2">
					<input type="text" v-model="comments" placeholder="댓글을 입력하세요">
					<div class="btn-box type2">
						<button @click="fnComments">댓글등록</button>
					</div>
				</div>
				<p class="comment-tit">댓글 리스트</p>
				<div class="qna-list-wrap">
					<div class="qna-list">
						<div class="qna-box" v-for="item in comList">
							<div class="qna-top"><b>{{item.userName}}</b> ({{item.udatetime}})</div>
							<div class="qna-contents">
								{{item.commentContents}}
							</div>
							<div v-if="item.userId == sessionId" class="qna-btns">
								<div class="ip-box" v-if="item.flg">
									<input type="text" v-model="commentsUp" placeholder="수정 할 내용을 입력해주세요">
									<button @click="fnComUpdate(item.commentNo)">등록</button>
									<button @click="fnCancel">취소</button>
								</div>
								<template v-if="!item.flg">
									<button @click="fnCommentUp(item)">수정</button>
									<button @click="fnComDelete(item.commentNo)">삭제</button>
								</template>
							</div>
						</div>
					</div>
				</div>
				<div class="front-btn-box">
					<template v-if="list.userId == sessionId || sessionId == 'admin'">
						<button type="button" @click="fnUpdate">수정</button>
						<button type="button" @click="fnDelete">삭제</button>
					</template>
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
				list: [],
				qnaNo: '${qnaNo}',
				comments: "",
				commentNo: "",
				sessionId: '${sessionId}',
				commentsUp: "",
				comList: []
			};
		},
		methods: {
			fnView() {
				var self = this;
				var nparam = { qnaNo: self.qnaNo }
				$.ajax({
					url: "/qna_view.dox",
					dataType: "json",
					type: "POST",
					data: nparam,
					success: function (data) {
						self.list = data.list;
						self.comList = data.comments;
						self.comList = data.comments.map(comment => ({
							...comment, flg: false
						}));
					}
				});
			},
			fnComments() {
				var self = this;
				if(self.comments == ""){
					alert("댓글을 입력해주세요");
					return;
				}
				var nparam = {
					qnaNo: self.qnaNo,
					comments: self.comments,
					userId: self.sessionId
				}
				$.ajax({
					url: "/qna_comments.dox",
					dataType: "json",
					type: "POST",
					data: nparam,
					success: function (data) {
						alert("댓글을 입력하셨습니다.");
						self.comments = "";
						self.fnView();
					}
				});

			},
			fnCommentUp(item) {
				item.flg = !item.flg;
			},
			fnComUpdate(commentNo) {
				var self = this;
				if(self.commentsUp == ""){
					alert("댓글을 입력해주세요");
					return;
				}
				self.comUpdateFlg = true;
				var nparam = {
					commentNo: commentNo,
					commentContents: self.commentsUp
				}
				$.ajax({
					url: "/qna/commentUpdate.dox",
					dataType: "json",
					type: "POST",
					data: nparam,
					success: function (data) {
						alert("댓글을 수정하였습니다.");
						self.commentsUp = "";
						self.fnView();
					}
				});
			},
			fnComDelete(commentNo) {
				var self = this;
				var nparam = {
					commentNo: commentNo,
					userId: self.sessionId
				}
				$.ajax({
					url: "/qna/commentDelete.dox",
					dataType: "json",
					type: "POST",
					data: nparam,
					success: function (data) {
						alert("댓글을 삭제하였습니다.");
						self.fnView();
					}
				});
			},
			fnUpdate() {
				var self = this;
				$.pageChange("/qna/qnaupdate.do", { qnaNo: self.qnaNo });
			},
			fnDelete() {
				var self = this
				var confirmed = confirm("게시물을 삭제 하시겠습니까?");
				if (!confirmed) {
					history.back();
					return;
				}
				var nparam = {
					qnaNo: self.qnaNo,
				}
				$.ajax({
					url: "/qna/qnaDelete.dox",
					dataType: "json",
					type: "POST",
					data: nparam,
					success: function (data) {
						console.log(data);
						alert("게시물을 삭제하였습니다.");
						location.href="/qna/qnalist.do";
					}
				});
			},
			fnCancel() {
				var self = this;
				self.fnView();
			},
			fnListMove() {
				$.pageChange("/qna/qnalist.do", {});
			}
		},

		mounted() {
			var self = this;
			self.fnView();
		}
	});
	app.mount('#app');
</script>