const drawH = document.querySelector("#header");
const drawF = document.querySelector("#footer");

const headerHTML = `<div class="header-elements">
<div class="header-content">
  <div class="header-img">
    <a href="index.html">
      <img src="/img/logo2.png" title="홈으로">
      <img src="/img/logo.png" style="width: auto;" title="홈으로">
    </a>
  </div>
</div>

  <div class="header-other-page">
    <a href="searchtrip.html">여행지 선택</a>
    <a href="searchplan.html">여행 계획</a>
    <a href="hotplace.html">핫플</a>
    <a href="borad.html">게시판</a>
  </div>

  <div class="header-user">
    <a href="login.html">로그인</a>
    <a href="register.html">회원가입</a>
    <a href="mypage.html">마이페이지</a>
  </div>
</div>
</div>`;

const footerHTML = `<div class="footer-elements">
<div class="footer-img">
  <img src="./assets/mob_ssafy_logo_blue.png" title="홈으로">
</div>
<div class="footer-content">
    <div>사업자등록번호 123-45-6788</div>
    <div>SSAFY 9기 전공자반 대전 6반</div>
    <div>TEL : 010) 1234-1234 / FAX : 012) 3456-7890</div>
    <div>Copyright &copy; SSAFY 2023</div>
</div>

</div>`;
console.log();
if (drawH !== null) drawH.innerHTML += headerHTML;
if (drawF !== null) drawF.innerHTML += footerHTML;
