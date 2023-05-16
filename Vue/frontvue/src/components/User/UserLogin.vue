<template>
  <div id="login-div">
      <label>아이디 저장?</label>
      <input type="checkbox" id="saveId" name="saveId" v-model="saveId"/>

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
import axios from "@/util/axios";
export default {
    name: "UserLogin",
    data(){
        return{
            userId : "",
            userPw : "",
            saveId : "",
        }
    },
    methods : {
        async login(){
            const response = axios.post(`user/login/${this.saveId}`,{
                id : this.userId,
                pw : this.userPw,
            });
            console.log(response.data)

            if(response.data != null)
                this.$router.push({name : 'home'})

        }
    }
}
</script>

<style scoped>
 * {
     border : 1px solid gainsboro;
 }
</style>