<template>
    <div class="myPageModify">
        <div class="container">
            <div class="img-align">
                <div class="img-container">
                    <div class="img-profile">
                        <img :src="imgSrc" alt="프로필 변경" @click="profileClick">
                    </div>
                    <input  name="profile" type="file" id="fileInput" accept="image/jpeg, image/png, image/gif, .jpg"
                           @change="onFileChange" style="display: none;"/>
                </div>
            </div>

            <div class="login-content">
                <form>
                    <h2 class="title">{{ checkUserInfo.name }}님의 정보</h2>
                    <div class="input-div one">
                        <div>ID :</div>
                        <div class="div">
                            <input class="div" id="id" name="id" type="text" v-model="id" readonly/>
                        </div>
                    </div>

                    <div class="input-div one">
                        <div>name :</div>
                        <div class="div">
                            <input ref="inputName"  class="div" id="email" name="email" type="text" v-model="name"/>
                        </div>
                    </div>

                    <div class="input-div one">
                        <div>Email :</div>
                        <div class="div">
                            <input ref="inputEmail" class="div" id="email" name="email" type="text" v-model="email"/>
                        </div>
                    </div>


                        <div class="input-div pass">
                            <div>Now PW :</div>
                            <div class="div">
                                <input ref="nowPw" :type="pwType" id="nowPw" name="nowPw" v-model="nowPw" @keyup="checkValidPw"/>
                            </div>
                            <span :class="checkNowPw ? 'blue-text' : 'red-text'">{{ message1 }}</span>
                        </div>

                        <div v-show="checkNowPw">
                            <div class="input-div pass">
                                <div>New PW :</div>
                                <div class="div">
                                    <input ref="newPw" :type="pwType" id="newPw" name="newPw" v-model="newPw" />
                                </div>
                            </div>
                            <div class="input-div pass">
                                <div>check PW :</div>
                                <div class="div">
                                    <input ref="checkNewPw" :type="pwType" id="checkNewPw" name="checkNewPw" v-model="checkNewPw"
                                           @keyup="checkValidNewPw"/>
                                </div>
                                <span :class="checkNewPwRes ? 'blue-text' : 'red-text'">{{ message2 }}</span>
                            </div>
                        </div>
                        <button type="button" @click="changePwType">비밀번호 표시</button>



                    <button class="btn"  type="button" @click="updateUserInfo">업데이트</button>
                    <router-link class="btn-delete" :to="{name : 'userMyPage'}">취소</router-link>
                </form>
            </div>
        </div>
    </div>

</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";
import myAxios from "@/util/axios";

export default {
    name: "UserModifyMyPage",
    data() {
        return {
            checkNowPw: false, //현재 비밀번호를 알아야 회원 변경 가능
            checkNewPwRes : false,
            imgSrc: '',
            id : '',
            name: '',
            email: '',
            nowPw: '',
            newPw: '',
            checkNewPw: '',
            profileImg: {},

            pwType: 'password',
            showPw: false,
            message1: '!',
            message2: '!',

        }
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
        profileClick(){
            let fileInput = document.querySelector("#fileInput");
            fileInput.click();
        },
        onFileChange(event) {
            this.profileImg = event.target.files
            this.imgSrc = URL.createObjectURL(event.target.files[0]);
        },
        changePwType() {
            this.showPw = !this.showPw;
            this.pwType = this.showPw ? 'text' : 'password';
        },
        async updateUserInfo() {
            if (this.checkNowPw) {

                const emailRegex = /^([a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)$/;
                const emailValid = emailRegex.test(this.email);

                if (this.name.trim() === '') {
                    alert('이름을 입력해주세요.');
                    this.$refs.inputName.focus();
                    return;
                } else if (this.email.trim() === '') {
                    alert('이메일을 입력해주세요.');
                    this.$refs.inputEmail.focus();
                    return;
                } else if (!emailValid) {
                    alert('이메일 형식이 올바르지 않습니다.');
                    this.$refs.inputEmail.focus();
                    return;
                }else{
                    const formData = new FormData();
                    formData.append('id', this.id);

                    if(this.checkNewPwRes){
                        formData.append('pw', this.newPw);
                    }else{
                        formData.append('pw', this.userInfo.pw);
                    }
                    formData.append('name', this.name);
                    formData.append('email', this.email);
                    formData.append('files', this.profileImg[0])

                    const response = await myAxios.put('user/modify', formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    })
                    console.log("@@@유저 정보 업데이트")
                    console.log(response.data)
                    this.$store.commit('userStore/CHANGE_USER_INFO', response.data.userInfo)
                    console.log(this.checkUserInfo)
                    await this.$router.push({name: 'userMyPage'})
                }


            }else{
                alert("비밀번호가 확인되어야 유저 정보 수정이 가능합니다.")
                this.$refs.nowPw.focus();
                return;
            }
        },
        checkValidPw(event) {
            if (this.nowPw === this.userInfo.pw) {
                this.message1 = 'V';
                this.checkNowPw = true;
                event.target.setAttribute("readonly", true)
                this.$nextTick(() => {
                    this.$refs.newPw.focus();
                });
            } else {
                this.message1 = '!';
                this.checkNowPw = false;
            }
        },
        checkValidNewPw() {
            if (this.newPw === this.checkNewPw) {
                this.checkNewPwRes = true;
                this.message2 = 'V';

            } else {
                this.checkNewPwRes = false;
                this.message2 = '!';

            }
        }
    },
    created() {
        this.id = this.userInfo.id
        this.name = this.userInfo.name
        this.email = this.userInfo.email

        if(this.userInfo.profile.saveFolder === null){
            this.imgSrc = `${process.env.VUE_APP_API_BASE_URL}/profilePath/${this.userInfo.profile.saveFile}`
        }else{
            this.imgSrc = `${process.env.VUE_APP_API_BASE_URL}/profilePath/userProfile/${this.userInfo.profile.saveFolder}/${this.userInfo.profile.saveFile}`
        }
    }
}
</script>

<style scoped>
* {
    margin: 5px;
}

input, button {
    border: 1.5px solid gray;
}


* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

.container {
    width: 100vw;
    height: 550px;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 2rem;
    padding: 0 2rem;
}

.img-align {
    display: flex;
    justify-content: flex-end;
}

.img-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    overflow: hidden;
}

.img-container .img-profile {
    width: 320px; /* 이미지 크기를 조정할 수 있습니다 */
    height: 320px; /* 이미지 크기를 조정할 수 있습니다 */
    border-radius: 50%;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    border : 2px solid black;
}

.img-container .img-profile img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.title {
    width: max-content;

}

.login-content {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    text-align: center;
}

form {
    width: 360px;
}

.login-content img {
    height: 100px;
}

.login-content h2 {
    margin: 15px auto;
    color: #333;
    text-transform: uppercase;
    font-size: 2.9rem;

}

.login-content .input-div {
    position: relative;
    display: grid;
    grid-template-columns: 15% 70% 15%;
    margin: 25px 0;
    padding: 5px 0;
    border-bottom: 2px solid #d9d9d9;
}

.login-content .input-div.one {
    margin-top: 0;
    margin-bottom: 0;
}

.input-div > div {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    height: 45px;
}

.input-div > div > input{
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    border: none;
    outline: none;
    background: none;
    padding: 0.5rem 0.7rem;
    font-size: 18px;
    color: #555;
}

.input-div:before, .input-div:after {
    content: '';
    position: absolute;
    bottom: -2px;
    width: 0%;
    height: 2px;
    background-color: #38d39f;
    transition: .4s;
}

.input-div:before {
    right: 50%;
}

.input-div:after {
    left: 50%;
}

.input-div.focus:before, .input-div.focus:after {
    width: 50%;
}

.input-div.focus > div > h5 {
    top: -5px;
    font-size: 15px;
}

.input-div.focus > .i > i {
    color: #38d39f;
}

.input-div.pass {
    margin-top: 0;
    margin-bottom: 0;
}

a {
    display: block;
    text-align: right;
    text-decoration: none;
    color: #999;
    font-size: 0.9rem;
    transition: .3s;
}

a:hover {
    color: #38d39f;
}

.btn {
    display: flex;
    width: 100%;
    height: 50px;
    border-radius: 25px;
    outline: none;
    border: none;
    background-image: linear-gradient(to right, #7D9600, #a4af6b, #758a0f);
    background-size: 200%;
    font-size: 1.2rem;
    color: #fff;
    text-transform: uppercase;
    margin: 1rem 0;
    cursor: pointer;
    transition: .5s;
    align-items: center;
    justify-content: center;
}

.btn:hover {
    background-position: right;
    justify-content: center;
    color: #fff;
}

.btn-delete {
    display: flex;
    width: 100%;
    height: 50px;
    border-radius: 25px;
    outline: none;
    border: none;
    background-image: linear-gradient(to right, #d96161, #BFA5A5, #ce6969);
    background-size: 200%;
    font-size: 1.2rem;
    color: #fff;
    text-transform: uppercase;
    margin: 1rem 0;
    cursor: pointer;
    transition: .5s;
    align-items: center;
    justify-content: center;
}

.btn-delete:hover {
    background-position: right;
    justify-content: center;
    color: #fff;
}

span {
    display : flex;
    align-items: center;
    font-size: 25px;
    font-weight: bold;
}
.red-text {
    color: #d96161;
    boarder : 1.5px solid #d96161;
}

.blue-text {
    color: #7D9600;
}

#fileInput{
    visibility: hidden;
}

img:hover{
    cursor : pointer;
}

</style>