
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>EnjoyTrip - 글작성</title>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/nav.jsp"%>
    <header id="header"></header>
    <form id="form-register" method="POST" enctype="multipart/form-data" action="">

        <select id="select-type">
            <option value="0" selected>게시판 선택</option>
            <option value="1">공지사항</option>
            <option value="2">일반 게시판</option>
        </select>
        <input type="hidden" name="typeNo" value="1"><!-- 게시판 타입 -->
        <input type="hidden" name="pgno" value="1"><!-- 작성 후 이동할 페이지 위치 -->
        <input type="hidden" name="key" value=""><!-- 검색 키워드인데 아직 미구현 -->
        <input type="hidden" name="word" value=""><!-- 검색할 단어 아직 미구현-->
        <div id="title-div">
            <label for="title" >제목 : </label>
            <input type="text" id="title" name="title" placeholder="제목..."/>
        </div>
        <div id="userid-div">
            <label for="userId" >작성자 : </label>
            <input type="text" id="userId" name="userId" placeholder="제목..." value="ssafy" readonly/>
        </div>
        <div class="content-div">
            <label for="content">내용 : </label>
            <textarea id="content" name="content" rows="7"></textarea>
        </div>
        <div class="file-div">
            <label for="file" >파일:</label>
            <input type="file" id="file" name="file" multiple="multiple">
        </div>

        <div class="btn-div">
            <button type="button" id="write-btn">
                글작성
            </button>
            <button type="button" id="back-btn">
                취소
            </button>
        </div>
    </form>
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <footer id="footer"></footer>
<script>
    let boardType = 2;

    console.log("${root}")
    document.querySelector("#write-btn").addEventListener('click', ()=>{
        if (!document.querySelector("#title").value) {
            alert("제목 입력!!");
            return;
        } else if (!document.querySelector("#content").value) {
            alert("내용 입력!!");
            return;
        } else {
            let form = document.querySelector("#form-register");
            form.setAttribute("action", "${root}/board/write/" + boardType);
            form.submit();
        }
    });

    document.querySelector("#back-btn").addEventListener("click", function () {
        if(confirm("작성한 글은 삭제됩니다.\n취소하시겠습니까?")) {
            let form = document.querySelector("#form-param");
            window.history.back();
        }
    });

    document.querySelector("#select-type").addEventListener("change", function () {
        boardType = document.querySelector("#select-type").value;
        console.log(boardType);
    });
</script>
</body>


</html>
