<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href="/resources/static//css/login.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<main>
    <div id="wrapper">
        <div class="register-container">
            <!-- 좌우 여백 맞추기용 div-container -->
            <div class="register-container-left"></div>

            <!-- div-container -->
            <div class="register-container-center">
                <!-- 회원가입창 Header -->
                <div class="register-center-header">
                    <h1>비밀번호 찾기</h1>
                </div>

                <!-- 회원가입창 form 시작-->
                <div class="register-center-body">
                    <form id="findPwForm" method="POST" action="">
                        <div>
                            <label for="id">가입하신 아이디를 입력해 주세요.</label>
                            <input
                                    class="login-input"
                                    name="id"
                                    id="id"
                                    type="text"
                                    placeholder="ID를 입력해주세요"
                            />
                        </div>
                        <div id="pwContainer" style="display: none;">
                            <label for="pw">변경할 비밀번호를 입력해 주세요.</label>
                            <input
                                    class="login-input"
                                    name="pw"
                                    id="pw"
                                    type="text"
                                    placeholder="변경할 비밀번호 입력"
                            />
                        </div>
                        <div class="login-loginButton">
                            <button class="login-button" id="findId-button" type="button" onclick="checkInput()">
                                확인
                            </button>
                            <button class="login-button" id="updatePw-button" type="button" onclick="passwordSubmit()" style="display: none;">
                                비밀번호 변경
                            </button>
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


<script>
    let headerEle = document.querySelector(".header-user");

    function checkInput() {
        let userId = document.querySelector("#id").value;
        let pwContainer = document.querySelector("#pwContainer")

        console.log(userId);
        console.log(userId.trim() == "")
        if (userId.trim() == "") {
            alert("아이디 혹은 이름을 입력해주십시오.");
            return;
        } else {
            fetch("${root}/user/idCheck/" + userId)
                .then(response => response.text())
                .then(data => {
                    console.log(data.length);
                    if (data.length === 0) {//아이디가 없을 때
                        alert("아이디가 존재하지 않습니다.");
                        return;
                    } else {//아이디가 있을 때
                        pwContainer.style.display = "block";
                        document.getElementById("findId-button").style.display="none";
                        document.getElementById("updatePw-button").style.display="block";
                    }
                });
        }
    }

    function passwordSubmit(){
        let form = document.getElementById("findPwForm")
        form.setAttribute("action", "${root}/user/findPw")
        form.submit();
    }
</script>
</body>
</html>