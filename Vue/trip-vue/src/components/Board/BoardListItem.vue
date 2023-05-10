<template>
<tr>
    <td>{{board.no}}</td>
    <td><router-link :to="{ name : 'boardDetail' ,
                            params : {
                                boardType : this.board.typeNo,
                                boardNo : this.board.no
                            }
                            }">{{board.title}}</router-link>
    </td>
    <td>{{board.userId}}</td>
    <td>{{board.hit}}</td>
    <td>{{board.createdAt}}</td>
</tr>
</template>

<script>
export default {
    name: "BoardListItem",
    props : {
        board : Object
    },
    data(){
        return {

        }
    },
}
</script>

<style scoped>

</style>