<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- jstl 사용하기 위한 코드 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 프로젝트의 context 경로를 편하게 사용하기 위한 코드 --%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content />
    <meta name="author" content />
    <title>Modern Business - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/resources/static/css/search.css" rel="stylesheet" />
    <link href="/resources/static/css/header.css" rel="stylesheet" />
    <link href="/resources/static/css/footer.css" rel="stylesheet" />
    <link href="/resources/static/css/login.css" rel="stylesheet" />
  </head>
  <body>
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>

	<%-- 페이지만의 내용 --%>
	<div class="container p-4">
		오류가 발생했습니다.
		<div>
			<a href="${root}">메인 화면으로 이동</a>
		</div>
	</div>
	<%-- --%>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>