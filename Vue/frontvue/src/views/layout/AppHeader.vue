<template>
  <div id="containerTop">
    <header>
      <div id="logoDiv">
        <router-link :to="{name: 'home'}"><img :src="require('@/assets/logo.png')" alt="logo" id="mainLogo"></router-link>
      </div>
      <nav id="containerMid">
        <div id="userManu">
          <router-link v-if="userInfo === null" :to="{name: 'login'}">로그인</router-link>
            <div v-if="userInfo">
                <router-link :to="{name : 'myPage'}" title="마이페이지로">{{userInfo.name}}</router-link>님 반갑습니다.
                <a @click.prevent="logout">로그아웃</a>
            </div>

        </div>
        <div id="mainManu">
          <router-link :to="{name: 'attraction'}">여행지</router-link>
          <router-link :to="{name: 'myPlace'}">나의 여행지</router-link>
          <router-link :to="{name: 'hotPlace'}">핫플레이스</router-link>
          <router-link :to="{name: 'board'}">게시판</router-link>
          <router-link :to="{name: 'test'}">테스트</router-link>
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
        };
    },
    created() {
    },
    computed :{
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore',["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
        logout(){
            console.log(this.checkUserInfo);

            //store에 있는 logout 실행
            this.userLogout()
            sessionStorage.removeItem("refreshToken");
            sessionStorage.removeItem("accessToken");

            //다른 페이지에서 로그아웃 누를 시 메인으로 이동
            if(this.$route.path != "/") this.$router.push({name : 'home'})
        }
    },
};
</script>

<style scoped>
#containerTop {
    display: flex;
    justify-content: center;
    height: 7.5rem;
}

#containerMid {
    width: 100%;
}

header {
    margin: 0 20px;
    display: flex;
}

#logoDiv {
    display: flex;
    align-items: center;
}

#mainLogo {
    width: 40%;
}

/* 유져 메뉴 */
#userManu {
    display: flex;
    justify-content: flex-end;
    margin-top: 1rem;
    margin-right: 2rem;
}

#userManu a {
    text-decoration: none;
    margin-right: 2rem;
    font-size: 1rem;
    color: #919696;
}

/* 메인 메뉴 */
#mainManu {
    display: flex;
    margin-left: 3rem;
    margin-top: 1rem;
}

#mainManu a {
    margin-right: 5rem;
    color: #000000;
    text-decoration: none;
    font-size: 1rem;
    font-weight: 600;
}
/* 링크 효과 */
#mainManu a:hover  {
    color: #b98918 !important;
}
#userManu a:hover  {
    color: #086ba8 !important;
}
div li {
    list-style: none;
}
</style>

