<template>
    <div id="login-div">
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="#">
                    <h1>회원가입</h1>
                    <input ref="regId" type="text" placeholder="ID" v-model="registerInfo.id" @keyup="checkDuplId"/>
                    <span :class="checkDuplIdRes ? 'blue-text' : 'red-text'">{{ checkDuplIdResMessage }}</span>
                    <input ref="regPw" :type="pwType" placeholder="Password" v-model="registerInfo.pw"/>
                    <input ref="regCheckPw" :type="pwType" placeholder="Check Password" v-model="registerInfo.checkPw"
                           @keyup="checkSamePw"/>
                    <span class="result"> <span @click="changePwType">비밀번호 보기</span> <span
                            :class="checkSamePwRes ? 'blue-text' : 'red-text'">{{ checkSamePwResMessage }}</span></span>

                    <input ref="regName" type="text" placeholder="Name" v-model="registerInfo.name"/>
                    <input ref="regEmail" type="email" placeholder="Email" v-model="registerInfo.email"/>

                    <!-- 이메일 인증은 추후 진행
                    <button type="button" @click="sendIsValid">본인 인증</button>
                    <input type="text" v-if="showInput" placeholder="인증번호 입력" v-model="inputNum" @Input="checkVaildEmail">
                    -->

                    <span>프로필 이미지를 선택해 주세요.</span>
                    <div class="img-align">
                        <div class="img-container">
                            <div class="img-profile">
                                <img :src="imgSrc" alt="프로필 변경" @click="profileClick">
                            </div>
                            <input  name="profile" type="file" id="fileInput" accept="image/jpeg, image/png, image/gif, .jpg"
                                    @change="onFileChange" style="display: none;"/>
                        </div>
                    </div>
                    <button type="button" id="signUpBtn" @click="signUp">Sign Up</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="#">
                    <h1>로그인</h1>
                    <span>가입하신 정보를 입력해주세요.</span>
                    <input ref="inputId" type="email" placeholder="ID" id="userId" name="userId" v-model="user.id"/>
                    <input ref="inputPw" type="password" placeholder="Password" id="userPw" name="userPw"
                           v-model="user.pw"/>
                    <div class="saveId">
                        <span class="saveIdSpan">아이디 저장</span>
                        <input type="checkbox" id="saveId" name="saveId" v-model="saveId" @change="removeUserIdCookie"/>
                    </div>
                    <!--                    <router-link :to="{name : 'findPw'}">비밀번호를 잊어버리셨나요?</router-link>-->
                    <button type="button" id="loginBtn" @click="signIn">Sign in</button>
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>반가워요!</h1>
                        <p>저희 Puzzle Trip과 여행을 떠나볼까요?</p>
                        <button class="ghost" id="signIn">로그인하러 가기</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>오랜만이에요!</h1>
                        <p>오늘은 어디로 떠나실 계획이신가요?</p>
                        <p>혹시 계정이 없으신가요?</p>
                        <button class="ghost" id="signUp">가입하러 가기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


</template>

<script>
import {mapActions, mapGetters} from "vuex";
import axios from "@/util/axios";
// import axios from "@/util/axios";

export default {
    name: "UserLogin",
    data() {
        return {
            //회원가입을 위한 요소
            registerInfo: {
                id: '',
                pw: '',
                checkPw: '',
                name: '',
                email: '',
                profileImg: {},
            },
            pwType: "password",
            checkDuplIdRes: false,
            checkDuplIdResMessage: "사용 불가능한 아이디 입니다.",
            checkSamePwRes: false,
            checkSamePwResMessage: "  ",
            imgSrc : '',

            //로그인 위한 요소
            user: {
                id: '',
                pw: '',
            },
            saveId: "",
            registSuccess: false,


            // 이메일 인증을 위한 변수
            // showInput : false,
            // inputNum : '',
            // checkNum : false,
        }
    },
    computed: {
        ...mapGetters('userStore', ['getIsLogin', 'getIsLoginError', 'checkToken'])
    },
    methods: {
        ...mapActions('userStore', ['confirm', 'getUserInfo']),
        profileClick(){
            let fileInput = document.querySelector("#fileInput");
            fileInput.click();
        },
        changePwType() {
            this.showPw = !this.showPw;
            this.pwType = this.showPw ? 'text' : 'password';
            console.log(this.pwType)
        },
        onFileChange(event) {
            this.registerInfo.profileImg = event.target.files;

            this.profileImg = event.target.files
            this.imgSrc = URL.createObjectURL(event.target.files[0]);
            console.log(this.files);
        },

        //https://zakelstorm.tistory.com/141 참고
        //로그인 : DB에접근해 유저 정보가 유효한지 체크 및
        //getUserInfo
        async signIn() {
            //로그인 결과 store에 저장
            //await this.$store.dispatch('userStore/login', this.user)
            await this.confirm(this.user)
            let token = sessionStorage.getItem("accessToken")

            //로그인 성공하면 쿠키정보도 저장한다.
            if (this.getIsLogin) {
                await this.getUserInfo(token)

                if (this.saveId) {
                    this.$cookies.set("saveId", this.saveId)
                    this.$cookies.set("userId", this.user.id)
                }
                console.log("router push 전")
                this.$router.push({name: 'home'})
                console.log("router push 후")
            } else {
                //로그인 실패할 경우 입력값을 초기화하고 focus를 위치시킨다.
                alert("아이디 혹은 비밀번호를 확인해 주세요.")
                this.user.id = ""
                this.user.pw = ""
                this.$refs.inputId.focus()
            }
        },
        async signUp() {
            const emailRegex = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)$/;
            const emailValid = emailRegex.test(this.registerInfo.email);

            if (this.registerInfo.id.trim() === '') {
                this.registSuccess = false;
                alert('아이디를 입력해주세요.');
                this.$refs.regId.focus();
                return;
            } else if (this.registerInfo.name.trim() === '') {
                this.registSuccess = false;
                alert('이름을 입력해주세요.');
                this.$refs.regName.focus();
                return;
            } else if (this.registerInfo.pw.trim() === '') {
                alert('비밀번호를 입력해주세요.');
                this.$refs.regPw.focus();
                return;
            } else if (this.registerInfo.pw.trim() !== this.registerInfo.checkPw.trim()) {
                this.registSuccess = false;
                alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                this.$refs.regCheckPw.focus();
                return;
            } else if (this.registerInfo.email.trim() === '') {
                this.registSuccess = false;
                alert('이메일을 입력해주세요.');
                this.$refs.regEmail.focus();
                return;
            } else if (!emailValid) {
                this.registSuccess = false;
                alert('이메일 형식이 올바르지 않습니다.');
                this.$refs.regEmail.focus();
                return;
            } else {
                document.getElementById('container').classList.add("right-panel-active");
                const formData = new FormData();
                formData.append('id', this.registerInfo.id);
                formData.append('pw', this.registerInfo.pw);
                formData.append('name', this.registerInfo.name);
                formData.append('email', this.registerInfo.email);
                formData.append('files', this.registerInfo.profileImg[0])

                await axios.post(`user/regist`, formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                this.user.id = this.registerInfo.id
                this.$refs.inputPw.focus();

            }

        },
        async checkDuplId() {
            const response = await axios.get(`user/idCheck/${this.registerInfo.id}`);
            console.log("로그인 체크")
            console.log(response.data)
            if (response.data === "") {
                this.checkDuplIdResMessage = "사용 가능한 아아디 입니다.";
                this.checkDuplIdRes = true;
            } else {
                this.checkDuplIdResMessage = "사용 불가능한 아아디 입니다.";
                this.checkDuplIdRes = false;
            }
        },
        checkSamePw() {
            if (this.registerInfo.pw === this.registerInfo.checkPw) {
                this.checkSamePwResMessage = "일치합니다."
                this.checkSamePwRes = true;
            } else {
                this.checkSamePwResMessage = "일치하지 않습니다."
                this.checkSamePwRes = false;
            }
        },
        removeUserIdCookie() {
            console.log(this.saveId)
            //체크를 해제하면 쿠키를 제거한다.
            if (!this.saveId) {
                this.$cookies.remove("userId")
                this.$cookies.remove("saveId")
            }
        },

    },


    mounted() {
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');

        //임시 이동
        const signUpBtn = document.getElementById('signUpBtn')
        signUpBtn.addEventListener('click', () => {
            if (this.registSuccess) {
                document.getElementById('container').classList.remove("right-panel-active");
            }
        });

        signUpButton.addEventListener('click', () => {
            container.classList.add("right-panel-active");
        });

        signInButton.addEventListener('click', () => {
            container.classList.remove("right-panel-active");
        });
    },
    created() {
        console.log(process.env)
        this.imgSrc = `http://localhost:8989/profilePath/noimage.png`
        //console.log(process.env.VUE_APP_KAKAO_KEY)
        //컴포넌트 생성시 쿠키 체크 해서 input창에 값을 지정한다
        //저장된 쿠키가 있으면 브라우저에 불러온다.
        if (this.$cookies.get("saveId")) {
            this.saveId = true;
            this.user.id = this.$cookies.get("userId")
            this.$refs.inputPw.focus()
        } else {
            this.saveId = false;
            this.$refs.inputId.focus()
        }
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
//transform: scale(0.95); position: relative;
    top: 2px;
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

.result {
    display: flex;
    width: 100%;
    justify-content: space-between;
}

.result > *:first-child {
    justify-self: flex-start;
}

.result > *:last-child {
    justify-self: flex-end;
}

input {
    background-color: #eee;
    border: none;
    padding: 12px 15px;
    margin: 4px 0;
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

.red-text {
    color: #d96161;
}

.blue-text {
    color: #7D9600;
}


.img-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
    overflow: hidden;

}

#fileInput{
    width : 70%;
}

.img-container :nth-child(1) {
    flex: 1;
}

.img-container :nth-child(3) {
    flex: 2;
}

.img-container .img-profile {
    width: 60px; /* 이미지 크기를 조정할 수 있습니다 */
    height: 60px; /* 이미지 크기를 조정할 수 있습니다 */
    border-radius: 50%;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    border : 2px solid black;
    margin: 4px 0;
}

.img-container .img-profile img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

#fileInput{
    visibility: hidden;
}

img:hover{
    cursor : pointer;
}
</style>
