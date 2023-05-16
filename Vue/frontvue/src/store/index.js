import Vue from 'vue'
import Vuex from 'vuex'


import boardStore from '@/store/modules/boardStore'
import userStore from "@/store/modules/userStore";
Vue.use(Vuex)

export default new Vuex.Store({
  modules:{
    boardStore,
    userStore,
  }
})
