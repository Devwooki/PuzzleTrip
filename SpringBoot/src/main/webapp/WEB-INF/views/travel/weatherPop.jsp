<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="weather_wrap">
		<div id="today_weather">오늘의 날씨</div>
		<!-- 이미지 경로-->
		<div id=weatherimg_wrap>
			<img id="weather-icon" src="" alt="Weather icon" />
		</div>
		<!-- 이미지 정보-->
		<div id="name"></div>
		<div id="weatherinfo">
			<div id="weathertitle">기온:</div>
			<div id="temp"></div>
			<div class="temperature">도</div>
		</div>
		<div id="weatherinfo">
			<div id="weathertitle">습도:</div>
			<div id="hum"></div>
			<div class="humidity">도</div>
		</div>
	</div>
</body>

