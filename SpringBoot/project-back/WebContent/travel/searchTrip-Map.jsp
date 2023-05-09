<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0684d7cb3f95de608b3bc5c60dd45733"
></script>
<script>
  //const serviceKey =
  //  "IHMMiT7zfDAzX30lt8UP%2FhV%2B%2F6JwU4nfQT2hG3%2Bbqe06YIZGcJMJg7dGHRS1Ru841LcAwDK0HvMnHVM%2Bw3zmAQ%3D%3D";
  //"SdHahFYkl5TrW6CyDwsO3zvau4SGCDkpWWaj4xfEtg%2FQa1%2FJ1KKlPmyvhe3u9wYPUmlNyigLRSdsogNtCph%2BLQ%3D%3D";
  const kakaoMapApiKey = "0684d7cb3f95de608b3bc5c60dd45733";

  let map = new kakao.maps.Map(document.getElementById("search-map"), {
      <%--center: new kakao.maps.LatLng("${list[0].latitude}", "${list[0].longitude}"), //지도의 중심좌표. --%>
      center: new kakao.maps.LatLng(36.355297, 127.298126), //지도의 중심좌표.
      level: 5,
  });

  var mapTypeControl = new kakao.maps.MapTypeControl();
  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
  var zoomControl = new kakao.maps.ZoomControl();
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

  // 체크박스 선택 여부에 따라 지도에 출력하는 것이 달라진다.
  const checkboxGroup = document.querySelectorAll('input[name="contentType"]');
  checkboxGroup.forEach(checkbox => {
      checkbox.addEventListener('change', event => {
          let queryString = '&';
          let areaCode = document.getElementById("area").value;
          let gugunCode = document.getElementById("gugun").value;

          checkboxGroup.forEach(checkbox => {
              //console.dir(checkbox.checked)
              if(checkbox.checked){
                  console.log(checkbox.value);
                  queryString +=  `\${checkbox.name}=\${checkbox.value}&`;
              }
          });
          //체크 박스 값들이 있을 때
          if(areaCode !== "0" && gugunCode !== "0" && queryString !== "&"){
              console.log("체크박스 선택")
              fetch("${root}/attraction?action=contents&sido=" + areaCode + "&gugun=" + gugunCode + queryString, {
                  method: 'GET'
              })
                  .then(response => response.json())
                  .then(data => drawMarker(data))
              //체크 박스 값들이 없을 때
          }else if(areaCode !== "0" && gugunCode !== "0" && queryString === "&") {
              console.log("체크박스 미선택")
              fetch("${root}/attraction?action=contents&sido=" + areaCode + "&gugun=", {
                  method: 'GET',
              })
                  .then(response => response.json())
                  .then(data => {
                      //혼자서 쓸거니까 메소드 분리하지 말자.
                      let position = map.getCenter();
                      let mapContainer = document.querySelector(".search-mycontainer");
                      mapContainer.innerHTML ="";
                      mapContainer.innerHTML =
                          `<div id="search-map">
                            <div class="custom_typecontrol radius_border">
                              <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')"
                                >지도</span
                               >
                              <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
                            </div>
                          </div>`;

                      map = new kakao.maps.Map(document.getElementById("search-map"), {
                          center: position,
                          level: 6, //지도의 레벨(확대, 축소 정도)
                      }); //지도 생성 및 객체 리턴

                      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                  })
          }
          else{
              alert("지역을 선택해 주십시오");
              checkbox.checked = false;
              return;
          }
      });
  });


  //자치구(시도)로 구군 데이터 얻어옴
  function getGugun() {
	  let weatherBlock = document.getElementById("weather_wrap");
      let areaCode = document.getElementById("area").value;
      document.querySelector("#gugun").innerHTML = `<option value="0" selected>구군선택</option>`;
      if (areaCode !== "0") {    	  
          fetch("${root}/attraction?action=getgugun&sido=" + areaCode)
              .then(response => response.json())
              .then(data => {

                  let gugunSelector = document.querySelector("#gugun");
                  let gugunList = ``;
                  data.forEach((gugun) => {
                      gugunList += `<option value="\${gugun.gugunCode}">\${gugun.gugunName}</option>`;
                  });
                  gugunSelector.innerHTML += gugunList;
              })
      }
      //구군 선택을 초기화 하면 전국 지도를 보여준다.
      else {
          let mapContainer = document.querySelector(".search-mycontainer");
          mapContainer.innerHTML ="";
          mapContainer.innerHTML = `
     		<div id="search-map">
             <div class="custom_typecontrol radius_border">
               <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')"
                 >지도</span
               >
               <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
             </div>
           </div>`;

          map = new kakao.maps.Map(document.getElementById("search-map"), {
              center: new kakao.maps.LatLng(36.355297, 127.298126), //지도의 중심좌표.
              level: 12, //지도의 레벨(확대, 축소 정도)
          }); //지도 생성 및 객체 리턴
          document.querySelector("#gugun").innerHTML = `<option value="0" selected>구군선택</option>`;
          map.setLevel(12);
          return;
      }
  }

  //시도 + 구군으로 이동 + 모든 영역을 표시하므로 체크박스 클릭하게
  function getContent() {
      let areaCode = document.getElementById("area").value;
      let gugunCode = document.getElementById("gugun").value;
      console.log(areaCode, gugunCode);
      if (areaCode !== "0" && gugunCode !== "0") {
          fetch("${root}/attraction?action=contents&sido=" + areaCode + "&gugun=" + gugunCode)
              .then(response => response.json())
              .then(data => drawMarker(data))
      }
  }

  function drawMarker(data){
      //console.dir(data)
      drawMap(data);

      let positions = [];
      data.forEach((position) => {
          //console.log(position)
          let image = "";
          if (position.firstImage === "" || position.firstImage === "") image = "./img/noimage.png";
          else image = position.firstImage;
          positions.push({
              title: position.title,
              latlng: new kakao.maps.LatLng(position.latitude, position.longitude),
              image: image,
              contentType: position.contentTypeId,
              contentId : position.contentId,
              address : position.addr1,
          })
      })

      positions.forEach((position) => {
          let imageSrc = "./WebResource/img/marker" + position.contentType + ".png";
          let imageSize = new kakao.maps.Size(40, 40);
          let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
          // 마커를 생성합니다
          let marker = new kakao.maps.Marker({
              map: map, // 마커를 표시할 지도
              position: position.latlng, // 마커를 표시할 위치
              title: position.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
              image: markerImage, // 마커 이미지
              clickable: true,
          });

          //console.dir(marker.ca)
          marker.ca.setAttribute("name", position.title);
          marker.ca.setAttribute("innerText", position.address);
          marker.ca.setAttribute("summaryImg", position.image);
          console.log(position.contentId)
          makeOverlay(marker)

      })

  }

  function makeOverlay(marker){
      console.dir(marker.ca.attributes.summaryImg.nodeValue)
      let content = '<div class="wrap">' +
          '    		 <div class="info">' +
          '        		<div class="body">' +
          '            	   <div class="img">' +
          '                     <img src="' + marker.ca.attributes.summaryImg.nodeValue + '">' +
          '                  </div>' +
          '                  <div class="desc">' +
          '     		          <div class="title">' + marker.ca.name +
          //'            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
          '                     </div>' + //title
          '                     <div class="ellipsis">'+ marker.ca.attributes.innertext.nodeValue +
          '                        <div class="jibun ellipsis"></div>' +
          '                        <div class="link">' +
          '						    <a href="https://www.kakaocorp.com/main" target="_blank">키워드 검색은 준비중입니다.</a>' +
          '       		         </div>' + //link
          '		               </div>' + //ellipsis
          '                  </div>' + //desc
          '               </div>' + //body
          '           </div>' + //info
          '        </div>'; //wrap
      var overlay = new kakao.maps.CustomOverlay({
          content: content,
          map: map,
          position: marker.getPosition(),
          clickable : true,
      });

      overlay.setVisible(false);

      kakao.maps.event.addListener(marker, 'click', function() {
          if(overlay.getVisible())
              overlay.setVisible(false)
          else overlay.setVisible(true)
      });
  }


  function drawMap(data){
      console.log(data);
      if(data.length === 0){
          let checkBoxes = document.querySelectorAll('input[name="contentType"]');
          checkBoxes.forEach(checkbox => {
              if(checkbox.checked){
                  checkbox.checked = false;
              }
          })
          alert("검색한 지역에 해당 관광지가 없습니다.")
          return;
      }
      let mapContainer = document.querySelector(".search-mycontainer");
      mapContainer.innerHTML ="";
      mapContainer.innerHTML = `
  	    <div id="search-map">
           <div class="custom_typecontrol radius_border">
                <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
                <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
           </div>
        </div>
        `;

      map = new kakao.maps.Map(document.getElementById("search-map"), {
          center: new kakao.maps.LatLng(data[0].latitude, data[0].longitude), //지도의 중심좌표.
          level: 6, //지도의 레벨(확대, 축소 정도)
      }); //지도 생성 및 객체 리턴

      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
  }

  function makeOverListener(map, marker, infowindow) {
      return function () {
          infowindow.open(map, marker);
      };
  }

  // 인포윈도우를 닫는 클로저를 만드는 함수입니다
  function makeOutListener(infowindow) {
      return function () {
          infowindow.close();
      };
  }
</script>

<%-- 클러스터 만들기 일단 보류 --%> <%--// var clusterer = new
kakao.maps.MarkerClusterer({--%> <%--// map: map, // 마커들을 클러스터로
관리하고 표시할 지도 객체--%> <%--// averageCenter: true, // 클러스터에 포함된
마커들의 평균 위치를 클러스터 마커 위치로 설정--%> <%--// minLevel: 10, //
클러스터 할 최소 지도 레벨--%> <%--// });--%> <%--//--%> <%--//--%> <%--//
$.get(, function (data) {--%> <%--// // 데이터에서 좌표 값을 가지고 마커를
표시합니다--%> <%--// // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도
객체를 설정하지 않습니다--%> <%--// var markers = $(data.item).map(function (i,
position) {--%> <%--// return new kakao.maps.Marker({--%> <%--// position: new
kakao.maps.LatLng(position.mapy, position.mapx),--%> <%--// });--%> <%--//
});--%> <%--//--%> <%--// // 클러스터러에 마커들을 추가합니다--%> <%--//
clusterer.addMarkers(markers);--%> <%--// });--%> <%-- //조회수 500 이상인
데이터 모두 지도에 출력하는 코드 - 클러스터 생성용
fetch("${root}/attraction?action=list") .then(response => response.json())
.then(data => { var positions = []; data.forEach((position) => {
//console.log(position.firstImage, position.firstImage == "",
position.firstImage === "") var image = ""; if (position.firstImage === "" ||
position.firstImage === "") image = "./img/noimage.png"; else image =
position.firstImage; positions.push({ title: position.title, latlng: new
kakao.maps.LatLng(position.latitude, position.longitude), image: image,
contentType: position.contentTypeId }) }) positions.forEach((position) => { var
imageSrc = "./img/marker" + position.contentType + ".png"; var imageSize = new
kakao.maps.Size(40, 40); var markerImage = new kakao.maps.MarkerImage(imageSrc,
imageSize); // 마커를 생성합니다 var marker = new kakao.maps.Marker({ map: map,
// 마커를 표시할 지도 position: position.latlng, // 마커를 표시할 위치 title:
position.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
image: markerImage, // 마커 이미지 clickable: true, }); var infowindow = new
kakao.maps.InfoWindow({ content: //"
<div><img src=" + position.image + ` width="200px" height="200px" /></div>
` + "
<h4>" + position.title + "</h4>
", // 인포윈도우에 표시할 내용 }); kakao.maps.event.addListener(marker,
"mouseover", makeOverListener(map, marker, infowindow));
kakao.maps.event.addListener(marker, "mouseout", makeOutListener(infowindow));
}) }) --%> <%-- 체크박스의 값들을 form으로 불러오는 방법 const checkboxGroup =
document.querySelectorAll('input[name="contentType"]');
checkboxGroup.forEach(checkbox => { checkbox.addEventListener('change', event =>
{ const formData = new FormData(); checkboxGroup.forEach(checkbox => {
//console.dir(checkbox.checked) if(checkbox.checked){
console.log(checkbox.value); formData.append('contentType', checkbox.value); }
}); formData.append('action', 'checkContent'); // 서버로 전송합니다.
fetch(`${root}/attraction`, { method: 'POST', body : formData, }) .then(response
=> response.json()) .then(data => { }) --%> <%-- 체크박스 값들을 get으로
쿼리스트링으로 받아오는 방법 const checkboxGroup =
document.querySelectorAll('input[name="contentType"]');
checkboxGroup.forEach(checkbox => { checkbox.addEventListener('change', event =>
{ let queryString = '?'; checkboxGroup.forEach(checkbox => {
//console.dir(checkbox.checked) if(checkbox.checked){
console.log(checkbox.value); //formData.append('contentType', checkbox.value);
queryString += `\${checkbox.name}=\${checkbox.value}&`; } });
fetch(`${root}/attraction${queryString}`, { method: 'POST', body : formData, })
.then(response => response.json()) .then(data => { }) --%>
