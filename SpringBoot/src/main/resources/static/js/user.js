// 로그인
function login() {
  // 사용자 정보를 입력받는다.
  var userid = prompt("아이디입력", "ssafy");
  if (userid.length == 0) {
    alert("아이디 입력!!!");
    return;
  }
  var userpass = prompt("비밀번호입력", "1234");
  if (userpass.length == 0) {
    alert("비밀번호 입력!!!");
    return;
  }
  if (userid == "ssafy" && userpass == "1234") {
    alert("로그인 성공!!!");
    // id가 profile_img인 element의 src 속성의 값을 img/profile.png로 설정.
    // document.getElementById("profile_img").src = "img/profile.png";
    document.getElementById("header_nav_confirm_off").style.display = "none";
    document.getElementById("header_nav_confirm_on").style.display = "block";
  } else {
    alert("아이디 또는 비밀번호 확인!!!");
  }
}

// 로그아웃
function logout() {
  /* document.getElementById("profile_img").src = "img/profile.png";
	document.getElementById("header_nav_confirmon").style.display = "none";
	document.getElementById("header_nav_confirmoff").style.display = "block"; */
  // id가 profile_img인 element의 src 속성의 값을 img/noimg.png로 설정.
  //   document.querySelector("#profile_img").setAttribute("src", "img/noimg.png");
  document.querySelector("#header_nav_confirm_on").setAttribute("style", "display: none");
  document.querySelector("#header_nav_confirm_off").setAttribute("style", "display: block");
}
