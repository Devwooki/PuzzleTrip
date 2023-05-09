<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="/include/head.jsp" %>
    <link href="${root}/WebResource/css/login.css" rel="stylesheet" />
  </head>
  <body>
    <%@ include file="/include/nav.jsp" %>
    <c:if test="${cookie.user_id.value ne null}">
      <c:set var="idck" value=" checked" />
      <c:set var="saveid" value="${cookie.user_id.value}" />
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
              <form id="form-login" method="POST" action="${root}/user">
                <input type="hidden" name="action" value="login" />

                <div>
                  <label for="name">ID :</label>
                  <span style="float: right">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="ok"
                      id="saveid"
                      name="saveid"
                      ${idck}
                    />
                    <label class="form-check-label" for="saveid">
                      아이디저장
                    </label>
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
                <div style="padding: 10px; color: red">
                  <% if("wrong".equals(msg)) out.println("아이디 혹은 비밀번호가 틀렸습니다."); %>
                </div>
                <div class="login-loginButton">
                  <button
                    class="login-button"
                    id="login-button"
                    type="submit"
                    onclick="login()"
                  >
                    로그인
                  </button>
                </div>
                <div style="margin: 2%; text-align: center">
                  <a href="${root}/user?action=findPwForm"
                    >비밀번호를 잊어버리셨나요?</a
                  >
                </div>
              </form>
            </div>
            <!-- 회원가입창 form 끝-->

            <!-- 회원가입창 footer  시작-->
            <div class="register-center-footer">
              <h3>SNS 계정 로그인</h3>
              <div class="login-sns-login">
                <a href="CommingSoon.html"
                  ><button class="login-button" id="kakaoBtn" type="button">
                    KaKao
                  </button></a
                >
                <a href="CommingSoon.html"
                  ><button class="login-button" id="naverBtn" type="button">
                    Naver
                  </button></a
                >
                <a href="CommingSoon.html"
                  ><button class="login-button" id="googleBtn" type="button">
                    Google
                  </button></a
                >
                <a href="CommingSoon.html"
                  ><button class="login-button" id="appleBtn" type="button">
                    Apple
                  </button></a
                >
              </div>
            </div>
            <!-- 회원가입창 footer끝! -->
          </div>

          <!-- 좌우 여백 맞추기용 div-container -->
          <div class="register-container-right"></div>
          <!-- 좌우 여백 맞추기용 div-container -->
        </div>
      </div>
    </main>
    <!-- Footer-->
    <%@ include file="/include/footer.jsp" %>
    <footer id="footer"></footer>
    <!--     Bootstrap core JS -->
    <!--     <script type="module" src="js/drwaHeaderFooter.js"></script> -->
    <script>
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
