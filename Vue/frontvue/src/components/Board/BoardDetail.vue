<template>
    <div class="detail-div">
        <div class="detail-container">
            <div>
                <div class="title">{{ board.title }}</div>
                <div class="infos">
                    <label> 게시판 번호 : {{ board.typeNo }} | </label>
                    <label> 글번호 : {{ board.no }} | </label>
                    <label> 조회수 : {{ board.hit }} | </label>
                    <label> 작성시간 : {{ board.createdAt }} </label>
                </div>
                <blockquote>
                    <div class="main-content">
                        <p>{{ board.content }}</p>
                        <cite>{{ board.userId }} 작성</cite>
                    </div>
                    <div class="sub-content">
                        <div class="file-container">
                            <h3>파일</h3>
                            <div class="file-list">
                                <board-file-item :fileInfos="board.fileInfos"></board-file-item>
                            </div>
                        </div>
                        <div class="board-recommand" v-if="checkUserInfo !==null" >
                            <input type="checkbox" name="like" id="like" v-model="likeSelect" @change="changeLike">
                            <label for="like">추천 수 : {{ likeCnt }}</label>
                        </div>
                    </div>
                </blockquote>
            </div>
            <div class="btn-loc">
                <router-link class="write-btn btn-15" v-if="checkUserInfo !==null && (board.userId === checkUserInfo.id || checkUserInfo.id === 'admin') " :to="{name : 'boardModify'}">수정</router-link>
                <a class="write-btn btn-15" v-if="checkUserInfo !==null && (board.userId === checkUserInfo.id || checkUserInfo.id === 'admin')" @click="beforeRemove">삭제</a>
                <router-link class="write-btn btn-15" :to="{name : 'board'}">목록</router-link>
                <router-link class="write-btn btn-15" :to="{name : 'boardWrite'}">글쓰기</router-link>
            </div>

            <div v-if="checkUserInfo !== null || board.typeNo !== 1">
                <h3>댓글</h3>
                <board-comment></board-comment>
            </div>
        </div>





    </div>
</template>

<script>
import BoardFileItem from "@/components/Board/BoardFileItem.vue";
import BoardComment from "@/components/Board/BoardComment.vue";
import {mapGetters} from "vuex";
import axios from "@/util/axios";


export default {
    name: 'BoardDetail',
    components: {
        BoardFileItem,
        BoardComment
    },
    data() {
        return {
            board: {},
            likeSelect: false,
            likeCnt: 0,
        };
    },
    async created() {
        const response = await axios.get(`board/details/${this.getBoardType}/${this.getBoardNo}`)
        this.board = response.data
        console.log(this.board)
        this.likeCnt = this.board.likeCnt
        console.log("##########좀 떠라")
        console.log(this.checkUserInfo)
    },
    methods: {
        async beforeRemove() {
            if (confirm("정말 해당 게시글을 삭제하시겠습니까?")) {
                await axios.delete(`board/${this.getBoardType}/${this.getBoardNo}`)
                await this.$router.push({name: 'board'});
            }
        },
        changeLike() {
            console.log(this.likeSelect)
            if (this.likeSelect) {
                this.likeCnt += 1;
            } else {
                this.likeCnt -= 1;
            }
            axios.put(`board/like`, {
                userId: this.checkUserInfo.id,
                boardNo: this.board.no,
                likeSelect: this.likeSelect,
                typeNo: this.board.typeNo
            })
        }
    },
    computed: {
        ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo']),
        ...mapGetters('userStore', ['checkUserInfo'])
    }
}
</script>

<style scoped>
.detail-div{
    position: relative;;
    top : 30px;
}
.detail-container {
    width: 90%;
    max-width: 900px;
    margin: 50px auto;
}
.detail-container .title {
    position: relative;
    border-top: 2px solid #7D9600;
    margin : auto;
    padding: 10px 30px;
    font-size: 20px;
}

.detail-container .infos {
    position: relative;
    font-family: "Roboto", sans-serif;
    font-size: 10px;
    margin : auto;
    padding: 0px 0px 5px 0px;
    text-align: right;
}

.detail-container blockquote {
    position: relative;
    border-top: 1px solid #7D9600;
    border-bottom: 2px solid #7D9600;
    padding: 10px 30px;
}
blockquote p {
    height: 300px;
    position: relative;
    top: 5px;
}

.detail-container blockquote:before {
    position: absolute;
    background-color: #FFFFFF;
    color: #7D9600;
    font-family: 'FontAwesome';
    content: '\f10d';
    line-height: 1;
    text-align: center;
    top: -20px;
    left: -10px;
    padding: 10px;
    font-size: 20px;
}

.detail-container blockquote:after {
    position: absolute;
    right: -10px;
    bottom: -20px;
    background-color: #FFFFFF;
    padding: 10px;
    color: #7D9600;
    font-family: 'FontAwesome';
    content: '\f10e';
    line-height: 1;
    text-align: center;
    font-size: 20px;
}

.detail-container blockquote cite {
    display: block;
    font-size: 0.8rem;
    text-align: right;
    padding: 15px 0;
    color: #808080;
}

.sub-content{
    display: flex;
    flex-direction: row;

}

.sub-content .file-container{
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
    flex : 3;
}

.file-container h3{
    flex : 1;
    text-align: center;
}
.file-container div{
    flex : 6;
}

.sub-content .board-recommand{
    display: flex;
    flex-direction: column;
    align-items: center;
    flex : 1;
}

.file-list{
    display: flex;
    flex-direction: column;
    justify-content: right;
}


.btn-loc{
    display: flex;
    justify-content: right;
}

a {
    margin: 10px 10px 10px 0;
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
</style>