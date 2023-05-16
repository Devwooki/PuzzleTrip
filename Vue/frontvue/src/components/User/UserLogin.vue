<template>
  <div>
      <label>아이디 저장?</label>
      <input type="checkbox" id="saveId" name="saveId" v-model="saveId"/>

      <label>아이디</label>
      <input type="text" id="userId" name="userId" v-model="userId"/>
      <br>
      <label>비밀번호</label>
      <input type="password" id="userId" name="userId" v-model="userPw"/>
      <br>
      <button id="loginBtn" @click="login">등록</button>
  </div>
</template>

<script>
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
        login(){
            // console.log(this.userId)
            // console.log(this.userPw)
            // console.log(this.saveId)

            const sendData = {
                id : this.userId,
                pw : this.userPw,
                saveId : this.saveId,
            }

            fetch("http://localhost:8989/user/login/" + this.saveId,{
                method : 'POST',
                headers :{
                    'Content-Type' : 'application/json'
                },
                body : JSON.stringify(sendData),
            }).then(response => response.json())
                .then(data => {
                    console.log(data);
                    //alert(this.userId + "님 환영합니다.")
                })

        }
    }
}
</script>

<style scoped>

</style>