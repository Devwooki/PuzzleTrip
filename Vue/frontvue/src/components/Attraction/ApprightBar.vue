<template>
  <div class="themeChoice">
    <div class="menu">
      <router-link :to="{name: 'hotelComp'}" class="hotelChoice">호텔</router-link>
      <router-link :to="{name: 'playComp'}" class="playChoice">장소</router-link>
    </div>
    <router-view class="themeRes"></router-view>
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
      selectedMarkerTitle: ''
    };
  },
  computed: {//해당 컴포넌트에 계산된(computed) state를 가져온다 - getter
    ...mapGetters('attractionStore', ['getRightMap', 'getRightMarkers', 'getAttractionList']),
  },
  methods: {
    ...mapMutations('attractionStore', [
      'SET_RIGHT_MAP',
      'SET_RIGHT_MARKERS',
      'UPDATE_ATTRACTION_LIST'
    ]),
  }
};

</script>

<style scoped>
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
.themeRes {
    height: 1090px;
}
</style>