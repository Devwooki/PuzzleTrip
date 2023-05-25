<template>
  <div id="app" class="leftBar">
    <div class="findWay">
      <button class="StartPoint">출 발:</button>
      <div class="Text">{{ truncatedStartPoint }}</div>

      <button class="EndPoint">도 착:</button>
      <div class="Text">{{ truncatedEndPoint }}</div>

    </div>
    <div class="findTime">
      <div class="Text">{{ getLeftDistance }}</div>
      <button class="EndPoint">Km/h</button>

      <div class="Text">{{ getLeftDuration }}</div>
      <button class="EndPoint">분</button>
    </div>
    <v-expansion-panels v-model="panel" :disabled="disabled" multiple class="calBox">
      <v-expansion-panel>
        <v-expansion-panel-header>여행 일정</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col>
              <v-date-picker v-model="dates" :allowed-dates="disabledDates" range></v-date-picker>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>

    <v-col>
      <v-text-field
          v-model="dateRangeText"
          label="여행일정"
          prepend-icon="mdi-calendar"
          readonly>
      </v-text-field>
    </v-col>
    <div class="themeChoice">
      <div class="menu">
        <button class="hotelChoice" @click="showHotel">선택 호텔</button>
        <button class="playChoice" @click="showPlace">선택 장소</button>
        <router-link :to="{name: 'appPlan'}" class="saveTrip">일정 생성하기 </router-link>
      </div>
      <div class="choicePlay">
        <!-- eslint-disable-next-line -->
        <div v-for="(attraction, index) in filteredChoice" :key="attraction.contentId" class="attractionItem"
             @mouseover="moveMapToMarker(attraction)">
          <img :src="attraction.image" alt="attraction Image" class="attractionImage"/>
          <div class="infoDiv">
            <span class="attractionTitleTool">{{ attraction.title }}</span>
            <div class="attractionAddr">{{ attraction.address }}</div>
            <div class="infoFav">
              <font-awesome-icon :icon="['fas', 'minus-circle']" class="plusBtn" @click="minusList(index)"
                                 :style="{ color: 'skyblue' }"/>
              <font-awesome-icon :icon="['fas', 'heart']" class="heartBtn" :style="{ color: '#f95880' }"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import {mapGetters, mapMutations} from "vuex";

export default {
  name: 'AppLeftBar',
  components: {},
  data() {
    return {
      dates: ["2023-06-01"],
      panel: [0, 1],
      disabled: false,
      readonly: false,
      EndPoint: "",
      attractionList: [],
      showHotelMarkers: false
    };
  },
  computed: {
    ...mapGetters(
      'attractionStore',
      [
        'getLeftStartPoint',
        'getLeftEndPoint',
        'getLeftWayPoint',
        'getRightMarkers',
        "getRightMap",
        'getAttractionList',
        "getLeftDistance",
        "getLeftDuration",
      ]
    ),
    //날자 사이에 ~추가
    dateRangeText() {
      return this.dates.join(' ~ ')
    },
    truncatedEndPoint() {
      const maxLength = 15;
      if (this.getLeftEndPoint.length > maxLength) {
        return this.getLeftEndPoint.slice(0, maxLength) + "...";
      } else {
        return this.getLeftEndPoint;
      }
    },
    truncatedStartPoint() {
      const maxLength = 15;
      if (this.getLeftStartPoint.length > maxLength) {
        return this.getLeftStartPoint.slice(0, maxLength) + "...";
      } else {
        return this.getLeftStartPoint;
      }
    },
    filteredChoice() {
      if (!this.getAttractionList || Object.keys(this.getAttractionList).length === 0) {
        return {};
      }

      if (this.showHotelMarkers) {
        return Object.keys(this.getAttractionList).reduce((filtered, key) => {
          if (this.getAttractionList[key].contentType === 32) {
            filtered[key] = this.getAttractionList[key];
          }
          return filtered;
        }, {});
      } else {
        return Object.keys(this.getAttractionList).reduce((filtered, key) => {
          if (this.getAttractionList[key].contentType !== 32) {
            filtered[key] = this.getAttractionList[key];
          }
          return filtered;
        }, {});
      }
    },
  },
  watch: {
    //리스트 변화하면 감지해서 받아옴
    getAttractionList(newList) {
      console.log("갱신리스트", newList)
      this.attractionList = newList
      // this.$store.commit("attractionStore/UPDATE_ATTRACTION_LIST", newList)
    },
    dates(newValue){
     let day1 =  new Date(newValue[0]);
      let day2 =  new Date(newValue[1])

      let dif = day1.getTime() - day2.getTime();

      let day = Math.abs(dif / (1000 * 60 * 60 * 24)) + 1;
      let days = {day1,day2,day}

      console.log(day1);
      console.log(day2);
      console.log(day);
      this.SET_DAY(days);
    }
  },
  methods: {
    ...mapMutations('attractionStore', [
      'SET_RIGHT_MAP',
      'SET_RIGHT_MARKERS',
      'UPDATE_ATTRACTION_LIST',
      'UPDATE_ATTRACTION_LIST_MINUS',
      'SET_DAY',
    ]),
    //지난 날자 선택 금지
    disabledDates(val) {
      return val >= new Date().toISOString().substr(0,10)
    },
    //리스트에 호버 하면 지도 위치이동
    moveMapToMarker(marker) {
      let moveLatLon = new kakao.maps.LatLng(marker.latlng.Ma, marker.latlng.La);
      /* global kakao */
      this.getRightMap.setLevel(5);
      this.getRightMap.panTo(moveLatLon);
      // 기존에 열린 infowindow가 있다면 닫기
        if (this.customOverlay) {
            this.customOverlay.setMap(null)
        }

      //마커 그리기
        this.customOverlay = new kakao.maps.CustomOverlay({
            position: moveLatLon,
            content: `<div class="popTitle" style="padding-left: 15px 15px; padding: 10px; border:1px solid black; background-color: #FFFFFF">${marker.title}</div>`
        });
        this.customOverlay.setMap(this.getRightMap)
    },
    closeInfowindow() {
      // 마우스가 markerItem에서 벗어날 때 infowindow 닫기
      if (this.infowindow) {
        this.infowindow.close();
      }
    },
    minusList(index) {
      console.log(index)
      this.UPDATE_ATTRACTION_LIST_MINUS(index)
    },
    showHotel() {
      this.showHotelMarkers = true;
    },
    showPlace() {
      this.showHotelMarkers = false;
    },
  },
};
</script>

<style scoped>
/* 스크롤바 설정*/
.leftBar {
    display: inline-block;
    overflow-y: scroll;
    box-sizing: border-box;
    background-color: snow;
}

#app {
    background-color: snow;
}

.findWay {
    text-align: center;
    width: 300px;
    display: grid;
    grid-template-rows: repeat(2, 30px);
    grid-template-columns: 70px 250px;
    margin: 5px;
}

.findTime {
    justify-content: center;
    text-align: center;
    width: 300px;
    display: grid;
    grid-template-rows: repeat(2, 30px);
    grid-template-columns: 20px 70px;
    margin: 5px;
}

.Text {
    line-height: 30px;
}

.calBox {
    width: 350px !important;
}

.menu {
    width: 300px;
    font-size: 15px;
    height: 30px;
    display: flex;
    justify-content: space-evenly;
    margin: 0 5px;
}
.hotelChoice {
    line-height: 30px;
    border: 1px solid #fff;
    width: 150px;
    text-align: center;
    color: #fff;
    background-color: #7fccde;
}

.playChoice {
    line-height: 30px;
    border: 1px solid #fff;
    width: 150px;
    text-align: center;
    color: #fff;
    background-color: #7fccde;
}

.saveTrip {
    line-height: 30px;
    border: 1px solid #fff;
    width: 150px;
    text-align: center;
    color: #fff;
    background-color: #e86666;
}
.attractionItem {
    margin-top: 20px;
    margin-left: 5px;
    margin-bottom: 20px;
    border: 2px solid wheat;
    width: 295px;
    height: 80px;
    display: flex;
    flex-direction: row;
    border-radius: 4px;
    background-color: papayawhip;
}

.attractionImage {
    width: 30%;
    border-radius: 4px 0 0 7px;
    margin-right: 4px;
}

.attractionTitleTool {
    font-size: 13px !important;

}

.attractionAddr {
    margin-top: auto;
    font-size: 10px !important;
    color: #919696;
}

.infoDiv {
    width: 200px;
}

.infoFav {
    display: flex;
    justify-content: flex-end;
}

.heartBtn, .plusBtn {
    margin-right: 8px;
    cursor: pointer;
}

.heartBtn {
    margin-right: 10px;
}
</style>