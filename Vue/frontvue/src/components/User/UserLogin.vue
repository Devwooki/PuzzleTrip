<template>
    <div id="login-div">
        <label>아이디 저장?</label>
        <input type="checkbox" id="saveId" name="saveId" v-model="saveId" @change="removeUserIdCookie"/>
        <br>
        <label>아이디</label>
        <input ref="inputId" type="text" id="userId" name="userId" v-model="user.id"/>
        <br>
        <label>비밀번호</label>
        <input ref="inputPw" type="password" id="userPw" name="userPw" v-model="user.pw"/>
        <br>
        <button id="loginBtn" @click="login">로그인</button>
        <br>
        <router-link :to="{name : 'findPw'}">비밀번호 찾기</router-link>
        <router-link :to="{name : 'regist'}">회원가입</router-link>
    </div>
</template>

<script>

import {mapActions, mapGetters} from "vuex";

export default {
    name: "UserLogin",
    data() {
        return {
            user : {
                id: "",
                pw: "",
            },
            saveId: "",
        }
    },
    computed: {
        ...mapGetters('userStore', ['getIsLogin', 'getIsLoginError', 'checkToken'])
    },
    methods: {
        ...mapActions('userStore', ['confirm', 'getUserInfo']),

        //https://zakelstorm.tistory.com/141 참고
        //로그인 : DB에접근해 유저 정보가 유효한지 체크 및
        //getUserInfo
        async login() {
            //로그인 결과 store에 저장
            //await this.$store.dispatch('userStore/login', this.user)
            await this.confirm(this.user)
            let token = sessionStorage.getItem("accessToken")

            //로그인 성공하면 쿠키정보도 저장한다.
            if(this.getIsLogin){
                await this.getUserInfo(token)
                if(this.saveId){
                    this.$cookies.set("saveId", this.saveId)
                    this.$cookies.set("userId", this.user.id)
                }
                await this.$router.push({name : "home"})
            }else{
                //로그인 실패할 경우 입력값을 초기화하고 focus를 위치시킨다.
                alert("아이디 혹은 비밀번호를 확인해 주세요.")
                this.user.id = ""
                this.user.pw = ""
                this.$refs.inputId.focus()
            }

        },
        removeUserIdCookie() {
            console.log(this.saveId)
            //체크를 해제하면 쿠키를 제거한다.
            if(!this.saveId){
                this.$cookies.remove("userId")
                this.$cookies.remove("saveId")
            }

        },
    },
    mounted() {
        //컴포넌트 생성시 쿠키 체크 해서 input창에 값을 지정한다
        //저장된 쿠키가 있으면 브라우저에 불러온다.
        if (this.$cookies.get("saveId")) {
            this.saveId = true;
            this.user.id = this.$cookies.get("userId")
            this.$refs.inputPw.focus()
        }else{
            this.saveId = false;
            this.$refs.inputId.focus()
        }
    }
}
</script>
<style scoped>
* {
    border: 1px solid gainsboro;
}

#login-div * {
    background-color: #919696;
    color: white;
}
</style>

