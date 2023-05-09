<template>
    <div>
        <h2>뷰를 활용한 게시판 불러오기</h2>
        <board-list></board-list>
    </div>
</template>

<script>
import BoardList from "@/components/Board/BoardList.vue";

export default {
    name: "AppBoard",
    components :{
        BoardList
    }
}
</script>

<style scoped>

</style>