<template>
  <v-app class="templateTop">
    <div class="locaAndThemeAndWeaher">
      <div class="localAndTheme">
        <v-container fluid class="location-sel">
          <v-row class="sidoRow">
            <v-col class="sidoCol">
              <v-select
                  class="sidoSel"
                  v-model="areaCode"
                  :items="sido"
                  label="시도 선택"
                  outlined
                  item-text="name"
                  item-value="value"
                  item-eng="eng"
                  @change="handleSidoChange"
              ></v-select>
            </v-col>
            <v-col class="sidoCol">
              <v-select
                  class="gugunSel"
                  v-model="gugunCode"
                  :items="gugun"
                  label="구군 선택"
                  outlined
                  item-text="gugunName"
                  item-value="gugunCode"
                  item-eng="eng"
                  @change="handleGugunChange"
              ></v-select>
            </v-col>

          </v-row>
        </v-container>
        <div class="findWayTextArea">
          <v-text-field
              :value="startPoint"
              label="출발지"
              outlined
              disabled
          ></v-text-field>
          <v-text-field
              :value="endPoint"
              label="도착지"
              outlined
              disabled
          ></v-text-field>
          <a href="" title="Button fade orange" class="button btnFade btnOrange">초기화</a>
        </div>
        <v-row class="search-checkbox">
          <v-checkbox class="searchCh" v-model="contentTypes" label="관광지" color="orange" value="12"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="문화시설" color="orange" value="14"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="축제공연행사" color="orange" value="15"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="여행코스" color="orange" value="25"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="레포츠" color="orange" value="28"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="숙박" color="orange" value="32"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="쇼핑" color="orange" value="38"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox class="searchCh" v-model="contentTypes" label="음식점" color="orange" value="39"
                      @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="checkAllBox" class="allSelectRadio searchCh" label="전체 체크 해제" color="blue"
                      @change="toggleSelectAll" hide-details></v-checkbox>
        </v-row>
      </div>
      <div id="weather_wrap">
        <div id="today_weather">오늘의 날씨</div>
        <!-- 이미지 경로-->
        <div id=weatherimg_wrap>
          <img id="weather-icon" src="https://openweathermap.org/img/w/01d.png" alt="Weather icon"/>
        </div>
        <!-- 이미지 정보-->
        <div id="name">지역을 선택해주세요</div>
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
    </div>
    <div class="mainContent">
      <app-left-bar
          class="leftContent"
          :selectedSido="selectedSido"
          :selectedGugun="selectedGugun"
          :startPoint="startPoint"
          :endPoint="endPoint"
      ></app-left-bar>
      <div id="map" ></div>
      <app-right-bar class="rightContent" :map="map" :markers="positions"></app-right-bar>
    </div>
  </v-app>
</template>
<script>
import axios from "axios";
import AppLeftBar from "@/components/Attraction/AppleftBar.vue";
import AppRightBar from "@/components/Attraction/ApprightBar.vue";

export default {
  name: "KakaoMap",
  components: {AppRightBar, AppLeftBar},
  data() {
    return {
      map: null,
      areaCode: '',
      gugunCode: '',
      checkAllBox: true,
      eng: '',
      markersArray: {},
      contentTypes: [],
      sido: [
        {name: '서울특별시', value: '1', eng: 'seoul'},
        {name: '세종특별시', value: '8', eng: 'sejong'},
        {name: '제주특별시', value: '39', eng: 'jeju'},
        {name: '부산광역시', value: '6', eng: 'busan'},
        {name: '대구광역시', value: '4', eng: 'daegu'},
        {name: '인천광역시', value: '2', eng: 'incheon'},
        {name: '광주광역시', value: '5', eng: 'gwangju'},
        {name: '대전광역시', value: '3', eng: 'daejeon'},
        {name: '울산광역시', value: '7', eng: 'ulsan'},
        {name: '경기', value: '31', eng: 'gyeonggi-do'},
        {name: '강원', value: '32', eng: 'gangwon-do'},
        {name: '충북', value: '33', eng: 'seouchungcheongbuk-do'},
        {name: '충남', value: '34', eng: 'chungcheongnam-do'},
        {name: '전북', value: '37', eng: 'jeollabuk-do'},
        {name: '전남', value: '38', eng: 'jeollanam-do'},
        {name: '경북', value: '35', eng: 'gyeongsangbuk-do'},
        {name: '경남', value: '36', eng: 'gyeongsangnam-do'}
      ],
      gugun: [],
      //컴포넌트로 데이터 전달하기
      selectedSido: '',
      selectedGugun: '',
      positions: [],
      //길찾기
      startPoint: "출발지를 선택해주세요",
      endPoint: "도착지를 선택해주세요",
      //마커생성에 필요한 변수
      container: {},
      startLoc: {},
      mapTypeControl: {},
      zoomControl: {},
      //마커 배열
      MarkerTmp: [],
      //거리 찍기 필요
      polyline: "",
      polylineArray: [],
      customOverlay: "",
      customOverlayArray: [],
      findMarker: "",
      findMarkerArray: [],

      requestData: {
        origin: {
          x: 0,
          y: 0
        },
        destination: {
          x: 0,
          y: 0
        },
        waypoints: [
          /*{
            name: 'name0',
            x: '127.3855645721133',
            y: '36.36071080159904'
          },
          {
            name: 'name1',
            x: '127.38793109858915',
            y: '36.37507683636454'
          }*/
        ],
        //경로탐색 우선순위 옵션 => (기본값: RECOMMEND) RECOMMEND: 추천 경로 | TIME: 최단 시간 | DISTANCE: 최단 경로
        priority: 'DISTANCE',
        //차량 유종 정보 => (기본값: GASOLINE) GASOLINE: 휘발유 | DIESEL: 경유 | LPG: LPG
        car_fuel: 'GASOLINE',
        //하이패스 장착 여부
        car_hipass: false,
        //대안 경로 제공 여부
        alternatives: false,
        //상세 도로 정보 제공 여부
        road_details: true,
      }
    }
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      //스크립트 객체 생성
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      //동적 로딩을 위해 autoload활용
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=95684c0a88a9ddfe933ca5737c2da5a4";
      document.head.appendChild(script);
    }

  },
  methods: {

    initMap() {
      this.startLoc = new kakao.maps.LatLng(36.355297, 127.298126);
      this.mapTypeControl = new kakao.maps.MapTypeControl();
      this.zoomControl = new kakao.maps.ZoomControl();
      this.container = document.getElementById("map");
      const options = {
        //center: new kakao.maps.LatLng(36.355400, 127.298225),
        center: this.startLoc,
        level: 12,
      };
      //지도 객체를 등록합니다.
      //지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
      this.map = new kakao.maps.Map(this.container, options);
      this.map.addControl(this.mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
      this.map.addControl(this.zoomControl, kakao.maps.ControlPosition.RIGHT);
    },
    handleSidoChange() {
      this.selectedSido = this.sido.find((item) => item.value === this.areaCode)?.name || '';
      this.gugunCode = '0';
      axios.get("http://localhost:8989/attraction/" + this.areaCode)
        .then(response => {
          this.gugun = response.data;
          //선택된 areaCode와 같은 item의 배열값을 가져와 할당한다.
          const selectedSido = this.sido.find(item => item.value === this.areaCode);
          //selectedSido가 값이 있다면 그 값의 eng값을 할당한다.
          const engValue = selectedSido ? selectedSido : null;
          this.weatherInfo(engValue);
        })
    },
    weatherInfo(engValue) {
      axios.get("http://api.openweathermap.org/data/2.5/weather?q=" + engValue.eng + "&appid=7315a10a3bef7e73b88ed593dc718d1c")
        .then(response => {
          const data = response.data;
          document.getElementById("name").innerText = engValue.name;
          document.getElementById("temp").innerText = Math.floor(
            data.main.temp - 273.15
          );
          document.getElementById("hum").innerText = data.main.humidity;
          let imgURL =
            "http://openweathermap.org/img/w/" + data.weather[0].icon + ".png";
          document.getElementById("weather-icon").setAttribute("src", imgURL);
        })
    },

    //전체선택
    toggleSelectAll() {
      if (!this.checkAllBox) {
        this.contentTypes.splice(0);
        this.DestroyedMarker()
        setTimeout(() => {
          this.checkAllBox = true;
        }, 100); // 0.5초 후에 checkAllBox 값을 true로 변경
      }
    },
    handleGugunChange() {
      this.selectedGugun = this.gugun.find((item) => item.gugunCode === this.gugunCode)?.gugunName || '';
      const sendData = {
        areaCode: this.areaCode,
        gugunCode: this.gugunCode,
        contentTypes: this.contentTypes,
      }
      if (this.areaCode !== '0' && this.gugunCode !== '0') {
        axios.post(`http://localhost:8989/attraction/lists`, sendData)
          .then((Response) => {
            const data = Response.data
            if (data.length === 0) {
              this.markersArray = {};
              this.contentTypes = [];
              alert('검색한 지역에 관광지 정보가 없습니다.');
            } else {
              this.markersArray = data;
              this.drawMarker(this.markersArray)
            }
          })
      }
    },
    drawMarker: function (markers) {
      this.positions = [];
      markers.forEach((position) => {
        let image = "";
        if (position.firstImage === "" || position.firstImage === "") image = require('@/assets/marker/noimage.png')
        else image = position.firstImage;
        this.positions.push({
          title: position.title,
          latlng: new kakao.maps.LatLng(position.latitude, position.longitude),
          image: image,
          contentType: position.contentTypeId,
          contentId: position.contentId,
          address: position.addr1,
        })
      })
      this.positions.forEach((position) => {
        let imageSrc = require(`@/assets/marker/marker${position.contentType}.png`);
        let imageSize = new kakao.maps.Size(35, 35);
        let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
        // 마커를 생성합니다
        let marker = new kakao.maps.Marker({
          map: this.map, // 마커를 표시할 지도
          position: position.latlng, // 마커를 표시할 위치
          title: position.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
          image: markerImage, // 마커 이미지
          clickable: true,
        });
        marker.ca.setAttribute("name", position.title);
        marker.ca.setAttribute("innerText", position.address);
        marker.ca.setAttribute("summaryImg", position.image);
        this.MarkerTmp.push(marker)
        this.map.setLevel(6)
        this.makeOverlay(marker);

      })
      const halfIndex = Math.floor(this.MarkerTmp.length);
      const halfMarker = this.MarkerTmp[halfIndex - 1];
      let move = new kakao.maps.LatLng(halfMarker.getPosition().getLat(), halfMarker.getPosition().getLng());
      this.map.panTo(move);
    },
    DestroyedMarker() {
      for (const element of this.MarkerTmp) {
        element.setMap(null);
      }
    },
    findDirections(marker, BtnName) {
      if (BtnName === "findWayBtnStart") {

        this.requestData.origin.x = `${marker.getPosition().La}`;
        this.requestData.origin.y = `${marker.getPosition().Ma}`;
        this.startPoint = marker.ca.attributes.innertext.value

        if (this.requestData.origin.x !== 0 && this.requestData.origin.y !== 0 &&
          this.requestData.destination.x !== 0 && this.requestData.destination.y !== 0) {
          this.findWayGo(this.requestData);
          this.deletFindWay();
        }
      }

      if (BtnName === "findWayBtnEnd") {
        this.requestData.destination.x = `${marker.getPosition().La}`;
        this.requestData.destination.y = `${marker.getPosition().Ma}`;
        this.endPoint = marker.ca.attributes.innertext.value

        if (this.requestData.origin.x !== 0 && this.requestData.origin.y !== 0 &&
          this.requestData.destination.x !== 0 && this.requestData.destination.y !== 0) {
          this.findWayGo(this.requestData);
          this.deletFindWay();
        }
      }

    },

    findWayGo(requestData) {
      console.dir(requestData.origin)
      console.dir(requestData.destination)
      const apiUrl = 'https://apis-navi.kakaomobility.com/v1/waypoints/directions';
      const REST_API_KEY = '42f1b6d378cc81efe4eb31d1b450d8d4'; // 카카오디벨로퍼스에서 발급 받은 API 키 값
      // 요청 헤더 설정
      const headers = {
        'Content-Type': 'application/json',
        'Authorization': `KakaoAK ${REST_API_KEY}`
      };
      // Axios를 사용하여 API 호출 수행
      axios.post(apiUrl, requestData, {headers})
        .then(response => {
          let data = response.data.routes[0];
                    let result_code = data.result_code;
                    let summary = data.summary;
          let sections = data.sections;
          //젠체 코드
                    console.log("전체 : ", data);
                    //경로 탐색 결과 코드
                    console.log("결과코드 : ", result_code);
                    //summary
                    console.log("요약 : ", summary);
                    //구간별 경로 정보
                    console.log("구간별 정보 : ", sections);
          if (sections.length >= 1) {
            for (const [idx, section] of sections.entries()) {
              let {distance, duration, guides: arrays, roads} = section;  //distance : 미터단위, duration : 초 단위
              let detailRoads = [];
              for (const element of roads) {
                let arg = element;
                let mini = arg.vertexes;
                let cursor = 0;
                while (cursor < mini.length) {
                  let obj = new kakao.maps.LatLng(mini[cursor + 1], mini[cursor]);
                  detailRoads.push(obj);
                  cursor = cursor + 2;
                  if (cursor >= 1000000) break;
                }
              }
              arrays = arrays.map((arg) => {
                let {x, y} = arg;
                if (x && y) {
                  arg.position = new kakao.maps.LatLng(arg.y, arg.x);
                }
                return arg;
              });
              // 마커 이미지의 이미지 크기 입니다
              let imageSize = new kakao.maps.Size(40, 45);
              // 마커 이미지를 생성합니다
              let image = null;
              if (idx === 0) image = new kakao.maps.MarkerImage(require('@/assets/marker/start.png'), imageSize);
              if (idx > 0 && idx < sections.length) image = new kakao.maps.MarkerImage(require('@/assets/marker/waypoint.png'), imageSize);
              //출발지는 start이미지를 가져와 그린다.
              //경유지는 waypoint이미지를 가져와 그린다.
              if (idx !== sections.length - 1) {
                let {title, position} = arrays[0];
                this.findMarker = new kakao.maps.Marker({
                  map: this.map, // 마커를 표시할 지도
                  position,
                  title: title ? title : '', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                  image // 마커 이미지
                });
                this.findMarkerArray.push(this.findMarker);
              }
              //도착지는 end이미지를 가져와 그린다.
              if (idx === sections.length - 1) {
                let {name, position} = arrays[0];
                this.findMarker = new kakao.maps.Marker({
                  map: this.map, // 마커를 표시할 지도
                  position,
                  name: name ? name : '', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                  image// 마커 이미지
                });
                this.findMarkerArray.push(this.findMarker);
                let {name: name2, position: position2} = arrays[arrays.length - 1];
                image = new kakao.maps.MarkerImage(require('@/assets/marker/end.png'), imageSize);
                this.findMarker = new kakao.maps.Marker({
                  map: this.map, // 마커를 표시할 지도
                  position: position2,
                  name: name2 ? name2 : '', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                  image // 마커 이미지
                });
                this.findMarkerArray.push(this.findMarker);
              }
              //배열에 마커 이미지 객체 추가
              // 지도에 표시할 선을 생성합니다
              this.polyline = new kakao.maps.Polyline({
                //path: arrays.map( arg=> arg.position), // 선을 구성하는 좌표배열 입니다
                path: detailRoads,
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor: (idx % 2 === 0) ? '#4584F4' : '#536F93', // 선의 색깔입니다
                strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
              });
              // 배열에 선 객체 추가
              this.polylineArray.push(this.polyline);
              // 지도에 선을 표시합니다
              this.polyline.setMap(this.map);
              // 지도 중심을 이동 시킵니다
              this.map.setLevel(7)
              var moveLatLon = new kakao.maps.LatLng(sections[0].bound.min_y, sections[0].bound.min_x);
              this.map.panTo(moveLatLon);
              //글자 찍기
              this.customOverlay = new kakao.maps.CustomOverlay({
                position: new kakao.maps.LatLng(37.39243974939504, 125.10972941510435),
                content: `<div class="distancelabel">거리: ${(distance / 1000).toFixed(2)} km, 시간: ${(duration / 60).toFixed(2)} 분</div>`
              });
              // 배열에 커스텀오버레이 객체 추가
              this.customOverlayArray.push(this.customOverlay);
              // 커스텀 오버레이를 지도에 표시합니다
              this.customOverlay.setMap(this.map);
            }
          }
        }).catch(err => {
        console.log(err)
      });
    },
    makeOverlay(marker, index) {

      let content = `<div class="wrap" data-index="${index}">
                         <div class="info">
                           <div class="body">
                             <div class="img">
                               <img src="${marker.ca.attributes.summaryimg.nodeValue}">
                             </div>
                             <div class="desc">
                                <div class="title">${marker.ca.name}</div>
                                <div class="ellipsis">
                                  ${marker.ca.attributes.innertext.nodeValue}
                                  <div class="jibun ellipsis"></div>
                                </div>
                             </div>
                             <div>
                              <span class="findWay" id="findWayBtnStart">왼클릭: 출발</span>
                              <span class="findWay" id="findWayBtnEnd">우클릭: 도착</span>
                             </div>
                           </div>
                        </div>
                      </div>
                   `;
      /*var overlay = new kakao.maps.CustomOverlay({
        content: content,
        map: this.map,
        position: marker.getPosition(),
        clickable: true,
        visible: false,
      });*/
      var overlay = new kakao.maps.CustomOverlay({
        content: content,
        map: this.map,
        position: marker.getPosition(),
        clickable: true,
      });
      overlay.setVisible(false)

      kakao.maps.event.addListener(marker, 'mouseover', function () {
        overlay.setVisible(true)
      });
      kakao.maps.event.addListener(marker, 'mouseout', function () {
        setTimeout(function () {
          overlay.setVisible(false)
        });
      });

      kakao.maps.event.addListener(marker, "click", () => {
        this.findDirections(marker, "findWayBtnStart"); // 추가 정보 전달
        console.log(marker.getPosition())
      });
      kakao.maps.event.addListener(marker, 'rightclick', () => {
        this.findDirections(marker, "findWayBtnEnd");
      });
    },
    deletFindWay() {
      //선 삭제
      this.polylineArray.forEach(function (polyline) {
        polyline.setMap(null);
      });
      this.polylineArray = [];
      //오버레이 삭제
      this.customOverlayArray.forEach(function (customOverlay) {
        customOverlay.setMap(null);
      });
      this.customOverlay = [];
      //마커 이미지 삭제
      this.findMarkerArray.forEach(function (findMarker) {
        findMarker.setMap(null);
      });
      // 배열 비우기
      this.findMarkerArray = [];

    },
/*    deletFindWayBtn() {
      //값 삭제
      this.requestData.origin.x = 0;
      this.requestData.origin.y = 0;
      this.requestData.destination.x = 0;
      this.requestData.destination.y = 0;
      this.startPoint = "출발지를 선택해주세요"
      this.endPoint = "도착지를 선택해주세요"
      //선 삭제
      this.polylineArray.forEach(function (polyline) {
        polyline.setMap(null);
      });
      this.polylineArray = [];
      //오버레이 삭제
      this.customOverlayArray.forEach(function (customOverlay) {
        customOverlay.setMap(null);
      });
      this.customOverlay = [];
      //마커 이미지 삭제
      this.findMarkerArray.forEach(function (findMarker) {
        findMarker.setMap(null);
      });
      // 배열 비우기
      this.findMarkerArray = [];
      //마커지우기
      if (this.MarkerTmp) {
        this.DestroyedMarker()
      }
    },*/

  }
}
</script>

<style>
.mainContent {
    display: flex;
    justify-content: space-between;
}
.leftContent {
    background-color: #FFFFFF;
    border: 1px solid black;
    width: 17%;
    height: 900px;
    z-index: 4;
}

.rightContent {
    background-color: #FFFFFF;
    border: 1px solid black;
    width: 17%;
    height: 900px;
    z-index: 4;
}

@font-face {
    font-family: 'SEBANG_Gothic_Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2104@1.0/SEBANG_Gothic_Bold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

* {
    font-family: 'SEBANG_Gothic_Bold';
}

#map {
    width: 70%;
    height: 900px;
    z-index: 2;
}

/*지역 선택*/
.location-sel {
    margin: 0 auto;
    width: 30rem;
}

.sidoSel, .gugunSel {
    width: 300px;
}

.findWayTextArea {
    padding: 1rem 1rem 0 0.8rem;
    display: flex;
    justify-content: center;
    align-content: center;
    width: 780px;
    margin-top: -40px;
}

.findWayTextArea .v-input__slot {
    width: 300px !important;
}

.sidoCol {
    flex-basis: 0;
    flex-grow: unset !important;
    max-width: 100%;
}

.sidoRow {
    line-height: 10px !important;
}

/*테마선택*/
.search-checkbox {
    max-width: fit-content;
    margin: 0 1rem 1rem 1rem;
}

.localAndTheme {
    display: flex;
    flex-direction: column;
}

.locaAndThemeAndWeaher {
    margin-top: -10px;
    display: flex;
    justify-content: center;
    background-color: snow;
    padding-top: 20px;
    height: 250px;
}

.allSelectRadio {
    font-weight: 900;
}

.searchCh {
    margin-right: 10px;
}

/*날씨 정보*/
#weather_wrap {
    background-color: #8bb9eb;
    color: white;
    min-width: 10rem;
    min-height: 10rem;
    flex: 0 0 13rem;
    margin-left: 2rem;
    margin-bottom: 1rem;
    border-radius: 10px;
    box-shadow: 3px 3px 3px rgb(165, 165, 165);
}

#today_weather {
    margin-top: 10px;
    font-size: 18px;
    text-align: center;
    font-weight: 600;
}

#weatherimg_wrap {
    display: flex;
    justify-content: center;
    margin-top: -14px;
}

#weather-icon {
    width: 50%;
}

#name {
    font-size: 18px;
    text-align: center;
    margin-top: -30px;
    font-weight: 600;
}

#weatherinfo {
    display: flex;
    margin-left: 20px;
    margin-right: 20px;
    height: 30px;
    font-weight: 500;
    justify-content: center;
}

#weathertitle {
    line-height: 30px;
}

#temp {
    margin-left: 10px;
    line-height: 30px;
}

.temperature {
    margin-left: 5px;
    line-height: 30px;
}

#hum {
    margin-left: 10px;
    line-height: 30px;
}

.humidity {
    margin-left: 5px;
    line-height: 30px;
}

/* 지도 카드 */
.wrap {
    position: absolute;
    left: -145px;
    bottom: 40px;
    height: 230px;
    margin: 10px;
    width: 280px;
    border-radius: 10px;
    box-shadow: 0 0 8px;
    overflow: hidden;
    background-color: #fff;
}

.wrap * {
    padding: 0;
    margin: 0;
}

#findWayBtnStart {
    color: #FF8E01;
    margin: 12px 0 0 50px;
}

#findWayBtnEnd {
    color: cornflowerblue;
    margin-left: 10px;
}

#closeBtn {
    margin: 12px 0 0 120px;
}

.body {
    position: relative;
    overflow: hidden;
    background-color: snow;
}

.info .img {
    height: 150px;
    overflow: hidden;
}

.img img {
    width: 100%;
    height: 110%;
    border-radius: 10px;
}

.info .desc {
    margin-top: 8px;
    margin-left: 10px;
    margin-right: 10px;
    position: relative;
}

.desc .ellipsis {
    font-size: 12px;
}

.desc .title {
    font-weight: bold;
    overflow: hidden;
}

.desc .addinfo {
    border: 1px solid black;
    text-align: center;
    color: #5085bb;
}

.link {
    height: 20px;
    line-height: 10px;
}

.link a {
    display: block;
    color: #5085bb;
    text-decoration: none;
    position: relative;
    top: 5px;
    text-align: center;
}

#findWayBtn:hover {
    color: #086ba8;
}


a,
a:visited {
    text-decoration: none;
    color: #00AE68;
}

a.button {
    width: 100px;
    height: 55px;
    padding: 0;
    font-weight: 600;
    text-align: center;
    line-height: 55px;
    color: #FFF !important;
    border-radius: 5px;
    transition: all 0.4s;
}

.btnOrange {
    background: #FFAA40;
}

.btnFade.btnOrange:hover {
    background: #FF8E01;
}

.mapAndCal {
    display: flex;
}

.cal {
    width: 50%;
}
</style>