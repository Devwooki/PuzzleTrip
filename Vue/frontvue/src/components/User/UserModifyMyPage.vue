<template>
    <div>
        <h2>마이페이지 수정</h2>
        <img :src="imgSrc" width="50%">
        <br>
        <label for="profile"/> 프로필 이미지 선택
        <input name="profile" type="file" accept="image/jpeg, image/png, image/gif, .jpg" @change="onFileChange"/>

        <br>
        <br>
        <label for="name"/>이름 :
        <input id="name" name="name" type="text" v-model="name"/>

        <br>
        <label for="id"/>아이디 :
        <span id="id" name="id">{{checkUserInfo.id}}</span>
        <br>

        <button @click="isChangePw">비밀번호 변경</button>

        <div v-show="changePw">
            <label for="nowPw">현재 비밀번호:</label>
            <input :type="pwType" id="nowPw" name="nowPw" v-model="nowPw" @keyup="checkValidPw"/>
            {{message1}}

            <br>
            <div v-show="checkNowPw">
                <label for="newPw">새 비밀번호:</label>
                <input ref="newPw" :type="pwType" id="newPw" name="newPw" v-model="newPw" />
                <br>
                <label for="checkNewPw">새 비밀번호 확인:</label>
                <input :type="pwType" id="checkNewPw"  name="checkNewPw" v-model="checkNewPw" @keyup="checkValidNewPw"/>
                {{message2}}
            </div>


            <button @click="changePwType">비밀번호 표시</button>
        </div>



        <br>
        <label for="name">이메일:</label>
        <input id="email" name="email" type="text" v-model="email"/>

        <br>
        <button type="button" @click="updateUserInfo">업데이트</button>
        <router-link :to="{name : 'userMyPage'}">취소</router-link>
    </div>
</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";
import axios from "@/util/axios";

export default {
    name: "UserModifyMyPage",
    data() {
        return {
            changePw: false,
            checkNowPw : false,

            name : '',
            email : '',

            imgSrc : '',

            nowPw : '',
            newPw : '',
            checkNewPw : '',
            profileImg :{},

            pwType : 'password',
            showPw : false,
            message1 : '비밀번호가 일치하지 않습니다.',
            message2 : '새로운 비밀번호를 확인해주세요.',
        }
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
        onFileChange(event){
            this.profileImg = event.target.files
        },
        isChangePw() {
            this.changePw = !this.changePw;
        },
        changePwType(){
            this.showPw = !this.showPw;
            this.pwType = this.showPw ? 'text' : 'password';
        },
        async updateUserInfo() {
            this.userInfo.name = this.name
            this.userInfo.email = this.email

            if (this.checkNowPw) {
                this.userInfo.pw = this.newPw
            }

            const formData = new FormData();
            formData.append('id', this.userInfo.id);
            formData.append('pw', this.userInfo.pw);
            formData.append('name', this.userInfo.name);
            formData.append('email', this.userInfo.email);
            formData.append('files', this.profileImg[0])

            const response = await axios.put('user/modify', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            console.log("@@@유저 정보 업데이트")
            console.log(response.data)
            this.$store.commit('userStore/CHANGE_USER_INFO', response.data.userInfo)
            console.log(this.checkUserInfo)
            await this.$router.push({name: 'userMyPage'})
        },
        checkValidPw(event){
            if (this.nowPw === this.userInfo.pw) {
                this.message1 = '비밀번호가 일치합니다.';
                this.checkNowPw = true;
                event.target.setAttribute("readonly", true)
                this.$nextTick(() => {
                    this.$refs.newPw.focus();
                });
            } else {
                this.message1 = '비밀번호가 일치하지 않습니다.';
                this.checkNowPw = false;
            }
        },
        checkValidNewPw(){
            if (this.newPw === this.checkNewPw) {
                this.message2 = '';

            } else {
                this.message2 = '새로운 비밀번호를 확인해주세요.';
            }
        }
    },
    created(){
        this.name = this.userInfo.name
        this.email = this.userInfo.email
        this.imgSrc =`http://localhost:8989/profilePath/${this.userInfo.id}/${this.userInfo.profile.saveFile}`
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
</style>