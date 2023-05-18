<template>
    <div id="login-div">
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="#">
                    <h1>회원가입</h1>
                    <span>사용하시는 이메일을 입력해주세요.</span>
                    <input type="text" placeholder="Name"/>
                    <input type="email" placeholder="ID"/>
                    <input type="password" placeholder="Password"/>
                    <button type="button">Sign Up</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="#">
                    <h1>로그인</h1>
                    <span>가입하신 정보를 입력해주세요.</span>
                    <input ref="inputId" type="email"  placeholder="ID" id="userId" name="userId" v-model="user.id"/>
                    <input ref="inputPw" type="password" placeholder="Password" id="userPw" name="userPw" v-model="user.pw"/>
                    <div class="saveId">
                        <span class="saveIdSpan">아이디 저장</span>
                        <input type="checkbox" id="saveId" name="saveId" v-model="saveId"/>
                    </div>
                    <router-link :to="{name : 'findPw'}">비밀번호를 잊어버리셨나요?</router-link>
                    <button type="button" id="loginBtn" @click="login">로그인</button>
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>반가워요!</h1>
                        <p>저희 Puzzle Trip과 여행을 떠나볼까요?</p>
                        <button class="ghost" id="signIn" >로그인하러 가기</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>오랜만이에요!</h1>
                        <p>오늘은 어디로 떠나실 계획이신가요?</p>
                        <button class="ghost" id="signUp">가입하러 가기</button>
                    </div>
                </div>
            </div>
        </div>
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
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');

        signUpButton.addEventListener('click', () => {
            container.classList.add("right-panel-active");
        });

        signInButton.addEventListener('click', () => {
            container.classList.remove("right-panel-active");
        });
    }
}

</script>
<style scoped>
/*내가 바꾼거 */
.saveId {
    display: flex;
}

.saveIdSpan {
    width: 70px;
    line-height: 28px;
}

#saveId {
    padding: 0;
    width: 20px;
}
#login-div {
    margin-top: 200px;
}
/*내가 바꾼거 끝*/


* {
    box-sizing: border-box;
}

h1 {
    font-weight: bold;
    margin: 0;
}

h2 {
    text-align: center;
}

p {
    font-size: 14px;
    font-weight: 100;
    line-height: 20px;
    letter-spacing: 0.5px;
    margin: 20px 0 30px;
}

span {
    font-size: 12px;
}

a {
    color: #333;
    font-size: 14px;
    text-decoration: none;
    margin: 15px 0;
}

button {
    border-radius: 20px;
    border: 1px solid #7D9600;
    background-color: #7D9600;
    color: #FFFFFF;
    font-size: 12px;
    font-weight: bold;
    padding: 12px 45px;
    letter-spacing: 1px;
    text-transform: uppercase;
    transition: transform 80ms ease-in;
}

button:active {
    transform: scale(0.95);
}

button:focus {
    outline: none;
}

button.ghost {
    background-color: transparent;
    border-color: #FFFFFF;
}

form {
    background-color: #FFFFFF;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    padding: 0 50px;
    height: 100%;
    text-align: center;
}

input {
    background-color: #eee;
    border: none;
    padding: 12px 15px;
    margin: 8px 0;
    width: 100%;
}

.container {
    background-color: #fff;
    border-radius: 10px;
    position: relative;
    overflow: hidden;
    width: 768px;
    max-width: 100%;
    min-height: 480px;
}

.form-container {
    position: absolute;
    top: 0;
    height: 100%;
    transition: all 0.6s ease-in-out;
    color: #ACAC9A;
}

.sign-in-container {
    left: 0;
    width: 50%;
    z-index: 2;
}

.container.right-panel-active .sign-in-container {
    transform: translateX(100%);
}

.sign-up-container {
    left: 0;
    width: 50%;
    opacity: 0;
    z-index: 1;
}

.container.right-panel-active .sign-up-container {
    transform: translateX(100%);
    opacity: 1;
    z-index: 5;
    animation: show 0.6s;
}

@keyframes show {
    0%, 49.99% {
        opacity: 0;
        z-index: 1;
    }

    50%, 100% {
        opacity: 1;
        z-index: 5;
    }
}

.overlay-container {
    position: absolute;
    top: 0;
    left: 50%;
    width: 50%;
    height: 100%;
    overflow: hidden;
    transition: transform 0.6s ease-in-out;
    z-index: 100;
}

.container.right-panel-active .overlay-container {
    transform: translateX(-100%);
}

.overlay {
    background: #ACAC9A;
    background: -webkit-linear-gradient(to right, #BFA5A5, #ACAC9A);
    background: linear-gradient(to right, #BFA5A5, #ACAC9A);
    background-repeat: no-repeat;
    background-size: cover;
    background-position: 0 0;
    color: #FFFFFF;
    position: relative;
    left: -100%;
    height: 100%;
    width: 200%;
    transform: translateX(0);
    transition: transform 0.6s ease-in-out;
}

.container.right-panel-active .overlay {
    transform: translateX(50%);
}

.overlay-panel {
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    padding: 0 40px;
    text-align: center;
    top: 0;
    height: 100%;
    width: 50%;
    transform: translateX(0);
    transition: transform 0.6s ease-in-out;
}

.overlay-left {
    transform: translateX(-20%);
}

.container.right-panel-active .overlay-left {
    transform: translateX(0);
}

.overlay-right {
    right: 0;
    transform: translateX(0);
}

.container.right-panel-active .overlay-right {
    transform: translateX(20%);
}

.social-container a {
    border: 1px solid #DDDDDD;
    border-radius: 50%;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    margin: 0 5px;
    height: 40px;
    width: 40px;
}
</style>
