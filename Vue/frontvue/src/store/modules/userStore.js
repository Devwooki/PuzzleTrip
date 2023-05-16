//쿠키 생성을 위해 설치하는 라이브러리
//npm i vue-cookies
//https://www.npmjs.com/package/vue-cookie

import axios from "@/util/axios";

const userStore = {
    namespaced: true,
    state: { //Vue의 data 역할, application에서 공유해야할 data
        loginResult : null,
    },
    getters: { //state의 값을 vueComponent에 전달해주는 역할
        getLoginResult(state){
            return state.loginResult;
        }
    },
    mutations: {//state 값을 변경하기 위해 사용하는것 -> 직접호출은 불가하고 commit('정의된 이름')으로 호출
        SET_USER_INFO(state, data){
            state.userInfo = data.userInfo
            //로컬 저장소에 유저 정보, 토큰 정보 저장
            localStorage.setItem('userInfo', JSON.stringify(state.userInfo));
            localStorage.setItem('accessToken', data.accessToken)
            localStorage.setItem('refreshToken', data.refreshToken)

            //JWT혹은 OAuth에서 사용하는 인증타입 Bearer
            //axios header에 토큰을 default값으로 추가해준다.
            axios.defaults.headers.common['authToken'] = `Bearer ${data.userInfo.accesssToken}`
        },
        SET_LOGIN_RESULT(state, loginResult){
            state.loginResult = loginResult;
        }
    },
    actions: { //비동기 작업 결과를 적용할 떄 사용한다
        // commit : 현재 store의 뮤테이션을 호출하는 객체, 해당 뮤테이션을 통해 state변경 가능
        // state : store에 저장된 상태 객체
        login({commit}, loginData){
            axios.post(`user/login`, loginData)
                .then(({data}) => {
                    console.log("@@@@ UserStore에서 로그인 결과 확인 @@@@")
                    console.log(data)
                    commit('SET_USER_INFO', data.message)
                    //서버에서 전달받은 값이 success면 쿠키 생성 및 유저 데이터 저장
                    if(data.message === "success"){
                        commit('SET_USER_INFO', data)
                    }

            })
        }
    },
};

export default userStore;
