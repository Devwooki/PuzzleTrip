import Vue from "vue";
import VueRouter from "vue-router";
import AppHome from "@/AppHome.vue";
import AppBoard from "@/views/main/AppBoard.vue";
import AppAttraction from "@/views/main/AppAttraction.vue";
import AppMyPlace from "@/views/main/AppMyPlace.vue";
import AppHotPlace from "@/views/main/AppHotPlace.vue";
import BoardList from "@/components/Board/BoardList.vue";
import BoardDetail from "@/components/Board/BoardDetail.vue";
import BoardWrite from "@/components/Board/BoardWrite.vue";
import BoardFileItem from "@/components/Board/BoardFileItem.vue";
import BoardModify from "@/components/Board/BoardModify.vue";
import AppUser from "@/views/user/AppUser.vue";
import UserLogin from "@/components/User/UserLogin.vue";




Vue.use(VueRouter);
const routes = [

  {
    path: "/",
    name: "home",
    component : AppHome
  },
  {
    path: "/user",
    name: "login",
    component: AppUser,
    children : [
      {
        path: "/login",
        name: "login",
        component : UserLogin
      },
    ]
  },
  {
    path: "/attraction",
    name: "attraction",
    component: AppAttraction
  },
  {
    path: "/myPlace",
    name: "myPlace",
    component: AppMyPlace
  },
  {
    path: "/hotPlace",
    name: "hotPlace",
    component: AppHotPlace
  },
  {
    path: "/board",
    name: "board",
    component: AppBoard,
    redirect: "/board/list",
    children: [
      {
        path: "list",
        name: "boardList",
        component: BoardList,
      },
      {
        path: "detail",
        name: "boardDetail",
        component: BoardDetail,
        children : [
          {
            path: "/fileItem",
            name: "boardFileItem",
            component: BoardFileItem,
          }
        ]
      },
      {
        path: "modify",
        name: "boardModify",
        component: BoardModify,
      },
      {
        path: "write",
        name: "boardWrite",
        component: BoardWrite,
      },
    ],
  },
];

const router = new VueRouter({
  mode : 'history',
  routes,
});

export default router;
