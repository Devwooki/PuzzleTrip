<template>
    <div id="login-div">
        <label>아이디 저장?</label>
        <input type="checkbox" id="saveId" name="saveId" v-model="saveId" @change="removeUserIdCookie"/>
        <br>
        <label>아이디</label>
        <input type="text" id="userId" name="userId" v-model="userId"/>
        <br>
        <label>비밀번호</label>
        <input type="password" id="userId" name="userId" v-model="userPw"/>
        <br>
        <button id="loginBtn" @click="login">로그인</button>
    </div>
</template>

<script>

import {mapGetters} from "vuex";

export default {
    name: "UserLogin",
    data() {
        return {
            userId: "",
            userPw: "",
            saveId: "",
        }
    },
    computed :{
      ...mapGetters('userStore', ['getLoginResult'])
    },
    methods: {
        //https://zakelstorm.tistory.com/141 참고
        login() {
            this.$store.dispatch(`userStore/login`, {
                id: this.userId,
                pw: this.userPw,
            }).then(()=> {
                if(this.saveId) {
                    this.$cookies.set("userId", this.userId)
                    this.$cookies.set("saveId", this.saveId)
                }else{
                    this.removeUserIdCookie()
                }
            })

        },
        removeUserIdCookie(){
            console.log(this.saveId)
            if(!this.saveId){
                this.$cookies.remove("userId")
                this.$cookies.remove("saveId")
            }
        }
    },
    created(){
        //컴포넌트 생성시 쿠키 체크 해서 input창에 값을 지정한다.
        if(this.$cookies.get("saveId")){
            this.saveId = true;
            this.userId = this.$cookies.get("userId")
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