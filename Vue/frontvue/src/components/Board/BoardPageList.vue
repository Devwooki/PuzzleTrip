<template>
  <!--https://github.com/lokyoung/vuejs-paginate  -->
  <div>
    <paginate
        :page-count="this.getPageCount"
        :click-handler="sendPageNo"
        :page-range="5"
        :prev-text="'이전'"
        :next-text="'다음'"
        :hide-prev-next=true
    ></paginate>
  </div>
</template>

<script>
//npm install vuejs-paginate --save 해서 page라이브러리 설치하기
import Paginate from 'vuejs-paginate'
import {mapGetters} from "vuex";

export default {
  name: "BoardPageList",
  components: {
    Paginate
  },
  data() {
    return {};
  },
  methods: {
    sendPageNo(pageNum) {
      this.$emit("loadPage", pageNum);
    }
  },computed : {
      ...mapGetters('boardStore', ['getPageCount']),
    }
};
</script>

<style scoped>
</style>