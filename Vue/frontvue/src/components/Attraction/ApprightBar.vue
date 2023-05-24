<template>
  <div>
    <div class="menu">
      <button class="hotelChoice" @click="showHotel">추천 호텔</button>
      <button class="playChoice" @click="showPlace">추천 장소</button>
    </div>
    <div class="rightBar box1">
      <!-- eslint-disable-next-line -->
      <div v-for="(marker, key) in filteredMarkers" :key="key" class="markerItem"  @mouseover="moveMapToMarker(marker)" @mouseleave="closeInfowindow">
        <img :src="marker.image" alt="Marker Image" class="markerImage"/>
        <div class="infoDiv">
          <span class="markerTitleTool">{{ marker.title }}</span>
          <div class="markerAddr">{{ marker.address }}</div>
          <div class="infoFav">
            <font-awesome-icon :icon="['fas', 'plus']" class="plusBtn" @click="addAttractionList(marker)"
                               :style="{ color: 'skyblue' }"/>
            <font-awesome-icon :icon="['fas', 'heart']" class="heartBtn" :style="{ color: '#f95880' }"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import {mapGetters, mapMutations} from "vuex";

export default {
  name: 'AppRightBar',
  data() {
    return {
      // infowindow: null,
      // rightmap: null,
      selectedMarkerTitle: '',
      showHotelMarkers: false

    };
  },
  computed: {//해당 컴포넌트에 계산된(computed) state를 가져온다 - getter
    ...mapGetters('attractionStore', ['getRightMap', 'getRightMarkers', 'getAttractionList']),
    filteredMarkers() {
      if (!this.getRightMarkers || Object.keys(this.getRightMarkers).length === 0) {
        return {};
      }

      if (this.showHotelMarkers) {
        return Object.keys(this.getRightMarkers).reduce((filtered, key) => {
          if (this.getRightMarkers[key].contentType === 32) {
            filtered[key] = this.getRightMarkers[key];
          }
          return filtered;
        }, {});
      } else {
        return Object.keys(this.getRightMarkers).reduce((filtered, key) => {
          if (this.getRightMarkers[key].contentType !== 32) {
            filtered[key] = this.getRightMarkers[key];
          }
          return filtered;
        }, {});
      }
    }
  },
  methods: {
    ...mapMutations('attractionStore', [
      'SET_RIGHT_MAP',
      'SET_RIGHT_MARKERS',
      'UPDATE_ATTRACTION_LIST'
    ]),
    moveMapToMarker(marker) {
      /*console.log(marker.latlng.La);
      console.log(marker.latlng.Ma);*/
      var moveLatLon = new kakao.maps.LatLng(marker.latlng.Ma, marker.latlng.La);
      /* global kakao */
      //this.map.setLevel(5);
      this.selectedMarkerTitle = marker.title;

      //this.map.panTo(moveLatLon);
      this.getRightMap.panTo(moveLatLon);

      // 기존에 열린 infowindow가 있다면 닫기
      if (this.infowindow) {
        this.infowindow.close();
      }
      //마커 그리기 위한 위치
      var markerPos = new kakao.maps.Marker({
        position: moveLatLon
      });

      // let content = <div class="aaaa">asdasd</div>;
      // var iwContent = <div class="aaaa">asdasd</div>
      let iwPosition = new kakao.maps.LatLng(marker.latlng.Ma, marker.latlng.La);

      //마커 그리기
      this.infowindow = new kakao.maps.InfoWindow({
        position: iwPosition,
        content: `<div className="PopInfo" style="width: auto;
                                                  height: 80px;
                                                  border: 2px solid #BFA5A5;
                                                  padding-left: 15px 15px;">
                    <div className="popTitle" style="padding-left: 15px 15px;">${marker.title}</div>
                    <div className="popAddr">${marker.address}</div>
                  </div>`
      });
      //this.infowindow.open(this.map, markerPos);
      this.infowindow.open(this.getRightMap, markerPos)

    },
    closeInfowindow() {
      // 마우스가 markerItem에서 벗어날 때 infowindow 닫기
      if (this.infowindow) {
        this.infowindow.close();
      }
    },
    addAttractionList(marker) {
      console.log("right에서 전송보냄", marker)
      this.UPDATE_ATTRACTION_LIST(marker);
      //console.log(this.getAttractionList)
    },
    showHotel() {
      this.showHotelMarkers = true;
    },
    showPlace() {
      this.showHotelMarkers = false;
    }
  },

};

</script>

<style scoped>
/* 스크롤바 설정*/
.box1::-webkit-scrollbar {
    width: 20px;
}

/* 스크롤바 막대 설정*/
.box1::-webkit-scrollbar-thumb {
    background-color: #8bb9eb;
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;
    border: 7px solid #FFFFFF;
}

.rightBar {
    height: 1090px;
    display: inline-block;
    overflow-y: scroll;
    box-sizing: border-box;
    background-color: snow;
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
.markerItem {
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

.markerImage {
    width: 30%;
    border-radius: 4px 0 0 7px;
    margin-right: 4px;
}

.markerTitleTool {
    font-size: 13px !important;

}

.markerAddr {
    margin-top: auto;
    font-size: 10px !important;
    color: #919696;
}

.infoDiv {
    width: 200px;
}

.infoFav {
    display: flex;
    justify-content: end;
}

.heartBtn, .plusBtn {
    margin-right: 8px;
    cursor: pointer;
}

.heartBtn {
    margin-right: 10px;
}
</style>