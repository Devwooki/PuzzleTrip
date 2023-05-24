<template>
    <div class="comment-container">
        <div>
            <div class="comment-writer">
                <h2>{{ comment.userId }}</h2>
            </div>
            <div class="comment-detail">
                    {{ comment.content }}
            </div>
            <div class="comment-options">
                <span>{{ comment.createdAt }}</span>
<!--                <span>{{ comment.like }}</span>-->
            </div>
        </div>
        <div>
            <button v-if="checkUserInfo !==null && (comment.userId === checkUserInfo.id || checkUserInfo.id === 'admin')" class="write-btn btn-del" type="button" @click="commentDelete">삭제</button>
        </div>
    </div>
</template>

<script>
import {mapGetters} from "vuex";
import axios from "@/util/axios";

export default {
    name: 'BoardCommentList',
    props: {
        comment: Object
    },
    data() {
        return {};
    },
    methods: {
        async commentDelete() {
            //추후 해당 내용 boardStore의 action에서 비동기 처리하도록 수정
            console.dir(this.comment)
            const response = await axios.delete(`/comment/${this.getBoardType}/${this.getBoardNo}/${this.comment.no}`)
            console.log(response)
            if (response !== undefined) this.$store.commit("boardStore/SET_COMMENTS", response.data)
        }
    },
    computed: {
        ...mapGetters('boardStore', ['getBoardNo', 'getBoardType']),
        ...mapGetters('userStore', ['checkUserInfo'])
    }

};
</script>

<style scoped>

.comment-writer *, .comment-detail, .comment-options * {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
}

.comment-detail{
    padding: 10px 0;
}

.comment-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 90%;
    margin: 0 auto;
}

.comment-container div:nth-child(1){
    flex : 7;
    margin: 0 0 5px;
}

.write-btn {
    width: 50px;
    height: 30px;
    padding: 5px 10px;
    border: 2px solid #000;
    font-weight: 200;
    font-size: 12px;
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-block;
    position: relative;
    right: 0;
    margin: 0 5px;
}

.btn-del {
    background: #d96161;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}

.btn-del:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #f3d3d3;
    transition: all 0.2s ease;
}

.btn-del:hover {
    color: #ce5252;
}

.btn-del:hover:after {
    left: 0;
    width: 100%;
}

.btn-del:active {
    top: 2px;
}
</style>