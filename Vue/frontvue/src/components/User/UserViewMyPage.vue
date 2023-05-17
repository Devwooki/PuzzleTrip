<template>
    <div>
        <h2>마이페이지 접근</h2>
        <label for="name"/>이름 :
        <input id="name" name="name" type="text"/>
        <br>
        <label for="id"/>아이디 :
        <input id="id" name="id" type="text" readonly/>
        <br>

        <label>
            비밀번호 변경
            <input type="checkbox" id="changePwTg" v-model="changePw" @change="isChangePw">
        </label>

        <div v-if="changePw">
            <div v-for="(inputField, index) in inputFields" :key="index">
                <label v-if="index === 0" for="nowPw">현재 비밀번호:</label>
                <label v-else-if="index === 1" for="newPw">새 비밀번호:</label>
                <label v-else for="checkNewPw">새 비밀번호 확인:</label>
                <input :type="inputField.type" :id="inputField.id" :name="inputField.name" v-model="inputField.value" :readonly="inputField.readonly" @keyup="handleKeyUp(index)" />
            </div>
        </div>


        <br>
        <label for="name">이메일:</label>
        <input id="email" name="email" type="text"/>@
        <input id="emailDomain" name="emailDomain" type="text"/>
        <select id="select-domain">
            <option value="0" selected>도메인 선택</option>
            <option value="naver.com">네이버</option>
            <option value="duam.net">다음</option>
            <option value="gmail.com">Gmail</option>
            <option value="self">직접입력..</option>
        </select>

        <br>
        <button type="button">수정</button>
        <button type="button">탈퇴</button>
    </div>
</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";

export default {
    name: "UserViewMyPage",
    data() {
        return {
            changePw: false,
            inputFields: [
                { type: 'password', id: 'nowPw', name: 'nowPw', value: '', showPassword: false, isReadOnly : false },
                { type: 'password', id: 'newPw', name: 'newPw', value: '', showPassword: false, isReadOnly : false},
                { type: 'password', id: 'checkNewPw', name: 'checkNewPw', value: '', showPassword: false, isReadOnly : false},
            ],
        }
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
        isChangePw() {
            console.log(this.changePw)
        },
        checkNowPw() {
            if(this.nowPw===this.checkUserInfo.pw){
                this.isReadOnly = true;
            }
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
</style>