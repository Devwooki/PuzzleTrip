<template>
    <div class="planRoot">
        <div class="dayContent">
            <div class="dayCount">
                <div class="dayDiv">일정</div>
                <button class="dayDiv">전체 일정</button>
                <button v-for="(idx) in this.getDay" :key="idx" class="dayDiv" @click="saveDay(idx)">
                    {{ idx }}일차
                </button>
            </div>
            <div class="choiceBox">
                <span>내가 선택한 여행 목록 </span>
                <draggable v-model="idx">
                    <transition-group>
                        <div v-for="idx in this.getDay"
                             :key="idx"
                             class="dayOnce">
                            {{ idx }}일차
                        </div>
                        <div v-for="(attraction, index) in getAttractionList"
                             :key="attraction.contentId"
                             class="attractionItem"
                             @click="moveMapToMarker(attraction)">
                            <img :src="attraction.image" alt="attraction Image" class="attractionImage"/>
                            <div class="infoDiv">
                                <span class="attractionTitleTool">{{ attraction.title }}</span>
                                <div class="attractionAddr">{{ attraction.address }}</div>
                                <div class="infoFav">
                                    <font-awesome-icon :icon="['fas', 'minus-circle']" class="plusBtn"
                                                       @click="minusList(index)"
                                                       :style="{ color: 'skyblue' }"/>
                                    <font-awesome-icon :icon="['fas', 'heart']" class="heartBtn"
                                                       :style="{ color: '#f95880' }"/>
                                </div>
                            </div>
                        </div>
                    </transition-group>
                </draggable>

            </div>
        </div>
        <div id="map"></div>

    </div>

</template>

<script>
import {mapGetters, mapMutations} from "vuex";
/* drag */
import draggable from 'vuedraggable'

export default {
    name: 'AppPlan',
    components: {
        draggable
    },
    data() {
        return {
            oneDayAtt: [],
            map: null,
            message: '',
        };
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
                `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=${process.env.VUE_APP_KAKAO_KEY}`;
            document.head.appendChild(script);
        }
    },
    computed: {
        ...mapGetters(
            'attractionStore',
            [
                'getAttractionList',
                'getDay'
            ]
        ),
    },
    watch: {
        //리스트 변화하면 감지해서 받아옴
        getAttractionList(newList) {
            this.attractionList = newList
            // this.$store.commit("attractionStore/UPDATE_ATTRACTION_LIST", newList)
        },
    },
    methods: {
        ...mapMutations('attractionStore', [
            'UPDATE_ATTRACTION_LIST',
            'UPDATE_ATTRACTION_LIST_MINUS',
        ]),
        minusList(index) {
            if (this.customOverlay) {
                this.customOverlay.setMap(null)
            }
            this.UPDATE_ATTRACTION_LIST_MINUS(index)
        },
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
        //리스트에 호버 하면 지도 위치이동
        moveMapToMarker(marker) {
            //좌표 찾고 타이틀 찾고
            let moveLatLon = new kakao.maps.LatLng(marker.latlng.Ma, marker.latlng.La);
            this.selectedMarkerTitle = marker.title;
            //센터로 이동하고
            this.map.setLevel(5);
            this.map.panTo(moveLatLon);
            //확대하고

            // 기존에 열린 infowindow가 있다면 닫기
            if (this.customOverlay) {
                this.customOverlay.setMap(null)
            }
            //마커 그리기
            this.customOverlay = new kakao.maps.CustomOverlay({
                position: moveLatLon,
                content: `<div class="popTitle" style="padding-left: 15px 15px; padding: 10px; background-color: #FFFFFF">${marker.title}</div>`
            });
            this.customOverlay.setMap(this.map)
        },
        saveDay(idx) {
            const selectedAttractions = this.getAttractionList.filter(oneDayAtt => oneDayAtt.day === idx);
            console.log(`일차 ${idx} 저장된 여행 목록:`, selectedAttractions);
        },

    }
}
</script>

<style scoped>
.aaaa {
    border: 1px solid black;
}


.planRoot {
    display: flex;
    margin-top: 30px;
}

#map {
    margin-top: 30px;
}

/*일정 DIV 배치*/
.dayCount {
    display: flex;
    flex-direction: column;
    border: 1px solid black;
    width: 100px;
    margin-top: 30px;
    margin-right: 10px;
    min-height: 900px;
    max-height: 900px;
}

.choiceBox {
    margin-top: 30px;
    margin-right: 10px;
    min-height: 900px;
    max-height: 900px;
}

.dayContent {
    display: flex;
    text-align: center;
    margin-left: 30px;
    min-height: 905px;
    max-height: 905px;
    width: 450px;
    overflow-y: scroll;
    box-sizing: border-box;
    background-color: snow;
}

/*일정 간격*/

.dayDiv {
    border: 1px solid black;
    margin-top: 10px;
}

.dayOnce {
    border: 1px solid black;
    width: 295px;
    min-height: 20px;
    height: fit-content;
}

/* 선택 리스트 */
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