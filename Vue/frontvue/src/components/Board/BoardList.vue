<template>
    <div>
        <h1>게시판 리스트 출력</h1>
        <div>
            <ul>
                <li class="active" value="2" @click="initBoard">자유게시판 : 2</li>
                <li value="1" @click="initBoard">공지사항 : 1</li>
            </ul>
        </div>
        <div>
            <p>지금 게시판 상태 : {{ this.getBoardType }}</p>
            <p>총 게시글 수 : {{ pageResult.totalBoard }}개</p>
            <table>
                <thead>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>조회수</th>
                <th>추천수</th>
                <th>등록일</th>
                </thead>
                <tbody>
                <board-list-item v-for="board in boards" :key="board.no" :board="board"></board-list-item>
                </tbody>

                <router-link :to="{name : 'boardWrite'}">글쓰기</router-link>
            </table>
        </div>
        <board-page-list @loadPage="loadPage"></board-page-list>
    </div>
</template>

<script>
import BoardListItem from "@/components/Board/BoardListItem.vue";
import BoardPageList from "@/components/Board/BoardPageList.vue";
import axios from "@/util/axios";
import {mapGetters} from "vuex";

export default {
    name: "BoardList",
    components: {
        BoardListItem,
        BoardPageList
    },
    data() {
        return {
            boards: {},
            pageResult: {},
        };
    },
    methods: {
        initBoard(event) {
            this.$store.commit('boardStore/SET_BOARD_TYPE', event.target.value);
            this.$store.commit('boardStore/SET_PAGE_NO', 1);
            this.pageNo = 1;
            this.getBoardData();
        },
        loadPage(pageNum) {
            this.$store.commit('boardStore/SET_PAGE_NO', pageNum);
            this.getBoardData()
        },
        async getBoardData() {
            const response = await axios.get(`board/lists/${this.getBoardType}/${this.getPageNo}`)
            this.pageResult = response.data.pageResult;
            this.boards = response.data.list;
            this.$store.commit('boardStore/SET_PAGE_COUNT', this.pageResult.endPageRange)
        }
    },
    created() {
        console.log("게시판 리스트로 와따!!")
        //getters로 얻어온 값은 this를 통해 사용할 수 있다
        this.$store.commit('boardStore/SET_BOARD_TYPE', 2);
        console.log(this.getBoardType)
        console.log(this.getPageNo)
        this.getBoardData()
    },
    computed: {
        //vuex모듈 중 boardStore에서 'getBoardType', 'getPageNo'를 얻어온다.
        ...mapGetters('boardStore', ['getBoardType', 'getPageNo'])
    },
};
</script>

<style scoped>
</style>