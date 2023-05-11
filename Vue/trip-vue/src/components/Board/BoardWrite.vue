<template>
    <div>
        {{boardType}}번 게시판에 {{message}}
        <label for="title"/> 제목
        <input id="title" name="title" v-model="title"/>
        <label for="content"/> 제목
        <textarea id="content" name="content" v-model="content"/>
        <label for="content"/> 파일 업로드
        <textarea id="content" name="content" v-model="content"/>
    </div>
</template>

<script>
export default {
    name: 'BoardWrite',
    components: {},
    data() {
        return {
            //유저 아이디는 state에서 받아서 저장, JWT
            title : '',
            message: '글쓰기',
            boardType : -1,
        };
    },
    created() {
        this.boardType = this.$route.params.boardType;
    },
    methods: {},
};
</script>

<style scoped></style>
