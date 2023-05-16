import Vue from "vue";
import VueRouter from "vue-router";
import AppHome from "@/AppHome.vue";
import AppBoard from "@/views/main/AppBoard.vue";
import AppAttraction from "@/views/main/AppAttraction.vue";
import AppLogin from "@/views/user/AppLogin.vue";
import AppLogout from "@/views/user/AppLogout.vue";
import AppMyPlace from "@/views/main/AppMyPlace.vue";
import AppAnnounce from "@/views/main/AppAnnounce.vue";
import AppHotPlace from "@/views/main/AppHotPlace.vue";
import BoardList from "@/components/Board/BoardList.vue";
import BoardDetail from "@/components/Board/BoardDetail.vue";
import BoardWrite from "@/components/Board/BoardWrite.vue";
import BoardFileItem from "@/components/Board/BoardFileItem.vue";
import BoardModify from "@/components/Board/BoardModify.vue";
import AppTest from "@/views/main/AppTest.vue";



Vue.use(VueRouter);
const routes = [

  {
    path: "/",
    name: "home",
    component : AppHome
  },
  {
    path: "/login",
    name: "login",
    component: AppLogin
  },
  {
    path: "/logout",
    name: "logout",
    component: AppLogout
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
  {
    path: "/announce",
    name: "announce",
    component: AppAnnounce
  },
  {
    path: "/test",
    name: "test",
    component: AppTest
  }
];

const router = new VueRouter({
  mode : 'history',
  routes,
});

export default router;
