<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- jstl 사용하기 위한 코드 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 프로젝트의 context 경로를 편하게 사용하기 위한 코드 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<div class="header-elements" style="height: 70px;">
<div class="header-content">
  <div class="header-img">
    <a href="/">
      <img src="/resources/static/img/logo.png" style="width: auto;" title="홈으로">
    </a>
  </div>
</div>

  <div class="header-other-page">
    <a href="${root}/attraction/searchtrip">여행지 선택</a>
    <a href="${root}/attraction/makePlan">여행 계획</a>
    <a href="${root}/attraction/hotplace">핫플</a>
    <a href="${root}/board/lists/1">공지사항</a>
    <a href="${root}/board/lists/2">게시판</a>
  </div>

  <c:if test="${empty userInfo}">
	  <div class="header-user">
	    <a href="${root}/user/login">로그인</a>
	    <a href="${root}/user/join">회원가입</a>
<!-- 	    <a href="mypage.jsp">마이페이지</a> -->
	  </div>
  </c:if>
  
  <c:if test="${not empty userInfo}">
	  <div class="header-user">
	  	<strong>${userInfo.name}</strong> (${userInfo.id})님 안녕하세요.
		<a href="${root}/user/logout">로그아웃</a>
<!-- 	    <a href="register.jsp">회원가입</a> -->
	    <a href="${root}/user/mypage">마이페이지</a>
	  </div>
  </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>