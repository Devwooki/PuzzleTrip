<template>
    <div class="planRoot">
        <div class="dayContent">
            <div class="choiceBox">
                <span>
                    <span style="color: #3f9ce4">{{ this.getLeftSelectedSido }}</span> : <span
                        style="color: red">{{ this.getDay.day }}</span>
                    일 여행 </span>
                <draggable group="dayOnce" v-model="checklist">
                    <div v-for="(attraction, index) in checklist"
                         :key="index"
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
                </draggable>
                <div style="text-align: left">첫 날: {{ this.monthDateDay1 }}</div>
                <div style="text-align: left">마지막 날:{{ this.monthDateDay2 }}</div>
                <div v-for="(check, index) in this.dragGroup" :key="index" class="dayDiv">
                    <div class="dayDivDay">{{ check.day }}일차</div>
                    <v-divider></v-divider>
                    <draggable group="dayOnce" v-model="check.contentList">
                        <div v-for="(attraction, attIdx) in check.contentList" :key="attIdx" @click="moveMapToMarker">
                            <div class="attractionItem">
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
                        </div>
                    </draggable>
                </div>
            </div>
        </div>
        <div id="Plan"></div>
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
            // oneDayAtt: [],
            map: null,
            message: '',
            dragGroup: [],
            checklist: [],
            months: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월'
            ],
            days: [
                '일요일',
                '월요일',
                '화요일',
                '수요일',
                '목요일',
                '금요일',
                '토요일'
            ],
            monthName1: null,
            monthName2: null,
            dateName1: null,
            dateName2: null,
            dayName1: null,
            dayName2: null,
            monthDateDay1: null,
            monthDateDay2: null,
            polyline: {},
            polylineArray:[],
        };
    },
    created() {
        for (let i = 1; i <= this.getDay.day; i++) {
            this.dragGroup.push({
                day: i,
                contentList: []
            });
        }
    },
    mounted() {
        //월
        this.monthName1 = this.months[this.getDay.day1.getMonth()]
        this.monthName2 = this.months[this.getDay.day2.getMonth()]
        //일
        this.dateName1 = this.getDay.day1.getDate()
        this.dateName2 = this.getDay.day2.getDate()
        //요일
        this.dayName1 = this.days[this.getDay.day1.getDay()]
        this.dayName2 = this.days[this.getDay.day2.getDay()]

        //전체
        this.monthDateDay1 = `${this.monthName1}-${this.dateName1 >= 10 ? this.dateName1 : '0' + this.dateName1}-${this.dayName1}`
        this.monthDateDay2 = `${this.monthName2}-${this.dateName2 >= 10 ? this.dateName2 : '0' + this.dateName2}-${this.dayName2}`
        //여행 목록 복사하기
        this.checklist = this.getAttractionList

        //맵 생성
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
                'getDay',
                'getLeftSelectedSido',
                'getDragGroup',
            ]
        ),
    },
    watch: {
        //리스트 변화하면 감지해서 받아옴
        getAttractionList(newList) {
            this.attractionList = newList
            // this.$store.commit("attractionStore/UPDATE_ATTRACTION_LIST", newList)
        },
        // dragGroup: {
        //     handler(newVal) {
        //         // 변경된 dragGroup 값을 저장하고 콘솔에 출력
        //
        //         // console.log("새로운 배열",newVal);
        //         // console.log("가져옴",this.getDragGroup)
        //     },
        //     deep: true // 중첩된 객체나 배열 내부의 변경도 감지
        // },
        dragGroup: {
            handler(newVal) {
                this.deletFindWay()
                const colors = ['#ff0000', '#00ff00', '#0000ff', '#ffff00', '#ff00ff', '#00ffff'];
                this.UPDATE_DRAG_GROUP(newVal);
                for (const ele of newVal) {
                    for (const element of ele.contentList) {
                        const imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                        let imageSize = new kakao.maps.Size(24, 35);
                        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

                        new kakao.maps.Marker({
                            map: this.map, // 마커를 표시할 지도
                            position: element.latlng, // 마커를 표시할 위치
                            title: element.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                            image: markerImage // 마커 이미지
                        });
                    }
                }
                let linePath;
                console.log(newVal)
                // let distance;
                for (let element=0; newVal.length; element++) {
                    for (let i = 0; i < newVal[element].contentList.length; i++) {
                        console.log("asd", i)
                        if (i != 0) {
                            linePath = [newVal[element].contentList[i - 1].latlng, newVal[element].contentList[i].latlng]
                        }
                        this.map.setLevel(8);
                        this.map.panTo(newVal[element].contentList[i].latlng);
                        console.log("번호",element)
                        this.polyline = new kakao.maps.Polyline({
                            map: this.map,
                            path: linePath, // 선을 구성하는 좌표배열 입니다
                            strokeWeight: 3, // 선의 두께 입니다
                            strokeColor: colors[newVal[element].day], // 선의 색깔입니다
                            strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                            strokeStyle: 'solid' // 선의 스타일입니다
                        });

                        // 지도에 선을 표시합니다
                        this.polyline.setMap(this.map);
                        // 배열에 선 객체 추가
                        this.polylineArray.push(this.polyline);
                    }

                }
            },
            deep: true // 중첩된 객체나 배열 내부의 변경도 감지
        },
    },
    methods: {
        ...mapMutations('attractionStore', [
            'UPDATE_ATTRACTION_LIST',
            'UPDATE_ATTRACTION_LIST_MINUS',
            'UPDATE_DRAG_GROUP',
        ]),
        deletFindWay() {
            //선 삭제
            this.polylineArray.forEach(function (polyline) {
                polyline.setMap(null);
            });
            this.polylineArray = [];
            //오버레이 삭제
        },
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
            this.container = document.getElementById("Plan");
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
            console.log(moveLatLon)
            //센터로 이동하고
            this.map.setLevel(3);
            this.map.panTo(moveLatLon);

            // 기존에 열린 infowindow가 있다면 닫기
            if (this.customOverlay) {
                this.customOverlay.setMap(null)
            }
            //마커 그리기
            this.customOverlay = new kakao.maps.CustomOverlay({
                position: moveLatLon,
                content: `<div class="popTitle" style="padding-left: 15px 15px; padding: 10px; border:1px solid black; background-color: #FFFFFF">${marker.title}</div>`
            });
            this.customOverlay.setMap(this.map)
        },
    }
}
</script>

<style scoped>
@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}

* {
    font-family: 'SUITE-Regular';
    font-weight: 700;
}

.planRoot {
    display: flex;
    margin-top: 30px;
}

#Plan {
    width: 80%;
    height: 780px;
    margin-top: 30px;
}

/*일정 DIV 배치*/
.dayContent {
    margin-top: 30px;
    display: flex;
    text-align: center;
    margin-left: 30px;
    min-height: 905px;
    max-height: 905px;
    width: 330px;
    overflow-y: scroll;
    box-sizing: border-box;
    background-color: snow;
}

/*일정 간격*/
.dayDiv {
    margin-top: 10px;
    min-height: 100px;
    min-width: 290px;
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
    background-color: #FFEAD2;
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