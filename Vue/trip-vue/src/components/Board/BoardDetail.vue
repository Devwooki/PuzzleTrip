<template>
    <div>
        <div>
            <label> 글번호 : {{ board.no }} | </label>
            <label> 작성자 : {{ board.userId}} | </label>
            <label> 조회수 : {{ board.hit }} | </label>
            <label> 작성시간 : {{ board.createcAt }} | </label>
            <label> 글제목</label>
            <div>{{ board.title }}</div>
            <label> 내용</label>
            <div>{{ board.content }}</div>

            <div style="padding-top: 15px">
                <router-link :to="{name : 'boardModify', params :{ boardType : board.typeNo, boardNo : board.no }}">수정</router-link> |
                <router-link :to="{name : 'boardDelete', params: { boardType : board.typeNo, boardNo : board.no}}">삭제</router-link> |
                <router-link :to="{name : 'board', params: { boardType : board.typeNo}}">목록 | </router-link>
                <router-link :to="{name : 'boardWrite',  params: { boardType : board.typeNo}}">글쓰기</router-link>
            </div>
        </div>
        <board-comment :boardType="boardType" :boardNo="boardNo"></board-comment>
    </div>
</template>

<script>
import BoardComment from "@/components/Board/BoardComment.vue";

export default {
    name: 'BoardDetail',
    components :{
        BoardComment
    },
    data() {
        return {
            board : {},
            boardType : 0,
            boardNo : 0,
        };
    },
    created() {
        this.boardType = this.$route.params.boardType;
        this.boardNo = this.$route.params.boardNo;
        console.log(this.boardType + ", " + this.boardNo)

        fetch("http://localhost:8989/board/details/"+ this.boardType + "/" + this.boardNo)
            .then(response => response.json())
            .then(data => this.board=data)

    }
};
</script>

<style scoped></style>