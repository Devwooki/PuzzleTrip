<template>
<tr  @click="goDetail">
    <td>{{board.no}}</td>
    <td>{{board.title}}</td>
    <td>{{board.userId}}</td>
    <td>{{board.hit}}</td>
    <td>{{board.likeCnt}}</td>
    <td>{{board.createdAt}}</td>
</tr>
</template>

<script>

import {mapGetters} from "vuex";

export default {
    name: "BoardListItem",
    props : {
        board : Object
    },
    methods :{
        goDetail(){
            this.$store.commit('boardStore/SET_BOARD_NO', this.board.no)
            this.$router.push({name : 'boardDetail'})
        }
    },
    computed :{
        ...mapGetters('boardStore', ['getBoardNo']),
    }
}
</script>

<style scoped>
/*tr 선택하면 그 부분 전체 하이라이트 들어가게(호버 효과나 그런 거?)*/
</style>