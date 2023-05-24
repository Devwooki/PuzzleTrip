<template>
  <div>
    <div class="totalDay">
      <span>여행 일정: </span>
      <span>{{ this.getDay }}박 {{ this.getDay + 1 }}일 여행</span>
    </div>
    <div class="dayContent">
      <div class="dayCount">
        <div class="dayDiv">일정</div>
        <div class="dayDiv">전체 일정</div>
        <div v-for="(idx) in this.getDay" :key="idx" class="dayDiv">
          {{ idx }}일차
        </div>
      </div>
      <div class="choiceBox">
        <span>내가 선택한 여행 목록 </span>
        <div v-for="(idx) in this.getDay" :key="idx" class="dayOnce">
          {{ idx }}일차
        </div>
        <div v-for="(attraction, index) in getAttractionList" :key="attraction.contentId" class="attractionItem">
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
  name: 'AppPlan',
  components: {},
  data() {
    return {
      message: '',
      attractionList: [],
    };
  },
  computed: {
    ...mapGetters(
      'attractionStore',
      [
        'getAttractionList',
        'getDay'
      ]
    )
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
      'UPDATE_ATTRACTION_LIST',
      'UPDATE_ATTRACTION_LIST_MINUS',
    ]),
    minusList(index) {
      console.log(index)
      this.UPDATE_ATTRACTION_LIST_MINUS(index)
    },
  },
};
</script>

<style scoped>
/*일정 DIV 배치*/
.totalDay {
    margin-top: 130px;
    margin-left: 30px;
    background-color: papayawhip;
}

.dayCount {
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
    width: 400px;
    overflow-y: scroll;
    box-sizing: border-box;
    background-color: snow;
}

/*일정 간격*/

.dayDiv {
    margin-top: 10px;
    margin-bottom: 10px;
}
.dayOnce{
    border: 1px solid black;
    width: 295px;
    min-height: 50px;
    height: fit-content;
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