import Vue from 'vue'
import Vuex from 'vuex'
import vuePersistedState from 'vuex-persistedstate';


import boardStore from '@/store/modules/boardStore'
import userStore from "@/store/modules/userStore";
import attractionStore from "@/store/modules/attractionStore";

Vue.use(Vuex)

export default new Vuex.Store({
  modules:{
    boardStore,
    userStore,
    attractionStore,
  },
})
/* plugins : [

        vuePersistedState({
        //여기 저장된 모듈만 새로고침해도 저장이된다
        path : [
            userStore,
            boardStore,
        ]
      })
  ]
})*/
