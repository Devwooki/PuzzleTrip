<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="include/head.jsp" %>

<body>
<%@ include file="include/nav.jsp" %>
<main>
  <div id="wrapper">
    <!-- 헤더 시작-->
    <section>
      <!-- 관광지 드롭다운메뉴 시작-->
      <div class="background" style="padding: 1%;">
        <div class="list-container">
          <header class="bg-dark py-5">
            <div class="container px-5">
              <div class="row gx-5 align-items-center justify-content-center">
                <div class="col-lg-8 col-xl-7 col-xxl-6">
                  <div class="my-5 text-center text-xl-start">
                    <h1 class="display-5 fw-bolder text-white mb-2">
                      Enjoy Trip으로
                    </h1>
                    <h1 class="display-5 fw-bolder text-white mb-2">
                      여행을 시작해보세요!
                    </h1>
                    <p class="lead fw-normal text-white-50 mb-4">
                      지역별 다양한 여행지를 확인해보고,
                      나만의 여행지를 만들어 여행 계획을 세워보세요
                    </p>
                    <div
                            class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start"
                    >

                      <!-- <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#features">Get Started</a> -->
                      <a class="btn btn-outline-light btn-lg px-4"
                         href="${root}/attraction/searchtrip">Go Search</a>
                    </div>
                  </div>
                </div>
                <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
                  <img
                          class="img-fluid rounded-3 my-5"
                          src="/resources/static/img/airplane.jpg"
                          alt="..."
                  />
                </div>
              </div>
            </div>
          </header>
        </div>
      </div>                        <!-- 관광지 드롭다운메뉴 끝-->
    </section>

    <section>
      <!-- 관광지 드롭다운메뉴 시작-->
      <h1 id="card-header">
        where you want?
      </h1>
      <!-- <div style="margin: -1% 5%;"> -->
      <div class="center">
        <div class="article-card">
          <div class="content">
            <!-- <p class="date">Jan 1, 2022</p> -->
            <p class="title">서울</p>
          </div>
          <img src="/resources/static/img/seoul.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">부산</p>
          </div>
          <img src="/resources/static/img/busan.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">대구</p>
          </div>
          <img src="/resources/static/img/daegu.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">인천</p>
          </div>
          <img src="/resources/static/img/incheon.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">광주</p>
          </div>
          <img src="/resources/static/img/gwangju.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">대전</p>
          </div>
          <img src="/resources/static/img/daejeon.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">울산</p>
          </div>
          <img src="/resources/static/img/ulsan.jpg" alt="article-cover"/>
        </div>
        <div class="article-card">
          <div class="content">
            <p class="title">경기</p>
          </div>
          <img src="https://images.unsplash.com/photo-1482877346909-048fb6477632?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=958&q=80"
               alt="article-cover"/>
        </div>
      </div>
    </section>


  </div>
</main>


<!-- Footer-->
<%@ include file="include/footer.jsp" %>
<!-- footer 시작 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>