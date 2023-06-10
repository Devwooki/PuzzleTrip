//쿠키 생성을 위해 설치하는 라이브러리
//npm i vue-cookies
//https://www.npmjs.com/package/vue-cookie
//jwt토큰 decode를 위한 라이브럴
//npm i jwt-decode
import jwtDecode from 'jwt-decode';
import myAxios from "@/util/axios";
import router from "@/router";

const userStore = {
    namespaced: true,
    state: { //Vue의 data 역할, application에서 공유해야할 data
        isLogin: false,
        isLoginError: false,
        userInfo: null,
        isValidToken: false,
        userBoardLike: null,
    },
    getters: { //state의 값을 vueComponent에 전달해주는 역할
        checkToken(state) {
            return state.isValidToken;
        },
        checkUserInfo(state) {
            return state.userInfo
        },
        getIsLogin(state) {
            return state.isLogin
        },
        getIsLoginError(state) {
            return state.isLoginError
        },
    },
    mutations: {//state 값을 변경하기 위해 사용하는것 -> 직접호출은 불가하고 commit('정의된 이름')으로 호출
        //서버 재 실행 마다 state 초기화
        RESET_USER_STORE(state) {
            state.sLogin = false;
            state.isLoginError = false;
            state.userInfo = null;
            state.isValidToken = false;
        },
        SET_IS_LOGIN(state, isLogin) {
            state.isLogin = isLogin;
        },
        SET_IS_LOGIN_ERROR(state, isLoginError) {
            state.isLoginError = isLoginError;
        },
        SET_IS_VALID_TOKEN(state, isValidToken) {
            state.isValidToken = isValidToken;
        },
        SET_USER_INFO(state, userInfo) {
            state.isLogin = true;
            state.userInfo = userInfo;
            //JWT혹은 OAuth에서 사용하는 인증타입 Bearer
            //axios header에 토큰을 default값으로 추가해준다.
            // axios.defaults.headers.common['authToken'] = `Bearer ${data.userInfo.accesssToken}`
        },
        CHANGE_USER_INFO(state, userInfo) {
            state.userInfo = userInfo;
        }
    },
    actions: { //비동기 작업 결과를 적용할 떄 사용한다
        // commit : 현재 store의 뮤테이션을 호출하는 객체, 해당 뮤테이션을 통해 state변경 가능
        // state : store에 저장된 상태 객체
        async confirm({commit}, loginData) {
            await myAxios.post(`user/login`, loginData)
                //성공
                .then(({data}) => {
                    /*
                    data :{
                        accessToken :
                        message :
                        refreshToken :
                    }*/
                    console.log(data)
                    if (data.message === "success") {
                        let accessToken = data.accessToken
                        let refreshToken = data.refreshToken
                        console.log("login success token created!!!! >> ", accessToken, refreshToken);
                        commit("SET_IS_LOGIN", true);
                        commit("SET_IS_LOGIN_ERROR", false);
                        commit("SET_IS_VALID_TOKEN", true);
                        sessionStorage.setItem("accessToken", accessToken);
                        sessionStorage.setItem("refreshToken", refreshToken);
                    } else {
                        commit("SET_IS_LOGIN", false);
                        commit("SET_IS_LOGIN_ERROR", true);
                        commit("SET_IS_VALID_TOKEN", false);
                    }
                    //실패
                }).catch(async (error) => {
                    console.log("getUserInfo() error code [토큰 만료되어 사용 불가능.] ::: ", error.response.status);
                    commit("SET_IS_VALID_TOKEN", false);
                    //await dispatch("tokenRegeneration");
                })
        },
        async getUserInfo({commit, dispatch}, token) {
            let decodeToken = jwtDecode(token)
            /*decodeToken :{
                sub : 토큰 이름
                userId :
            }*/
            myAxios.defaults.headers["accessToken"] = sessionStorage.getItem("accessToken")
            await myAxios.get(`user/info/${decodeToken.userId}`)
                .then(({data}) => {
                    if (data.message === "success") {
                        commit("SET_USER_INFO", data.userInfo);
                        console.log(data)
                    } else {
                        console.log("해당 토큰과 일치하는 유저정보 없음");
                    }
                })
                .catch(async (error) => {
                    //AccessToken이 만료되어 토큰 재생성 해야함
                    console.log("getUserInfo() error code [토큰 만료되어 사용 불가능.] ::: ", error.response.status);
                    commit("SET_IS_VALID_TOKEN", false);
                    await dispatch("tokenRegeneration");
                })
            console.log("getUserInfo 종료")
        },

        async tokenRegeneration({commit, state}) {
            console.log(" {}", sessionStorage.getItem("accessToken"))
            console.log("기존토큰 만료로 새로운 access토큰을 발급합니다...")

            //access토큰 재발급 위해 refresh토큰을 전송한다.
            myAxios.defaults.headers["refreshToken"] = sessionStorage.getItem("refreshToken")
            await myAxios.post('user/refresh', JSON.stringify(state.userInfo))
                .then(({data}) => {
                    if (data.message === "success") {
                        console.log("accessToken 재발급 완료")
                        sessionStorage.setItem("accessToken", data.accessToken);
                        commit('SET_IS_VALID_TOKEN', true)
                    }
                })
                .catch(async (error) => {
                    //실패했거나, status가 401일 떄 : 토큰 발급 실패한 것
                    if (error.message === "fail" || error.response.status === 401) {
                        console.log("토큰 갱신 실패")

                        //refreshToken으로 갱신이 실패하면 2가지 경우가 존재
                        // 1. refreshToken의 만료 -> 재발급을 위해 로그아웃 수행
                        // 2. 토큰의 유효성이 증명되지 않았으므로 로그아웃을 수행해야한다.
                        await myAxios.get(`user/logout/${state.userInfo.id}`)
                            .then(({data}) => {
                                if (data.message === "success") {
                                    console.log("리프레시 토큰 제거")
                                } else {
                                    console.log("리프레시 토큰 제거 실패ㅠ")
                                }
                                alert("로그인 세션이 만료되었습니다. 다시 로그인 해주세요.")
                                commit('SET_IS_LOGIN', false);
                                commit('SET_IS_VALID_TOKEN', false)
                                commit('SET_USER_INFO', null)

                                //this.$router.push({name : 'login'})
                                //store에서도 사용 가능하지만
                                // Vuex에서는 router객체 참조하지 않고 직접이동하는걸 권장
                                router.push({name: 'login'})
                            })
                            .catch((error) => {
                                console.log(error);
                                commit("SET_IS_LOGIN", false);
                                commit("SET_USER_INFO", null);
                            })
                    }
                })
        },

        async userLogout({commit}, userId) {
            await myAxios.get(`user/logout/${userId}`)
                .then(({data}) => {
                    if (data.message === "success") {
                        commit('SET_IS_LOGIN', false);
                        commit('SET_IS_VALID_TOKEN', false)
                        commit('SET_USER_INFO', null)
                    } else {
                        console.log("유저 정보가 없습니다.")
                    }
                })
                .catch((error) => console.log(error))
        }
    },
};

export default userStore;
