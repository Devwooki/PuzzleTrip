<template>
    <div>
        <board-comment-list class="my-list"
            v-for="comment in getComments"
            :key="comment.no"
            :comment="comment">
        </board-comment-list>

        <div class="comment-write-container" v-if="checkUserInfo !== null">
            <textarea rows={1} class="comment-area" ref="commentArea" v-model="content" v-autosize/>
            <div class="comment-btns">
                <button class="write-btn btn-del" @click="removeContent">취소</button>
                <button class="write-btn btn-15" @click="writeComment">등록</button>
            </div>
        </div>
    </div>
</template>

<script>
import BoardCommentList from "@/components/Board/BoardCommentList.vue";
import {mapGetters} from "vuex";
import axios from "@/util/axios";

export default {
    name: 'BoardComment',
    components: {
        BoardCommentList
    },
    data() {
        return {
            userId: '',
            content: '',
        };
    },
    async created() {
        this.userId = this.checkUserInfo.id
        const response = await axios.get(`/comment/${this.getBoardType}/${this.getBoardNo}`)
        this.$store.commit('boardStore/SET_COMMENTS', response.data);
    },
    methods: {
        async writeComment() {
            if(this.content.trim() !== '') {
                const sendData = {
                    userId: this.userId,
                    content: this.content,
                    boardType: this.getBoardType,
                    boardNo: this.getBoardNo,
                }

                const response = await axios.post(`/comment/${this.getBoardType}/${this.getBoardNo}`, sendData)
                this.$store.commit('boardStore/SET_COMMENTS', response.data)
                this.content = ''
                this.$refs.commentArea.focus()
            }
        },
        removeContent() {
            this.content = ''
            this.$refs.commentArea.focus()
        },
    },
    computed: {
        ...mapGetters('boardStore', ['getBoardType', 'getBoardNo', 'getComments']),
        ...mapGetters('userStore', ['checkUserInfo'])
    }
};
</script>

<style scoped>
.comment-write-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
}
.my-list{
    border-bottom: 1.5px solid #bcc6c7;
}

.comment-area {
    margin: 10px;
    background-color: white;
    width: 80%;
    height: auto;
    border-radius: 5px;
    border: 3px solid #7D9600;
    resize : none; /*사용자가 크기를 조절할 수 없게 한다.*/
    overflow: hidden; /*내용이 넘치면 숨긴다*/
}

.comment-btns{
    display: flex;

    justify-content: space-around;
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
    z-index: -1;
}

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

.btn-del {
    background: #7D9600;
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
    background: #dce3bc;
    transition: all 0.2s ease;
}

.btn-del:hover {
    color: #7D9600;
}

.btn-del:hover:after {
    left: 0;
    width: 100%;
}

.btn-del:active {
    top: 2px;
}
</style>