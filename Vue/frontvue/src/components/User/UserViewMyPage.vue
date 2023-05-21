<template>
    <div>
        <h2>마이페이지 </h2>
        <img :src="imgSrc" width="50%">
        <br>
        <br>
        <label for="name"/>이름 : {{checkUserInfo.name}}
        <br>
        <label for="id"/>아이디 : {{ checkUserInfo.id }}
        <br>
        <label for="email"/>이메일: {{ checkUserInfo.email }}
        <br>
        <router-link :to="{name : 'userModify'}">수정</router-link>
        <button type="button">탈퇴</button>

        <br>
        <user-like></user-like>
    </div>

</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";
import UserLike from "@/components/User/UserLike.vue";

export default {
    components: {UserLike},
    data() {
        return {
            imgSrc : '',
        }
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),

    },
    created() {
        console.log("@@@마이페이지 접속")
        console.log(this.userInfo)
        this.imgSrc =`http://localhost:8989/profilePath/${this.userInfo.profile.saveFolder}/${this.userInfo.profile.saveFile}`
    }
}
</script>

<style scoped>
*{
    margin : 5px;
}
</style>