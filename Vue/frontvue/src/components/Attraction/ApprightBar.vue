<template>
  <!--  <div class="rightBar">-->
  <!--    <div v-for="marker in markers" :key="marker.contentId" class="markerItem"  @mouseover="moveMapToMarker(marker)" @mouseleave="closeInfowindow">-->
  <!--      <img :src="marker.image" alt="Marker Image" class="markerImage"/>-->
  <!--      <div>-->
  <!--        <span class="markerTitleTool">{{ marker.title }}</span>-->
  <!--        <div class="markerAddr">{{ marker.address }}</div>-->
  <!--        <v-btn>+</v-btn>-->
  <!--      </div>-->
  <!--    </div>-->
  <!--  </div>-->
    <div class="rightBar">
        <div v-for="marker in getRightMarkers" :key="marker.contentId" class="markerItem"
             @mouseover="moveMapToMarker(marker)" @mouseleave="closeInfowindow">
            <img :src="marker.image" alt="Marker Image" class="markerImage"/>
            <div>
                <span class="markerTitleTool">{{ marker.title }}</span>
                <div class="markerAddr">{{ marker.address }}</div>
                <v-btn>+</v-btn>
            </div>
        </div>
    </div>
</template>

<script>

import {mapGetters, mapMutations} from "vuex";

export default {
    name: 'AppRightBar',
    components: {},
    data() {
        return {
            // infowindow: null,
            // rightmap: null,
            selectedMarkerTitle: ''
        };
    },
    computed: {
        ...mapGetters('attractionStore', ['getRightMap', 'getRightMarkers']),
        ...mapMutations('attractionStore', ['SET_RIGHT_MAP', 'SET_RIGHT_MARKERS'])
    },
    // props: {
    //     markers: {
    //         type: Array,
    //     },
    //     map: {
    //         type: Object,
    //         required: true
    //     },
    // },
    mounted() {
        //디버깅용
        // console.log("#####두드등장")
        // console.log(this.rightmap)

        //this.rightmap = this.map; 대신에 this.getRightMap 쓰면 됩니당

    },
    methods: {
        moveMapToMarker(marker) {
            console.log(marker.latlng.La);
            console.log(marker.latlng.Ma);
            var moveLatLon = new kakao.maps.LatLng(marker.latlng.Ma, marker.latlng.La);
            /* global kakao */
            //this.map.setLevel(5);
            this.getRightMap.setLevel(5);
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
                content: `<div>${marker.title}</div>
                  <div>${marker.address}</div>`
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
    }
};

</script>

<style scoped>
.rightBar {
    overflow-y: auto;
}

.markerItem {
    margin-left: 10px;
    margin-top: 8px;
    box-shadow: 2px 2px 2px 2px #DDDDDD;
    width: 270px;
    display: flex;
    flex-direction: row;
    border-radius: 7px;
}

.markerImage {
    width: 40%;
    border-radius: 7px 0 0 7px;
    margin-right: 4px;
}

.markerTitleTool {
    font-size: 13px !important;

}

.markerAddr {
    margin-top: auto;
    font-size: 10px !important;
}
</style>