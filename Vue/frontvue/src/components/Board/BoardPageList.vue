<template>
  <!--https://github.com/lokyoung/vuejs-paginate  -->
  <div>
    <paginate
        :page-count="this.getPageCount"
        :click-handler="sendPageNo"
        :page-range="5"
        :prev-text="'이전'"
        :next-text="'다음'"
        :container-class="'pagination'"
        :page-class="'page-item'"
        :active-class="'actived'"
        :first-last-button=true
        :no-li-surround=true
        :first-button-text="'처음'"
        :last-button-text="'마지막'"
        >
    </paginate>
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

<style lang="css">
.pagination {
    display : flex;
    justify-content: center;
    margin:24px;

}
.pagination a{
    min-width:32px;
    padding:10px 10px;
    text-align:center;
    margin:0 3px;
    border-radius: 6px;
    color:#574141;
}

.pagination a:hover {
    /*position: relative;*/
    /*width: 32px;*/
    /*margin-top: -40px;*/
    /*padding-top: 2px;*/
    /*!*background: #7D9600;*!*/
    /*left: -32px;*/
    /*transition: .2s;*/
    /*background-color: black;*/
    background: #E4DBD6;
    border-radius: 2px;
}

.pagination a:active {
    position: relative;
    top: 2px;
}

.actived {
    background-color : #7D9600;
    color:#fff !important;
}
</style>