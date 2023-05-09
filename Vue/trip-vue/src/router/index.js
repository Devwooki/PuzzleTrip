import Vue from 'vue'
import VueRouter from 'vue-router'
import AppBoard from "@/views/AppBoard.vue";


Vue.use(VueRouter)

const routes = [
  {
    path: '/board',
    name: 'board',
    component:AppBoard
  }
]
const router = new VueRouter({
  routes
})

export default router
