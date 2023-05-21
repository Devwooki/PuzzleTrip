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
<%--<header id="header"></header>--%>
<main>
  <div id="wrapper">
    <div class="register-container">
      <div class="register-container-left"></div>
      <div class="register-container-center">
        <!-- 회원가입창 Header -->
        <div class="register-center-header">
          <h1>회원가입</h1>
        </div>

        <!-- 회원가입창 form 시작-->
        <form id="joinForm" method="POST" action="">
          <div class="register-center-body">
            <div>
              <label for="name">이름 :</label>
              <input
                      class="login-input"
                      name="name"
                      id="name"
                      type="text"
                      placeholder="이름..."
              />
            </div>
            <div>
              <label for="name">아이디 :</label>
              <input
                      class="login-input"
                      name="id"
                      id="id"
                      type="text"
                      placeholder="아이디..."
              />
            </div>
            <div id="idcheck-result"></div>
            <div>
              <label for="name">비밀번호 :</label>
              <input
                      class="login-input"
                      name="pw"
                      id="password"
                      type="password"
                      placeholder="비밀번호..."
              />
            </div>
            <div>
              <label for="name">비밀번호확인:</label>
              <input class="login-input" id="check-password" name="pwcheck" type="password"
                     placeholder="비밀번호확인..."/>
            </div>

            <div id="email-form">
              <div id="input-email">
                <input class="login-input" name="email" id="email" type="text" placeholder="이메일..."/>
              </div>

              <div>@</div>
              <div id="domain-container">
                <input class="login-input" name="emailDomain" id="input-domain" type="text"
                       placeholder=""/>
                <select name="emailDomain" id="select-domain" onchange="changeInputValue()">
                  <option value="0" selected>도메인 선택</option>
                  <option value="naver.com">네이버</option>
                  <option value="duam.net">다음</option>
                  <option value="gmail.com">Gmail</option>
                  <option value="self">직접입력..</option>
                </select>
              </div>
            </div>
            <div class="login-loginButton">
              <button class="login-button" id="register-button" type="button" onclick="register()">
                회원가입
              </button>
            </div>
          </div>
        </form>
        <!-- 회원가입창 form 끝-->
      </div>
      <div class="register-container-right">
      </div>
    </div>
  </div>

</main>
<!-- Footer-->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<footer id="footer"></footer>
<!--     Bootstrap core JS -->
<!--     <script type="module" src="js/drwaHeaderFooter.js"></script> -->
<script>
  let isUseId = false;
  document.querySelector("#id").addEventListener("keyup", () => {
    let userId = document.querySelector("#id").value;
    let resultDiv = document.querySelector("#idcheck-result");
    if (userId.length < 6 || userId.length > 20) {
      resultDiv.setAttribute("class", "mb-3 text-dark");
      resultDiv.innerText = "아이디는 6자 이상 20자 이하 입니다.";
      isUseId = false;
    } else {
      fetch("${root}/user/idCheck/" + userId)
              .then(response => response.text())
              .then(data => {
                console.log(data.length);
                if (data.length === 0) {
                  resultDiv.setAttribute("class", "mb-3 text-primary");
                  res태ultDiv.textContent = userId + "는 사용할 수 있습니다.";
                  isUseId = true;
                } else {
                  resultDiv.setAttribute("class", "mb-3 text-danger");
                  resultDiv.textContent = userId + "는 이미 존재하는 아이디 입니다.";
                  isUseId = false;
                }
              });
    }
  });

  function changeInputValue() {
    const select = document.getElementById("select-domain");
    const input = document.getElementById("input-domain");

    if (select.value === "self") {
      input.value = "";
      input.disabled = false;
      input.focus();
    } else {
      input.value = select.value;
      input.disabled = true;
    }
  }

  function register() {
    const name = document.getElementById('name').value;
    const id = document.getElementById('id').value;
    const password = document.getElementById('password').value;
    const checkPassword = document.getElementById('check-password').value;

    const inputDomain = document.getElementById('input-domain').value;
    const selectDomain = document.getElementById('select-domain').value;
    // 이메일 유효성 검사
    const email = document.getElementById('email').value;
    const emailRegex = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)$/;
    const emailValid = emailRegex.test(email);

    // 이름 유효성 검사
    if (name === '') {
      alert('이름을 입력해주세요.');
      return;
    }else if (id === '') {
      alert('아이디를 입력해주세요.');
      return;
    }else if (password === '') {
      alert('비밀번호를 입력해주세요.');
      return;
    }else if (password !== checkPassword) {
      alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      return;
    }else if (email === '') {
      alert('이메일을 입력해주세요.');
      return;
    }else if (selectDomain === '0' && inputDomain === '') {
      alert('이메일 주소를 입력해주세요.');
      return;
    }else if (isUseId == false) {
      alert('아이디의 글자 수를 확인해 주세요');
      return;
    }else{
      let form = document.querySelector("#joinForm");
      form.setAttribute("action", "${root}/user/join");
      form.submit();
      return;
    }
  }
</script>
</body>
</html>