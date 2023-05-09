import Vue from 'vue'
import VueRouter from 'vue-router'
import AppBoard from "@/views/AppBoard.vue";
import AppUser from "@/views/AppUser.vue";


Vue.use(VueRouter)

const routes = [
  {
    path: '/board',
    name: 'board',
    component:AppBoard
  },
  {
    path: '/user',
    name: 'user',
    component: AppUser
  }
]
const router = new VueRouter({
  routes
})

export default router
