<template>
    <div>
        <paginate
            :page-count="pageResult.endPageRange"
            :click-handler="sendPageNo"
            :prev-text="'이전'"
            :next-text="'다음'"
        ></paginate>
    </div>
</template>

<script>
//npm install vuejs-paginate --save 해서 page라이브러리 설치하기
import Paginate from 'vuejs-paginate'
export default {
    name: "BoardPageList",
    components :{
        Paginate
    },
    props: {
        pageResult: Object
    },
    data() {
        return {};
    },
    methods: {
        sendPageNo(pageNum){
            this.$emit("loadPage", pageNum);
        }
    },
};
</script>

<style scoped>
</style>