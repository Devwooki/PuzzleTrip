<template>
<tr>
    <td>{{board.no}}</td>
    <td>{{board.title}}</td>
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
    }
}
</script>

<style scoped>

</style>