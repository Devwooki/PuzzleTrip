<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href="/resources/static/css/search.css" rel="stylesheet"/>
    <link href="/resources/static/css/weather.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<main>
    <div id="wrapper">
        <section>
            <!-- 관광지 검색 기능 추가 -->
            <div>
                <div class="search-search-container">
                    <div>
                        <h2>여행지 선택</h2>
                    </div>
                    <div class="search-select">
                        <select id="area" onchange="getGugun()">
                            <option value="0" selected>지역 선택</option>
                            <option value="1">서울특별시</option>
                            <option value="8">세종특별시</option>
                            <option value="39">제주특별시</option>
                            <option value="6">부산광역시</option>
                            <option value="4">대구광역시</option>
                            <option value="2">인천광역시</option>
                            <option value="5">광주광역시</option>
                            <option value="3">대전광역시</option>
                            <option value="7">울산광역시</option>
                            <option value="31">경기</option>
                            <option value="32">강원</option>
                            <option value="33">충북</option>
                            <option value="34">충남</option>
                            <option value="37">전북</option>
                            <option value="38">전남</option>
                            <option value="35">경북</option>
                            <option value="36">경남</option>
                        </select>
                        <select id="gugun" onchange="getContent()">
                            <option value="0" selected>구군선택</option>
                        </select>
                    </div>
                </div>

                <div class="search-search-container">
                    <div class="search-checkbox">
                        <input type="hidden" name="action" value="contentType"/>
                        <fieldset>
                            <label> <input type="checkbox" name="contentType"
                                           value="12"/>관광지
                            </label> <label> <input type="checkbox" name="contentType"
                                                    value="14"/>문화시설
                        </label> <label> <input type="checkbox" name="contentType"
                                                value="15"/>축제공연행사
                        </label> <label> <input type="checkbox" name="contentType"
                                                value="25"/>여행코스
                        </label>
                            <label> <input type="checkbox" name="contentType"
                                           value="28"/>레포츠
                            </label> <label> <input type="checkbox" name="contentType"
                                                    value="32"/>숙박
                        </label> <label> <input type="checkbox" name="contentType"
                                                value="38"/>쇼핑
                        </label> <label> <input type="checkbox" name="contentType"
                                                value="39"/>음식점
                        </label>
                        </fieldset>
                    </div>
                </div>
            </div>


            <!-- 관광지 검색 기능 끝 -->
            <div id="drawingMapStart">
                <!-- 날씨 시작 -->
                <div id="weatherAndStopline">
                    <div id="weather_wrap">
                        <div id="today_weather">오늘의 날씨</div>
                        <!-- 이미지 경로-->

                        <div id=weatherimg_wrap>
                            <img id="weather-icon" src="" alt="Weather icon"
                                 onerror="this.src='https://openweathermap.org/img/w/01d.png'"/>
                        </div>
                        <!-- 이미지 정보-->
                        <div id="name"></div>
                        <div id="weatherinfo">
                            <div id="weathertitle">기온:</div>
                            <div id="temp">0</div>
                            <div class="temperature">도</div>
                        </div>
                        <div id="weatherinfo">
                            <div id="weathertitle">습도:</div>
                            <div id="hum">0</div>
                            <div class="humidity">도</div>
                        </div>
                    </div>
                    <button id="btnLineStart">이제 그려</button>
                    <button id="btnLineStop">그만 그려</button>
                </div>

                <!-- 지도 시작 -->
                <div id="mapStart">
                    <div class="search-mycontainer">
                        <div id="search-map">
                            <div class="custom_typecontrol radius_border">
								<span id="btnRoadmap" class="selected_btn"
                                      onclick="setMapType('roadmap')">지도</span> <span id="btnSkyview"
                                                                                      class="btn"
                                                                                      onclick="setMapType('skyview')">스카이뷰</span>
                            </div>
                        </div>
                        <!-- 지도 출력 끝-->
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<!-- 지도 그리는 영역 -->
<%@ include file="searchTrip-Map.jsp" %>

<script>
    //날씨 정보 창
    function getEnglishName(koreanName) {
        const nameMap = {
            '서울특별시': 'seoul',
            '세종특별시': 'sejong',
            '제주특별시': 'jeju',
            '부산광역시': 'busan',
            '대구광역시': 'daegu',
            '인천광역시': 'incheon',
            '광주광역시': 'gwangju',
            '대전광역시': 'daejeon',
            '울산광역시': 'ulsan',
            '경기'   : 'gyeonggi-do',
            '강원'   : 'gangwon-do',
            '충북'   : 'chungcheongbuk-do',
            '충남'   : 'chungcheongnam-do',
            '전북'   : 'jeollabuk-do',
            '전남'   : 'jeollanam-do',
            '경북'   : 'gyeongsangbuk-do',
            '경남'   : 'gyeongsangnam-do'
        };
        return nameMap[koreanName];
    }

    document.getElementById("area").addEventListener("change", getweather);

    //날씨 정보 얻어오는 함수
    function getweather() {
        const area = document.getElementById("area").value;
        const areaName = document.getElementById("area").options[document.getElementById("area").selectedIndex].text;
        const englishName = getEnglishName(areaName);

        fetch(
            "http://api.openweathermap.org/data/2.5/weather?q=" +
            englishName +
            "&appid=7315a10a3bef7e73b88ed593dc718d1c"
        )
            .then((response) => response.json())
            //.then((reps) => console.log(reps))
            .then((data) => {
                console.log(data);
                // console.log("현재온도 : " + (data.main.temp - 273.15));
                // console.log("현재습도 : " + data.main.humidity);
                // console.log("날씨 : " + data.weather[0].main);
                // console.log("상세날씨설명 : " + data.weather[0].description);
                // console.log("날씨 이미지 : " + data.weather[0].icon);
                // console.log("바람   : " + data.wind.speed);
                // console.log("나라   : " + data.sys.country);
                // console.log("도시이름  : " + data.name);
                // console.log("구름  : " + data.clouds.all + "%");
                let location = (document.getElementById("name").innerText = areaName);
                let temp = (document.getElementById("temp").innerText = Math.floor(
                    data.main.temp - 273.15
                ));
                let humidity = (document.getElementById("hum").innerText =
                    data.main.humidity);
                let imgURL =
                    "http://openweathermap.org/img/w/" + data.weather[0].icon + ".png";
                let imgElement = document
                    .getElementById("weather-icon")
                    .setAttribute("src", imgURL);
            });
    }
</script>
</body>
</html>