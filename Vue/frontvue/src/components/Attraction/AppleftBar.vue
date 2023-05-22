<template>
  <div id="app">
    <div class="findWay">
      <button class="StartPoint">출 발:</button>
      <div class="Text">{{ getLeftStartPoint }}</div>

      <!--      <button class="WayPoint">추가 1:</button>-->
      <!--      <div class="Text">{{ getLeftWayPoint }}</div>-->

      <!--      <button class="WayPoint">추가 2:</button>-->
      <!--      <div class="Text">{{ getLeftWayPoint }}</div>-->

      <!--      <button class="WayPoint">추가 3:</button>-->
      <!--      <div class="Text">{{ getLeftWayPoint }}</div>-->

      <button class="EndPoint">도 착:</button>
      <div class="Text">{{ getLeftEndPoint }}</div>

    </div>
    <div class="findTime">
      <div class="Text">{{ getLeftDistance }}</div>
      <button class="EndPoint">Km/h</button>

      <div class="Text">{{ getLeftDuration }}</div>
      <button class="EndPoint">분</button>
    </div>
    <v-expansion-panels v-model="panel" :disabled="disabled" multiple class="calBox">
      <v-expansion-panel>
        <v-expansion-panel-header>여행 일정 정하기</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col>
              <v-date-picker v-model="dates" range></v-date-picker>
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
    <div class="moveLoc">
      <v-btn @click="showPlan">목록 출력</v-btn>
    </div>

  </div>
</template>

<script>
import {mapGetters} from "vuex";

export default {
  name: 'AppLeftBar',
  components: {},
  data() {
    return {
      dates: ['2023-05-10', '2023-05-20'],
      panel: [0, 1],
      disabled: false,
      readonly: false,
      EndPoint: ""
    };
  },
  // props: {
  //     selectedSido: {
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
    dateRangeText() {
      return this.dates.join(' ~ ')
    },
  },
  methods: {
    showPlan() {
      console.log("추가한 여향지 목록 보여준다")
      console.log(this.getAttractionList)
    },

  },
};
</script>

<style scoped>
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
</style>