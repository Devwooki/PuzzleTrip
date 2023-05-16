//import MyAxios from '@/util/axios';
const userStore = {
    namespaced: true,
    state: { //Vue의 data 역할, application에서 공유해야할 data

    },
    getters: { //state의 값을 vueComponent에 전달해주는 역할

    },
    mutations: {//state 값을 변경하기 위해 사용하는것 -> 직접호출은 불가하고 commit('정의된 이름')으로 호출

    },
    actions: { //비동기 작업 결과를 적용할 떄 사용한다
        // commit : 현재 store의 뮤테이션을 호출하는 객체, 해당 뮤테이션을 통해 state변경 가능
        // state : store에 저장된 상태 객체
    },
};

export default userStore;
