<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0684d7cb3f95de608b3bc5c60dd45733"></script>

<script>
    const kakaoMapApiKey = "0684d7cb3f95de608b3bc5c60dd45733"; //카카오맵 지도 API키 선언
    let startLoc = new kakao.maps.LatLng(36.355297, 127.298126)

    let map = new kakao.maps.Map(document.getElementById("search-map"), {
        center: startLoc,
        level: 5,
    });

    //카카오 맵에 지도 컨트롤 추가
    var mapTypeControl = new kakao.maps.MapTypeControl();
    var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    //카카오 맵에 거리를 계산하는데 필요한 변수
    var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수
    var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체
    var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
    var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

    // 지도에 클릭 이벤트를 등록
    // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그리기
    var btnLineStart = document.querySelector('#btnLineStart');
    btnLineStart.addEventListener('click',  function (mouseEvent){
        kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

            // 마우스로 클릭한 위치
            var clickPosition = mouseEvent.latLng;

            // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
            if (!drawingFlag) {

                // 상태를 true로, 선이 그리고있는 상태로 변경합니다
                drawingFlag = true;

                // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
                deleteClickLine();

                // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
                deleteDistnce();

                // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
                deleteCircleDot();

                // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
                clickLine = new kakao.maps.Polyline({
                    map          : map, // 선을 표시할 지도입니다
                    path         : [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                    strokeWeight : 3, // 선의 두께입니다
                    strokeColor  : '#db4040', // 선의 색깔입니다
                    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                    strokeStyle  : 'solid' // 선의 스타일입니다
                });

                // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
                moveLine = new kakao.maps.Polyline({
                    strokeWeight : 3, // 선의 두께입니다
                    strokeColor  : '#db4040', // 선의 색깔입니다
                    strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                    strokeStyle  : 'solid' // 선의 스타일입니다
                });

                // 클릭한 지점에 대한 정보를 지도에 표시합니다
                displayCircleDot(clickPosition, 0);


            } else { // 선이 그려지고 있는 상태이면

                // 그려지고 있는 선의 좌표 배열을 얻어옵니다
                var path = clickLine.getPath();

                // 좌표 배열에 클릭한 위치를 추가합니다
                path.push(clickPosition);

                // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
                clickLine.setPath(path);

                var distance = Math.round(clickLine.getLength());
                displayCircleDot(clickPosition, distance);
            }
        });
        // 지도에 마우스무브 이벤트를 등록합니다
        // 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
        kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

            // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
            if (drawingFlag){

                // 마우스 커서의 현재 위치를 얻어옵니다
                var mousePosition = mouseEvent.latLng;

                // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
                var path = clickLine.getPath();

                // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
                var movepath = [path[path.length-1], mousePosition];
                moveLine.setPath(movepath);
                moveLine.setMap(map);

                var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
                    content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다

                // 거리정보를 지도에 표시합니다
                showDistance(content, mousePosition);
            }
        });
    });

    // 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
    // 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
    var btnLineStop = document.querySelector('#btnLineStop');
    btnLineStop.addEventListener('click',  function (mouseEvent){
        // kakao.maps.event.addListener(map, 'dblrightclick', function (mouseEvent) {

        // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
        if (drawingFlag) {

            // 마우스무브로 그려진 선은 지도에서 제거합니다
            moveLine.setMap(null);
            moveLine = null;

            // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 선을 구성하는 좌표의 개수가 2개 이상이면
            if (path.length > 1) {

                // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
                if (dots[dots.length-1].distance) {
                    dots[dots.length-1].distance.setMap(null);
                    dots[dots.length-1].distance = null;
                }

                var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                    content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다

                // 그려진 선의 거리정보를 지도에 표시합니다
                showDistance(content, path[path.length-1]);

            } else {

                // 선을 구성하는 좌표의 개수가 1개 이하이면
                // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
                deleteClickLine();
                deleteCircleDot();
                deleteDistnce();

            }

            // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
            drawingFlag = false;
        }
    });

    // 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
    function deleteClickLine() {
        if (clickLine) {
            clickLine.setMap(null);
            clickLine = null;
        }
    }

    // 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
    // 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
    function showDistance(content, position) {

        if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면

            // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
            distanceOverlay.setPosition(position);
            distanceOverlay.setContent(content);

        } else { // 커스텀 오버레이가 생성되지 않은 상태이면

            // 커스텀 오버레이를 생성하고 지도에 표시합니다
            distanceOverlay = new kakao.maps.CustomOverlay({
                map: map, // 커스텀오버레이를 표시할 지도입니다
                content: content,  // 커스텀오버레이에 표시할 내용입니다
                position: position, // 커스텀오버레이를 표시할 위치입니다.
                xAnchor: 0,
                yAnchor: 0,
                zIndex: 3
            });
        }
    }

    // 그려지고 있는 선의 총거리 정보와
    // 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
    function deleteDistnce () {
        if (distanceOverlay) {
            distanceOverlay.setMap(null);
            distanceOverlay = null;
        }
    }

    // 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여
    // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
    function displayCircleDot(position, distance) {

        // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
        var circleOverlay = new kakao.maps.CustomOverlay({
            content: '<span class="dot"></span>',
            position: position,
            zIndex: 1
        });

        // 지도에 표시합니다
        circleOverlay.setMap(map);

        if (distance > 0) {
            // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
            var distanceOverlay = new kakao.maps.CustomOverlay({
                content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
                position: position,
                yAnchor: 1,
                zIndex: 2
            });

            // 지도에 표시합니다
            distanceOverlay.setMap(map);
        }

        // 배열에 추가합니다
        dots.push({circle:circleOverlay, distance: distanceOverlay});
    }

    // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
    function deleteCircleDot() {
        var i;

        for ( i = 0; i < dots.length; i++ ){
            if (dots[i].circle) {
                dots[i].circle.setMap(null);
            }

            if (dots[i].distance) {
                dots[i].distance.setMap(null);
            }
        }

        dots = [];
    }

    // 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여
    // 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
    // HTML Content를 만들어 리턴하는 함수입니다
    function getTimeHTML(distance) {

        // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
        // 근데 지도 뚫고 가는 방식이라 감안하고 속도 낮춤
        var walkkTime = distance / 55 | 0;
        var walkHour = '', walkMin = '';

        // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
        if (walkkTime > 60) {
            walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
        }
        walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

        // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
        // 근데 지도 뚫고 가는 방식이라 감안하고 속도 낮춤
        var bycicleTime = distance / 180 | 0;
        var bycicleHour = '', bycicleMin = '';

        // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
        if (bycicleTime > 60) {
            bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
        }
        bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

        // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
        var content = '<ul class="dotOverlay distanceInfo">';
        content += '    <li>';
        content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">도보</span>' + walkHour + walkMin;
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
        content += '    </li>';
        content += '</ul>'

        return content;
    }
    // ------------------선 그리기 끝--------------------------

    // 체크박스 선택 여부에 따라 지도에 출력하는 것이 달라진다.
    const checkboxGroup = document.querySelectorAll('input[name="contentType"]');

    //체크박스가 선택 될 때 마다 이벤트를 발생 시킨다.
    checkboxGroup.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            let boxes = "";
            let areaCode = document.getElementById("area").value;
            let gugunCode = document.getElementById("gugun").value;

            //체크 박스가 선택된 것들 쿼리 스트링으로 마든다
            checkboxGroup.forEach(checkbox => {
                if(checkbox.checked){
                    boxes +=  `\${checkbox.value} `;
                }
            });

            //Controller로 보낼 데이터를 JSON으로 만든다
            let sendData = {
                areaCode : areaCode,
                gugunCode : gugunCode,
                checked : boxes
            }

            //AJAX하기 위한 사전 정의
            const fetchURL = "${root}/attraction/lists";
            const config ={
                method: 'POST',
                headers : {"Content-Type" : "application/json"},
                body : JSON.stringify(sendData)
            }

            if(areaCode !== "0" && gugunCode !== "0" ){
                fetch(fetchURL, config)
                    .then(response => response.json())
                    .then(data => {
                        if(data.length === 0){
                            let checkBoxes = document.querySelectorAll('input[name="contentType"]');
                            checkBoxes.forEach(checkbox => {
                                if(checkbox.checked) checkbox.checked = false;
                            })
                            alert("검색한 지역에 해당 관광지가 없습니다.")
                            return;
                        }

                        if(boxes !== ""){
                            startLoc = new kakao.maps.LatLng(data[0].latitude, data[0].longitude);
                            drawMarker(data)
                        }else{
                            resetMap(data)
                        }
                    })
            }else {
                alert("지역을 선택해 주십시오");
                checkbox.checked = false;
                return;
            }
        });
    });
    //자치구(시도)로 구군 데이터 얻어옴
    function getGugun() {
        let areaCode = document.getElementById("area").value;

        checkboxGroup.forEach(checkbox => {
            if(checkbox.checked) checkbox.checked = false;
        })

        document.querySelector("#gugun").innerHTML = `<option value="0" selected>구군선택</option>`;
        if (areaCode !== "0") {
            //fetch("${root}/attraction?action=getgugun&sido=" + areaCode)
            fetch("${root}/attraction/" + areaCode)
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

        let sendData = {
            areaCode : areaCode,
            gugunCode : gugunCode,
            checked : ""
        }

        if (areaCode !== "0" && gugunCode !== "0") {
            fetch("${root}/attraction/lists", {
                method: 'POST',
                headers : {"Content-Type" : "application/json"},
                body : JSON.stringify(sendData)
            }).then(response => response.json())
                .then(data => {
                    if(data.length === 0){
                        let checkBoxes = document.querySelectorAll('input[name="contentType"]');
                        checkBoxes.forEach(checkbox => {
                            if(checkbox.checked) checkbox.checked = false;
                        })
                        alert("검색한 지역에 관광지 정보가 없습니다.")
                        return;
                    }

                    startLoc = new kakao.maps.LatLng(data[0].latitude, data[0].longitude);
                    drawMarker(data)
                })
        }
    }

    function drawMarker(data){
        resetMap(data);

        let positions = [];
        data.forEach((position) => {
            //console.log(position)
            let image = "";
            if (position.firstImage === "" || position.firstImage === "") image = "${root}/resources/static/img/noimage.png";
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
            let imageSrc = "/resources/static/img/marker" + position.contentType + ".png";
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

            makeOverlay(marker)

        })

    }

    function makeOverlay(marker){
        // console.dir(marker.ca.attributes.summaryImg.nodeValue)
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


    function resetMap(data){
        let mapDiv = document.querySelector("#search-map");
        mapDiv.innerHTML ="";
        mapDiv.innerHTML =
            `<div class="custom_typecontrol radius_border">
                              <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
                              <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
                            </div>`;

        map = new kakao.maps.Map(document.getElementById("search-map"), {
            center: startLoc,
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
{ let checked = '?'; checkboxGroup.forEach(checkbox => {
//console.dir(checkbox.checked) if(checkbox.checked){
console.log(checkbox.value); //formData.append('contentType', checkbox.value);
checked += `\${checkbox.name}=\${checkbox.value}&`; } });
fetch(`${root}/attraction${checked}`, { method: 'POST', body : formData, })
.then(response => response.json()) .then(data => { }) --%>