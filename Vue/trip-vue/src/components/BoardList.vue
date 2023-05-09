<template>
    <div>
        <h1>게시판 리스트 출력</h1>
        <table>
            <thead>
            <th>번호</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>조회수</th>
            <th>등록일</th>
            </thead>
        </table>
        <tbody>
            <board-list-item v-for="board in boards" :key="board.no" :board="board"></board-list-item>
        </tbody>
    </div>
</template>

<script>
import BoardListItem from "@/components/BoardListItem.vue";

export default {
    name: "BoardList",
    components: {BoardListItem},
    data(){
        return {
            boards : {},
            pageNavi : {}

        }
    },
    created(){
        fetch("http://localhost:8989/board/lists/1/1")
            .then(response => response.json())
            .then(data => {
                this.boards = data.list
                this.pageNavi = data.pageResult

                console.dir(this.boards)
                console.dir(this.pageNavi)
            });

    }
}
</script>

<style scoped>

</style>