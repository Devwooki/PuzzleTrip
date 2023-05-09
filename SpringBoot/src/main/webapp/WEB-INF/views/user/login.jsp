<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href="/resources/static/css/login.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>

<c:if test="${cookie.idCookie.value ne null}">
    <c:set var="idck" value="checked"/>
    <c:set var="saveid" value="${cookie.idCookie.value}"/>
</c:if>


<header id="header"></header>
<main>
    <div id="wrapper">
        <div class="register-container">

            <!-- 좌우 여백 맞추기용 div-container -->
            <div class="register-container-right"></div>
            <!-- 좌우 여백 맞추기용 div-container -->

            <div class="register-container-center">
                <!-- 회원가입창 Header -->
                <div class="register-center-header">
                    <h1>로그인</h1>
                </div>

                <!-- 회원가입창 form 시작-->
                <div class="register-center-body">
                    <form id="form-login" method="POST" action="${root}/user/login">
                        <input type="hidden" name="action" value="login">
                        <div>
                            <label for="name">ID :</label>
                            <span style="float: right;">
	              <input
                          class="form-check-input"
                          type="checkbox"
                          id="saveId"
                          name="saveId"
                          value="ok"
                  ${idck}
                  />

                <label class="form-check-label" for="saveid"> 아이디저장 </label>
                </span>
                            <input
                                    class="login-input"
                                    name="id"
                                    id="id"
                                    type="text"
                                    placeholder="ID를 입력해주세요"
                                    value="${saveid}"
                            />
                        </div>
                        <div>
                            <label for="name">PASSWORD :</label>
                            <input
                                    class="login-input"
                                    name="pw"
                                    id="password"
                                    type="password"
                                    placeholder="PW를 입력해주세요"
                            />
                        </div>
                        <% String msg = request.getParameter("error"); %>
                        <div style="padding: 10px; color: red;">
                            <% if("wrong".equals(msg)) out.println("아이디 혹은 비밀번호가 틀렸습니다."); %>
                        </div>
                        <div class="login-loginButton">
                            <button class="login-button" id="login-button" type="submit" onclick="login()">
                                로그인
                            </button>
                        </div>
                        <div style="margin: 2%; text-align: center;">
                            <a href="${root}/user/findPw">비밀번호를 잊어버리셨나요?</a>
                        </div>
                    </form>
                </div>
                <!-- 회원가입창 form 끝-->

            </div>

            <!-- 좌우 여백 맞추기용 div-container -->
            <div class="register-container-right"></div>
            <!-- 좌우 여백 맞추기용 div-container -->

        </div>
    </div>
</main>
<!-- Footer-->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<footer id="footer"></footer>
<!--     Bootstrap core JS -->
<!--     <script type="module" src="js/drwaHeaderFooter.js"></script> -->
<script>
    <c:if test="${not empty msg}">
        alert("${msg}");
    </c:if>
    let headerEle = document.querySelector(".header-user");
    console.log(headerEle);

    // 로그인
    function login() {
        // 사용자 정보를 입력받는다.
        let userid = document.querySelector("#id").value;
        let userpass = document.querySelector("#password").value;

        if (userid.trim() === "" || userpass.trim() === "") {
            alert("아이디 혹은 비밀번호를 입력해주십시오.");
            return;
        }
        console.log(userid, userpass);

        //백엔드 이후 작업
        //유효성 체크 후 화면 전환
        /*
         */
//         window.location.replace("index.html");
    }
</script>
</body>
</html>