<template>
    <div id="containerTop">
        <header>
            <div id="logoDiv">
                <router-link :to="{name: 'home'}">
                    <img :src="require('@/assets/logo.png')" alt="logo" id="mainLogo">
                </router-link>
            </div>
            <nav id="containerMid">
                <div id="userManu">
                    <router-link v-if="userInfo === null" :to="{name: 'userLogin'}">로그인</router-link>
                    <div class="userInfo" v-if="userInfo">
                        <router-link :to="{name : 'userMyPage'}" title="마이페이지로">{{ userInfo.name }}</router-link>
                        님 반갑습니다.
                        <br>
                        <a @click.prevent="logout">로그아웃</a>
                    </div>
                </div>
                <div id="mainManu">
                    <div class="button">
                        <p class="btnText">여행지</p>
                        <div class="btnTwo">
                            <router-link :to="{name: 'attraction'}">
                                <p class="btnText2">고르기</p>
                            </router-link>
                        </div>
                    </div>
                    <div class="button">
                        <p class="btnText">나만의</p>
                        <div class="btnTwo">
                            <router-link :to="{name: 'myPlace'}">
                                <p class="btnText2">여행지</p>
                            </router-link>
                        </div>
                    </div>
                    <div class="button">
                        <p class="btnText">우리의</p>
                        <div class="btnTwo">
                            <router-link :to="{name: 'hotPlace'}">
                                <p class="btnText2">여행지</p>
                            </router-link>
                        </div>
                    </div>
                    <div class="button">
                        <p class="btnText">게시판</p>
                        <div class="btnTwo">
                            <router-link :to="{name: 'board'}">
                                <p class="btnText2">구경하기</p>
                            </router-link>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </div>

</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";

export default {
    name: 'appHeader',
    components: {},
    data() {
        return {
            message: '',
            imgSrc: '',
        };
    },
    created() {
        // console.log("헤더 ㅎㅅㅎ")
        // if (this.userInfo.profile.saveFolder === null) {
        //     this.imgSrc = `http://localhost:8989/profilePath/${this.userInfo.profile.saveFile}`
        // } else {
        //     this.imgSrc = `http://localhost:8989/profilePath/${this.userInfo.profile.saveFolder}/${this.userInfo.profile.saveFile}`
        // }
        // console.log(this.imgSrc)
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
        logout() {
            console.log(this.checkUserInfo);
            //store에 있는 logout 실행
            this.userLogout()
            sessionStorage.removeItem("refreshToken");
            sessionStorage.removeItem("accessToken");
            this.$store.state["userStore/userInfo"] = null;
            this.imgSrc ='';
            //다른 페이지에서 로그아웃 누를 시 메인으로 이동
            if (this.$route.path != "/") this.$router.push({name: 'home'})
        }
    },
};
</script>

<style scoped>
.btn-gradient {
    text-decoration: none;
    color: white;
    display: inline-block;
    position: relative;
    border-radius: 4px;
}

.cyan {
    background-color: #7fccde;
    padding: 4px 12px;
    font-size: 12px;
}
.red {
    box-shadow:0px 4px 0px #E04342;
    padding: 4px 12px;
    font-size: 12px;
    margin-left: -20px;
}
.btn-gradient.cyan {
    background: rgba(27, 188, 194, 1);
    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(27, 188, 194, 1)), to(rgba(24, 163, 168, 1)));
    background: -webkit-linear-gradient(rgba(27, 188, 194, 1) 0%, rgba(24, 163, 168, 1) 100%);
    background: -moz-linear-gradient(rgba(27, 188, 194, 1) 0%, rgba(24, 163, 168, 1) 100%);
    background: -o-linear-gradient(rgba(27, 188, 194, 1) 0%, rgba(24, 163, 168, 1) 100%);
    background: linear-gradient(rgba(27, 188, 194, 1) 0%, rgba(24, 163, 168, 1) 100%);
}

.btn-gradient.red{
    background: rgba(250,90,90,1);
    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(250,90,90,1)), to(rgba(232,81,81,1)));
    background: -webkit-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: -moz-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: -o-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
}
#containerTop {
    display: flex;
    justify-content: center;
    height: 7.5rem;
}

#containerMid {
    width: 100%;
}

header {
    display: flex;
    background-color: #F3EED9;
}

#logoDiv {
    display: flex;
    align-items: center;
    margin-left: 300px;
}

#mainLogo {
    width: 56%;
}

/* 유져 메뉴 */

#userManu {
    display: flex;
    justify-content: flex-end;
    margin-top: 1rem;
    margin-right: 2rem;
}
#userManu *{
    text-align: end;
}

a {
    text-decoration: none;
    margin-right: 2rem;
    font-size: 15px;
    color: #919696;
}
.userInfo a{
    margin-right: 0;
}

p {
    text-decoration: none;
    font-size: 20px;
    color: #919696;
}

/* 메인 메뉴 */

#mainManu {
    display: flex;
    margin-left: 4rem;
    margin-top: 1rem;
}

/* 링크 효과 */

#userManu a:hover {
    color: #086ba8 !important;
}

div li {
    list-style: none;
}

/*메뉴 버튼 효과*/

.button {
    font-weight: 900;
    background: #F3EED9;
    margin-right: 3rem;
    width: 120px;
    height: 40px;
    text-align: center;
    overflow: hidden;
    transition: .2s;
    cursor: pointer;
    border-radius: 5px;
}

.btnTwo {
    position: relative;
    width: 120px;
    margin-top: -40px;
    padding-top: 2px;
    background: #7D9600;
    left: -150px;
    transition: .2s;
}

.btnText {
    color: #574141;
    transition: .2s;
    line-height: 40px;
}

.btnText2 {
    margin-top: 7px;
    color: #FFF;
}

.button:hover .btnTwo { /*When hovering over .button change .btnTwo*/
    left: 0;
}
.button:active { /*Clicked and held*/
    box-shadow: 0px 5px 6px rgba(0, 0, 0, 0.3);
}
</style>
<script setup>
</script>