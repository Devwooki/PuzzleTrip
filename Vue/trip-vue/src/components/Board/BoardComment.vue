<template>
    <div>
        <h4>댓글입니다.</h4>
        <table>
            <board-comment-list v-for="comment in comments" :key="comment.no" :comment="comment"></board-comment-list>
        </table>
        <textarea v-model="content">
        </textarea>
        <button @click="writeComment">등록</button>
        <button @click="removeContent">지우기</button>
    </div>
</template>

<script>
import BoardCommentList from "@/components/Board/BoardCommentList.vue";
export default {
    name: 'BoardComment',
    props :{
        boardType : Number,
        boardNo : Number
    },
    components: {
        BoardCommentList
    },
    data() {
        return {
            userId : 'ssafy',
            content : '',
            comments : []
        };
    },
    created() {
        fetch("http://localhost:8989/comment/" + this.boardType + "/" + this.boardNo)
            .then((response) => response.json())
            .then((data) => {
                this.comments= data;
                console.log(data)
            });
    },
    methods: {
        writeComment(){
            const sendData ={
                userId : this.userId,
                content : this.content,
                boardType : this.boardType,
                boardNo : this.boardNo,
            }

            fetch("http://localhost:8989/comment/" + this.boardType + "/" + this.boardNo, {
                    headers :{
                        'Content-Type' : 'application/json'
                    },
                    method : 'POST',
                    body : JSON.stringify(sendData)
                })
                .then((response) => response.json())
                .then((data) => {
                    this.comments= data;
                    this.content=''
                    console.log(data)
                });
        },
        removeContent(){
            this.content = ''
        },
    },
};
</script>

<style scoped></style>