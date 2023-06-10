<template>
    <div>
        <div>
            <div class="container container1">
                <span>총 게시글 수 : {{ pageResult.totalBoard }}개</span>
                <ul class="board-type">
                    <li :class="{ boardactive: selected === 2 }" value="2" @click="initBoard">자유게시판 : 2</li>
                    <li :class="{ boardactive: selected === 1 }" value="1" @click="initBoard">공지사항 : 1</li>
                </ul>
            </div>

            <div id="board-list">
                <div class="container container2">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th class="th-num">번호</th>
                            <th class="th-title">제목</th>
                            <th class="th-writer">글쓴이</th>
                            <th class="th-hit">조회수</th>
                            <th class="th-like-cnt">추천수</th>
                            <th class="th-date">등록일</th>
                        </tr>
                        </thead>

                        <tbody>
                        <board-list-item v-for="board in boards" :key="board.no" :board="board"></board-list-item>
                        </tbody>

                    </table>

                    <div class="btn-loc" v-if="checkUserInfo !== null">
                        <router-link class="write-btn btn-15" :to="{name : 'boardWrite'}">글쓰기</router-link>
                    </div>


                </div>
            </div>
        </div>
        <board-page-list @loadPage="loadPage"></board-page-list>
    </div>
</template>

<script>
import BoardListItem from "@/components/Board/BoardListItem.vue";
import BoardPageList from "@/components/Board/BoardPageList.vue";
import myAxios from "@/util/axios";
import {mapGetters} from "vuex";

export default {
    name: "BoardList",
    components: {
        BoardListItem,
        BoardPageList
    },
    data() {
        return {
            selected: 2,
            boards: {},
            pageResult: {},
            isAdmin : false,
        };
    },
    methods: {
        initBoard(event) {

            this.$store.commit('boardStore/SET_BOARD_TYPE', event.target.value);
            this.$store.commit('boardStore/SET_PAGE_NO', 1);
            this.selected = event.target.value;
            this.getBoardData();
        },
        loadPage(pageNum) {
            this.$store.commit('boardStore/SET_PAGE_NO', pageNum);
            this.getBoardData()
        },
        async getBoardData() {
            const response = await myAxios.get(`board/lists/${this.getBoardType}/${this.getPageNo}`)
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
        ...mapGetters('boardStore', ['getBoardType', 'getPageNo']),
        ...mapGetters('userStore', ['checkUserInfo'])
    },
};
</script>

<style scoped>
* {
    list-style: none;
    text-decoration: none;
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

table {
    border-collapse: collapse;
    border-spacing: 0;
}
.board-table {
    font-size: 13px;
    width: 100%;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}

.board-table tr {
    text-align: center;
}

.board-table .th-num {
    width: 10%;
    text-align: center;
}

.board-table .th-title {
    width: 50%;
}

.board-table .th-writer {
    width: 10%;
}

.board-table .th-hit {
    width: 5%;
}

.board-table .th-like-cnt {
    width: 5%;
}

.board-table .th-date {
    width: 20%;
}

.board-table th, .board-table td {
    padding: 14px 0;
}

.board-table tbody td {
    border-top: 1px solid #e7e7e7;
    text-align: center;
}

.board-table tbody th {
    padding-left: 28px;
    padding-right: 14px;
    border-top: 1px solid #e7e7e7;
    text-align: left;
}

p {
    width: 90%;
    text-align: right;
    margin: 1rem 0;
}

.btn-loc{
    display: flex;
    justify-content: right;
}

a {
    margin: 10px;
    outline: none;
    text-align: center;
    font-size : 12px;
}
.write-btn {
    width: 70px;
    height: 35px;
    padding: 10px 15px;
    border: 2px solid #000;
    font-weight: 200;
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-block;
    position: relative;
    right: 0;
}
/* 15 */
.btn-15 {
    background: #626262;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}
.btn-15:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #e0e5ec;
    transition: all 0.2s ease;
}
.btn-15:hover {
    color: #626262;
}
.btn-15:hover:after {
    left: 0;
    width: 100%;
}
.btn-15:active {
    top: 2px;
}
/* reset */



.container.container2 {
    width: 90%;
    margin: 0 auto;
    padding: 0
}

.container.container1  {
    width: 90%;
    margin: 0 auto;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.boardInfo-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 90%;
    margin:0 auto;
    border-radius: 5px;
}

/*.board-type {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
}

.boardInfo-container span {
    margin-left: auto;
}*/


.board-type {
    display: flex;
    justify-content: center;
    padding: 0 auto;
    max-width: 900px;
}

.board-type li {
    margin: 10px 0px;
    padding: 5px 15px 5px;
    font-size: 12px;
    list-style-type: none;
}

.board-type li:hover {
    background-color: #7D9600;
    color: #FFF;
    border-radius: 5px;
}
.board-type li:active {
    position: relative;
    top: 2px;
}

.boardactive {
    border-bottom: 4px solid #7D9600;
    font-weight: bold;
    border-radius: 5px;
}
</style>
