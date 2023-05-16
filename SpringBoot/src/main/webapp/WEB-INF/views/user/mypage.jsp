<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href="/resources/static/css/login.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<header id="header"></header>

<main>
    <div id="wrapper">
        <div class="register-container">
            <div class="register-container-left"></div>
            <div class="register-container-center">
                <!-- 회원가입창 Header -->
                <div class="register-center-header">
                    <h1>마이페이지</h1>
                    <h3>기본정보</h3>
                </div>

                <!-- 회원가입창 form 시작-->
                <form id="modifyForm" method="post" action="">
                    <div class="register-center-body">
                        <div>
                            <label for="name">이름 :</label>
                            <input
                                    class="login-input"
                                    id="name"
                                    name="name"
                                    type="text"
                                    placeholder=""
                                    value="${userInfo.name}"
                            />
                        </div>
                        <div>
                            <label for="id">아이디 :</label>
                            <input
                                    class="login-input"
                                    id="id"
                                    name="id"
                                    type="text"
                                    placeholder=""
                                    value="${userInfo.id}"
                                    readonly
                            />
                        </div>
                        <!-- 비밀번호 수정은 현재 비밀번호와 체크후 같으면 띄우기 -->
                        <div>
                            <button type="button" id="modifyPwBtn" onclick="floatChangePw()">비밀번호 변경</button>
                            <span id="nowPwSpan" style="display:none;">
                                    <label for="nowPw">현재 비밀번호 : </label>
                                    <input type="password" class="login-input" id="nowPw" name="nowPw">
                                    <%-- 현재 유저의 비밀번호가 정확한지 체크 --%>
                                    <div id="pwCheck-result"></div>
                                </span>
                            <div id="nextPwContainer" style="display: none;" >
                                <span>
                                    <label for="pw">새 비밀번호 : </label>
                                    <input type="password" class="login-input" id="pw" name="pw">
                                </span>
                                <span>
                                    <label for="checkNextPw">새 비밀번호 확인 : </label>
                                    <input type="password" class="login-input" id="checkNextPw" name="checkNextPw">
                                </span>
                            </div>

                        </div>

                        <label for="name">이메일:</label>
                        <div id="email-form" style="align-self: center;">
                            <div id="input-email">
                                <input class="login-input" id="email" name="email" type="text" placeholder="이메일..."
                                       value="${userInfo.email}"/>
                            </div>
                            <div>@</div>
                            <div id="domain-container">
                                <input class="login-input" id="emailDomain" name="emailDomain" type="text"
                                       placeholder="" value="${userInfo.emailDomain}"/>
                                <select id="select-domain" onchange="changeInputValue()">
                                    <option value="0" selected>도메인 선택</option>
                                    <option value="naver.com">네이버</option>
                                    <option value="duam.net">다음</option>
                                    <option value="gmail.com">Gmail</option>
                                    <option value="self">직접입력..</option>
                                </select>
                            </div>
                        </div>
                        <div class="login-loginButton">
                            <button class="login-button" id="modifyBtn" type="button" onclick="modified()">
                                수정
                            </button>

                            <button class="login-button" id="deleteBtn" type="button" onclick="deleteUser()">
                                탈퇴
                            </button>
                        </div>
                    </div>
                </form>
                <!-- 회원가입창 form 끝-->

                <!-- 회원가입창 footer  시작-->
                <div class="register-center-footer">
                </div>
                <!-- 회원가입창 footer끝! -->

            </div>
            <div class="register-container-right">
            </div>
        </div>
</main>
<!-- Footer-->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<footer id="footer"></footer>
<!--     <script type="module" src="./js/drwaHeaderFooter.js"></script> -->
<script>

    document.querySelector("#nowPw").addEventListener("keyup", () => {
        let userId = document.querySelector("#id").value
        let userPw = document.querySelector("#nowPw").value;
        let resultDiv = document.querySelector("#pwCheck-result");

        let userData ={
            id : userId,
            pw : userPw
        }

        const config ={
            method : 'POST',
            headers  : {"Content-Type" : "application/json"},
            body : JSON.stringify(userData)
        }



        fetch("${root}/user/pwCheck", config)
            .then(response => response.json())
            .then(data => {
                if (data.pw == null) { //현재 비밀번호가 틀렸을 때
                    resultDiv.setAttribute("class", "mb-3 text-danger");
                    resultDiv.textContent = "비밀번호가 일치 하지 않습니다.";
                } else { //비밀번호가 일치할 때
                    resultDiv.textContent = "";
                    document.querySelector("#nextPwContainer").style.display="block";
                    //비밀번호가 같으면 현재 비밀번호창 수정 못하게 막고
                    document.querySelector("#nowPw").readOnly = true;
                    //입력 커서를 새 비밀번호 창으로 바꾼다.
                    document.querySelector("#pw").focus()


                }
            });
    });

    function floatChangePw() {
        document.getElementById("modifyPwBtn").style.display = "none";
        document.getElementById("nowPwSpan").style.display = "block";
    }

    //루트 경로 가변적임
    function modified() {
        const name = document.getElementById('name').value;
        const id = document.getElementById('id').value;

        const nowPw = document.getElementById('nowPw').value;
        const nextPw = document.getElementById('pw').value;
        const checkNextPw = document.getElementById('checkNextPw').value;

        const inputDomain = document.getElementById('emailDomain').value;
        const selectDomain = document.getElementById('select-domain').value;
        // 이메일 유효성 검사
        const email = document.getElementById('email').value;
        const emailRegex = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)$/;
        const emailValid = emailRegex.test(email);

        // 이름 유효성 검사
        if (name === '') {
            alert('이름을 입력해주세요.');
            return;
        } else if (id === '') {
            alert('아이디를 입력해주세요.');
            return;
        } else if (nowPw === '') { //AJAX 처리
            alert('비밀번호를 입력해주세요.');
            return;
        } else if (nowPw === nextPw) {
            alert('현재 비밀번호와 새 비밀번호가 같습니다.');
            return;
        } else if (checkNextPw !== nextPw) {
            alert('새 비밀번호를 확인해 주세요.');
            return;
        } else if (email === '') {
            alert('이메일을 입력해주세요.');
            return;
        } else if (selectDomain === '0' && inputDomain === '') {
            alert('이메일 주소를 입력해주세요.');
            return;
        } else {
            let form = document.querySelector("#modifyForm");
            form.setAttribute("action", "${root}/user/modify");
            console.log(form)
            form.submit();
            alert("유저 정보를 수정했습니다.");
        }
    }

    function deleteUser() {
        if (confirm("정말 회원을 탈퇴 하시겠습니까?")) {
            alert("계정이 삭제되었습니다.");
            let form = document.getElementById("modifyForm");
            form.setAttribute("action", "${root}/user/delete");
            form.submit();
        }
    }

    function changeInputValue() {
        const select = document.getElementById("select-domain");
        const input = document.getElementById("emailDomain");
        console.log(select.value)
        if (select.value === "self") {
            input.value = "";
            input.readOnly = false;
            input.focus();
        } else {
            input.value = select.value;
            input.readOnly = true;
            console.log(select.value)

        }
    }
</script>
</body>
</html>