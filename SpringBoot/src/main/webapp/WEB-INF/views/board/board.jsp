
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<link href="/resources/static/css/search.css" rel="stylesheet" />
	<link href="/resources/static/css/layout.css" rel="stylesheet" />
	<link href="/resources/static/css/basic.css" rel="stylesheet" />
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<header id="header"></header>
<head>
<meta charset="UTF-8">
<title>게시판</title>

</head>
<body>
	<div id="list-container" style="display : block;">
		<div id="board-search-container">
			<form method="POST" id="search-board" action="">
				<input type="hidden" name="pgno" value="1"/>
				<select name="key" id="key"  aria-label="검색조건">
					<option selected>검색조건</option>
					<option value="subject">제목</option>
					<option value="userid">작성자</option>
				</select>
				<div class="input-group input-group-sm">
					<input type="text" name="word" id="word"  placeholder="검색어..." />
					<button id="btn-search" type="button">검색</button>
				</div>
			</form>
		</div>
		<div class="content" style="margin: 50px;">
			<div class="row">
				<div class="col-md-10"></div>
				<div class="col-md-2" id="totalCnt" style="text-align: right">
					전체 게시글 수 : 0
				</div>
			</div>
			<div class="table-responsive">
				<table class="table table-hover">
					<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>등록일</th>
					</tr>
					</thead>
					<%-- ajax로 게시판 리스트가 만들어진다. --%>
					<tbody id="board-list">
					</tbody>
				</table>
			</div>
			<%-- 페이지출력 --%>
			<div id="pagination">
			</div>
			<button type="button" id="write-btn">글쓰기</button>
		</div>
	</div>

	<div id="detail-container" style="display:none;">
		<div class="container-fluid px-4">
			<h1 class="mt-4">게시글</h1>
			<div class="card mb-4">
				<div class="card-body">
					<form id="board-detail" method="GET">
							<label id="no" class="form-label">게시글 번호 : </label>
							<label id="hit" class="form-lable">조회수 : </label>
							<label id="createdAt" class="form-label">작성 날짜 : </label>
							<label id="userId" class="form-label">글쓴이 : </label>


							<label for="title" class="form-label">제목</label>
							<input type="text"  id="title" name="title" value="???" readOnly/>


							<label for="content" class="form-label">내용</label>
							<textarea  id="content" name="content" rows="7" readOnly></textarea>

						<button type="button" id="list-btn" class="btn btn-outline-secondary">목록</button>
						<button type="button" id="modify-btn" class="btn btn-outline-warning">수정하기</button>
						<button type="button" id="delete-btn" class="btn btn-outline-danger">삭제</button>
						<button type="button" id="update-btn" style="display:none;">수정완료</button>
						<button type="button" id="cancel-btn" style="display:none;">취소</button>
					</form>
				</div>
			</div>
		</div>

		<div id="comment-container">
			<form id="comment-form" method="POST" action="">
				<input type="hidden" name="userId" id="commentId" value="">
				<textarea rows="2"></textarea>
				<button name></button>
			</form>
		</div>
	</div>

	<%--  --%>
	<form id="form-changePage" method="get" action="">
		<input type="hidden" name="pgno" id="pgno" value="${pgno}">
		<input type="hidden" name="key" value="${key}">
		<input type="hidden" name="word" value="${word}">
	</form>

	<form id="form-boardDetail" method="get" action="${root}/article/view">
		<input type="hidden" name="pgno" value="${pgno}">
		<input type="hidden" name="key" value="${key}">
		<input type="hidden" name="word" value="${word}">
		<input type="hidden" id="boardNo" name="boardNo" value="">
	</form>
	<!-- Footer-->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<footer id="footer"></footer>

	<script>
		//현재 url의 path를 받아온다.
		const pathName = window.location.pathname;
		const segments = pathName.split('/');
		// board/list/2/1 -> /board/list/게시판타입/페이지번호
		let boardType = segments[3];
		console.log(segments)

		//페이지 첫 로딩시 1번만 수행할 메소드
		window.onload = () => {
			fetch('/board/lists/' + boardType+ "/1")
					.then(response => response.json())
					.then(data => {
						console.log(data)
						makeList(data.list);
						makePageDetail(data.pageResult)
					});
		}

		let listContainer = document.getElementById("list-container")
		let detailContainer = document.getElementById("detail-container")

		let no = document.getElementById("no")
		let title = document.getElementById("title")
		let hit= document.getElementById("hit")
		let content = document.getElementById("content")
		let userId = document.getElementById("userId")
		let createdAt = document.getElementById("createdAt")

		let updateBtn  =  document.getElementById("update-btn");
		let cancelBtn  =  document.getElementById("cancel-btn");
		let listBtn    =  document.getElementById("list-btn");
		let modifyBtn  =  document.getElementById("modify-btn");
		let deleteBtn  =  document.getElementById("delete-btn");

		function makePageDetail(pageResult){
			//게시글 총 갯수 출력
			document.querySelector("#totalCnt").innerText=`전체 게시글 수 : \${pageResult.totalBoard}`;
			//게시글 페이지 수 작성
			let insertLoc = document.querySelector("#pagination")
			insertLoc.innerHTML= pageResult.listHTML;

			//리스트를 이동하는
			let pages = document.querySelectorAll(".page-link");
			pages.forEach(function (page) {
				page.addEventListener("click", function () {
					let pageNo = this.parentNode.getAttribute("data-pg");
					this.parentNode.active= true;
					fetch('/board/lists/' + boardType+ "/" + pageNo)
							.then(response => response.json())
							.then(data => {
								console.log(data)
								makeList(data.list);
								makePageDetail(data.pageResult)
							});

				});
			});
		}


		function makeList(list) {
			const tbody = document.querySelector("#board-list")
			//tbody.innerHTML = ""
			let inner = "";
			list.forEach((board) => {
				//console.log(board)
				inner +=
				`<tr>
					<td><strong>\${board.no}<strong></td>
					<td><a href="#" id="board-title" data-no="\${board.no}">\${board.title}</a></td>
					<td>\${board.userId}</td>
					<td>\${board.hit}</td>
					<td>\${board.createdAt}</td>
				</tr>`
			})
			tbody.innerHTML = inner;

			let aTags = document.querySelectorAll("#board-title");
			for(let i = 0 ; i < aTags.length; ++i) {
				aTags[i].addEventListener("click", function () {
					fetch("/board/detail/" + boardType + "/" + list[i].no)
							.then(response => response.json())
							.then(data => detailView(data))
				})
			}

		}

		function detailView(details){
			console.log(details)
			listContainer.style.display="none";
			detailContainer.style.display="block";
			//상세 정보 입력
			no.innerText 		+= details.no;
			hit.innerText 		+= details.hit;
			userId.innerText 	+= details.userId;
			createdAt.innerText += details.createdAt;
			title.value 		 = details.title;
			content.textContent  = details.content;

			//버튼 별로 이벤트 지정
			listBtn.addEventListener('click', function() {
				window.location.href="/board/list/" + boardType;
			})

			deleteBtn.addEventListener('click', function() {
				if(confirm("정말 삭제하시겠습니까?")){
					fetch("/board/delete/"+ boardType + "/" + details.no , {
						method : 'DELETE'
					})
							.then(response => response.text())
							.then(data => {
								console.log(data)
								return window.location.href = data;
							})
				}
			})

			modifyBtn.addEventListener('click', function() {
				updateBtn.style.display="block";
				cancelBtn.style.display="block";
				listBtn.style.display="none";
				modifyBtn.style.display="none";
				deleteBtn.style.display="none";
				title.removeAttribute('readOnly')
				content.removeAttribute('readOnly');
			})

			cancelBtn.addEventListener('click', function() {
				if(confirm("현재 작업중인 내용이 취소됩니다. 괜찮으신가요?")){
					title.setAttribute('readOnly', true)
					content.setAttribute('readOnly', true);
					title.value=details.title;
					content.value=details.content;
				}
				updateBtn.style.display="none";
				cancelBtn.style.display="none";
				listBtn.style.display="block";
				modifyBtn.style.display="block";
				deleteBtn.style.display="block";

			})
			updateBtn.addEventListener('click', function() {
				const form = document.querySelector("#board-detail")
				form.setAttribute("action", "/board/modify/" + boardType +"/" + details.no)
				form.submit();
			})
		}

		//글쓰기 버튼 이벤트 등록
		document.querySelector("#write-btn").addEventListener('click', () => {
			window.location.href="/board/write";
		})

	</script>
</body>
</html>

