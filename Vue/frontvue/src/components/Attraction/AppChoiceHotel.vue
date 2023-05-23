<template>
  <div class="choiceHotel">
    <div class="choice">선택 호텔</div>
    <div v-for="(attraction, index) in getAttractionList.filter(attraction => attraction.contentType === 32)" :key="attraction.contentId" class="attractionItem"
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
export default {
  name: 'AppChoiveHotel',
  components: {},
  data() {
    return {
      message: '',
    };
  },
  created() {
  },
  methods: {},
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