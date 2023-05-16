<template>
  <v-app class="templateTop">
    <div class="locaAndThemeAndWeaher">
      <div class="localAndTheme">
        <v-container fluid class="location-sel">
          <v-row>
            <v-col>
              <v-select
                  v-model="areaCode"
                  :items="sido"
                  menu-props="auto"
                  label="시도선택"
                  hide-details
                  prepend-icon="mdi-map"
                  item-text="name"
                  item-value="value"
                  item-eng="eng"
                  @change="handleSidoChange"
                  single-line>
              </v-select>
            </v-col>
            <v-col>
              <v-select
                  v-model="gugunCode"
                  :items="gugun"
                  menu-props="auto"
                  label="구군선택"
                  hide-details
                  prepend-icon="mdi-map"
                  item-text="gugunName"
                  item-value="gugunCode"
                  @change="handleGugunChange"
                  single-line>
              </v-select>
            </v-col>
          </v-row>
        </v-container>
        <v-row class="search-checkbox">
          <v-checkbox v-model="contentTypes" label="관광지" color="orange" value="12" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="문화시설" color="orange" value="14" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="축제공연행사" color="orange" value="15" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="여행코스" color="orange" value="25" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="레포츠" color="orange" value="28" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="숙박" color="orange" value="32" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="쇼핑" color="orange" value="38" @change="handleGugunChange"
                      hide-details></v-checkbox>
          <v-checkbox v-model="contentTypes" label="음식점" color="orange" value="39" @change="handleGugunChange"
                      hide-details></v-checkbox>

          <v-checkbox v-model="checkAllBox" class="allSelectRadio" label="전체 체크 해체" color="blue"
                      @change="toggleSelectAll" hide-details></v-checkbox>
        </v-row>
<!--        <button class="btnLineStart" @click="lineStart">이제 그려</button>-->
<!--        <button class="btnLineStop" @click="lineStop">그만 그려</button>-->
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
    <button class="findWay" @click="findDirections">길찾기</button>
    <div v-if="directionsResult">
      <!-- 결과를 표시하는 HTML 요소들을 추가 -->
      <p>총 거리: {{ directionsResult.totalDistance }}m</p>
      <p>소요 시간: {{ directionsResult.totalTime }}분</p>
      <!-- ... -->
    </div>
    <div id="map"></div>
  </v-app>
</template>

<script>
import axios from "axios";

export default {
  // components: {AppWeather},
  name: "KakaoMap",
  data() {
    return {
      map: null,
      areaCode: '',
      gugunCode: '',
      checkAllBox: true,
      eng: '',
      markers: {},
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

      //마커생성에 필요한 변수
      container: {},
      startLoc: {},
      mapTypeControl: {},
      zoomControl: {},

      //거리 찍기 필요
      drawingFlag: false, // 선이 그려지고 있는 상태를 가지고 있을 변수
      moveLine: null, // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체
      clickLine: null,  // 마우스로 클릭한 좌표로 그려질 선 객체입니다
      distanceOverlay: null, // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
      dots: {},

      directionsResult: null,
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
              this.markers = {};
              this.contentTypes = [];
              alert('검색한 지역에 관광지 정보가 없습니다.');
            } else {
              this.markers = data;
              this.drawMarker(this.markers)
            }
          })
      }
    },
    drawMarker(markers) {
      if (this.MarkerTmp) {
        this.DestroyedMarker()
      }
      let positions = [];
      markers.forEach((position) => {
        let image = "";
        if (position.firstImage === "" || position.firstImage === "") image = require('@/assets/marker/noimage.png')
        else image = position.firstImage;
        positions.push({
          title: position.title,
          latlng: new kakao.maps.LatLng(position.latitude, position.longitude),
          image: image,
          contentType: position.contentTypeId,
          contentId: position.contentId,
          address: position.addr1,
        })
      })
      this.MarkerTmp = [];
      positions.forEach((position) => {
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
        this.map.setLevel(5)
      })
      const halfIndex = Math.floor(this.MarkerTmp.length / 2);
      const halfMarker = this.MarkerTmp[halfIndex];
      let move = new kakao.maps.LatLng(halfMarker.getPosition().getLat(), halfMarker.getPosition().getLng());
      this.map.panTo(move);
    },
    DestroyedMarker() {
      for (const element of this.MarkerTmp) {
        element.setMap(null);
      }
    },
    findDirections() {
      axios.post('https://apis-navi.kakaomobility.com/v1/waypoints/directions', request, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `KakaoAK ${REST_API_KEY}`
        }
      })
        .then(response => {
          // API 요청 성공 시 처리할 로직 작성
          this.directionsResult = response.data;
        })
        .catch(error => {
          // API 요청 실패 시 처리할 로직 작성
          console.error(error);
        });
    }

    // 지도에 클릭 이벤트를 등록
    // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그리기


    // makeOverlay(marker){
    //   // console.dir(marker.ca.attributes.summaryImg.nodeValue)
    //   let content = '<div class="wrap">' +
    //     '    		 <div class="info">' +
    //     '        		<div class="body">' +
    //     '            	   <div class="img">' +
    //     '                     <img src="' + marker.ca.attributes.summaryImg.nodeValue + '">' +
    //     '                  </div>' +
    //     '                  <div class="desc">' +
    //     '     		          <div class="title">' + marker.ca.name +
    //     //'            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
    //     '                     </div>' + //title
    //     '                     <div class="ellipsis">'+ marker.ca.attributes.innertext.nodeValue +
    //     '                        <div class="jibun ellipsis"></div>' +
    //     '                        <div class="link">' +
    //     '						    <a href="https://www.kakaocorp.com/main" target="_blank">키워드 검색은 준비중입니다.</a>' +
    //     '       		         </div>' + //link
    //     '		               </div>' + //ellipsis
    //     '                  </div>' + //desc
    //     '               </div>' + //body
    //     '           </div>' + //info
    //     '        </div>'; //wrap
    //   var overlay = new kakao.maps.CustomOverlay({
    //     content: content,
    //     map: this.map,
    //     position: marker.getPosition(),
    //     clickable : true,
    //   });
    //   overlay.setVisible(false);
    //
    //   kakao.maps.event.addListener(marker, 'click', function() {
    //     if(overlay.getVisible())
    //       overlay.setVisible(false)
    //     else overlay.setVisible(true)
    //   });
    // },

  }
}
</script>

<style scoped>
#map {
    margin-left: 1rem;
    margin-right: 1rem;
    height: 60rem;
}

/*지역 선택*/
.location-sel {
    margin: 1rem 1rem 0 1rem;
    width: 30rem;
}

/*테마선택*/
.search-checkbox {
    max-width: fit-content;
    max-height: 7rem;
    margin: 0 1rem 1rem 1rem;
    align-content: center;
}

.localAndTheme {
    display: flex;
    flex-direction: column;
}

.locaAndThemeAndWeaher {
    display: flex;
    justify-content: center;
}

.allSelectRadio {
    font-weight: 900;
}

/*날씨 정보*/
#weather_wrap {
    background-color: #8bb9eb;
    color: white;
    min-width: 10rem;
    min-height: 10rem;
    flex: 0 0 13rem;
    margin-left: 1rem;
    margin-bottom: 1rem;
    border-radius: 10px;
    box-shadow: 5px 5px 5px rgb(165, 165, 165);
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

/*그리기 버튼*/

.btnLineStart, .btnLineStop {
    border: 1px solid black;
    width: fit-content;
}
</style>