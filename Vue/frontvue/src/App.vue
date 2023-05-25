<template id="root">
    <div id="app">
        <div id="wrap">
            <header>
                <app-header id="header"></app-header>
            </header>
            <div id="contentWrap">
                <router-view id="main"></router-view>
                <app-chat class="chat-comp"></app-chat>
            </div>
        </div>
        <app-footer id="footer"></app-footer>
    </div>

</template>

<script>

import AppHeader from "@/views/layout/AppHeader.vue";
import AppFooter from "@/views/layout/AppFooter.vue";
import AppChat from "@/views/main/AppChat.vue";

export default {
    name: "App",
    components: {
        AppHeader, AppFooter, AppChat
    },
    created(){
        this.$store.commit('boardStore/RESET_BOARD_STORE')
        this.$store.commit('userStore/RESET_USER_STORE')
    }
};
</script>

<!--전역 스타일-->
<style>
@font-face {
    font-family: 'SEBANG_Gothic_Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2104@1.0/SEBANG_Gothic_Bold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
/* 스크롤바 설정*/
*::-webkit-scrollbar{
    width: 20px;
}
/* 스크롤바 막대 설정*/
*::-webkit-scrollbar-thumb{
    background-color: #8bb9eb;
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;
    border: 7px solid #FFFFFF;
}

html {
    font-family: 'SEBANG_Gothic_Bold';
    margin: 0;
    padding: 0;
    height: 100%;
}

body {
    margin: 0;
}
</style>

<!--지역스타일-->
<style scoped>


header {
    height: 110px;
    display: flex;
    justify-content: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 3;
}

#contentWrap {
    margin-top: 110px;
}

#header {
    width: 100%;
}

#wrap {
    min-height: 100%;
    position: relative;
}

#main {
    padding: 0;
    margin-top: 1rem;
    min-height: 650px;
}

#footer {
    position: relative;
(absolute - > relative) transform: translatY(- 100 %);
    height: 5rem;
}

.chat-comp{
    position: absolute;
    z-index: 1000;
    right : 10px;
    bottom: 10px;
}

</style>