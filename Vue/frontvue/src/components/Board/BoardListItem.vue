<template>
<tr  @click="goDetail">
    <td>{{board.no}}</td>
    <td><h3>{{board.title}}</h3></td>
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
tr:hover {
    background-color: #f2f2f2;
    cursor: pointer;
}
tr:active{
    position: relative;
    top:2px
}
/*tr 선택하면 그 부분 전체 하이라이트 들어가게(호버 효과나 그런 거?)*/
.board-table th, .board-table td {
    padding: 14px 0;
}

.board-table tbody td {
    border-top: 1px solid #e7e7e7;
    text-align: center;
}

td h3 {
    box-sizing: content-box;
    text-align:-webkit-left;
}

.board-table tbody th {
    padding-left: 28px;
    padding-right: 14px;
    border-top: 1px solid #e7e7e7;
    text-align: left;
}

.board-table tbody th p {
    display: none;
}
</style>