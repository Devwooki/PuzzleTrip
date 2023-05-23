<template>
  <div class="choicePlay">
    <div class="choice">선택 장소</div>
    <div v-for="(attraction, index) in getAttractionList.filter(attraction => attraction.contentType !== 32)" :key="attraction.contentId" class="attractionItem"
         @mouseover="moveMapToMarker(attraction)" @mouseleave="closeInfowindow">
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
</template>

<script>
import {mapGetters, mapMutations} from "vuex";

export default {
  name: 'AppChoiveHotel',
  components: {},
  data() {
    return {
      dates: ['2023-05-10', '2023-05-20'],
      panel: [0, 1],
      disabled: false,
      readonly: false,
      EndPoint: "",
      attractionList: [],
    };
  },
  //     selectedSido: {
  // props: {
  //         type: String,
  //         default: '',
  //     },
  //     selectedGugun: {
  //         type: String,
  //         default: '',
  //     },
  //     startPoint: {
  //         type: String,
  //         default: '',
  //     },
  //     endPoint: {
  //         type: String,
  //         default: '',
  //     },
  // },
  computed: {
    ...mapGetters(
      'attractionStore',
      [
        'getLeftStartPoint',
        'getLeftEndPoint',
        'getLeftWayPoint',
        'getAttractionList',
        'getRightMarkers',
        "getRightMap",
        "getLeftDistance",
        "getLeftDuration"
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

  },
  watch: {
    //리스트 변화하면 감지해서 받아옴
    getAttractionList(newList) {
      console.log("갱신리스트", newList)
      this.attractionList = newList
      // this.$store.commit("attractionStore/UPDATE_ATTRACTION_LIST", newList)
    },
  },
  methods: {
    ...mapMutations('attractionStore', [
      'SET_RIGHT_MAP',
      'SET_RIGHT_MARKERS',
      'UPDATE_ATTRACTION_LIST',
      'UPDATE_ATTRACTION_LIST_MINUS'
    ]),
    //리스트에 호버 하면 지도 위치이동
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
    minusList(index) {
      console.log(index)
      this.UPDATE_ATTRACTION_LIST_MINUS(index)
    }
  },

};
</script>

<style scoped>

/* 선택 목록 추가 */
.choice {
    margin-top: -10px;
    font-size: 20px;
    text-align: center;
}

.attractionItem {
    margin-top: 20px;
    margin-left: 25px;
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