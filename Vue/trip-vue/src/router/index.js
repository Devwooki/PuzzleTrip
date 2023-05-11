import Vue from "vue";
import VueRouter from "vue-router";
import AppBoard from "@/views/AppBoard.vue";
import AppUser from "@/views/AppUser.vue";
import BoardList from "@/components/Board/BoardList.vue";
import BoardDetail from "@/components/Board/BoardDetail.vue";
import BoardWrite from "@/components/Board/BoardWrite.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "main",
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
      },
      {
        path: "write",
        name: "boardWrite",
        component: BoardWrite,
      },
    ],
  },
  {
    path: "/user",
    name: "user",
    component: AppUser,
  },
];
const router = new VueRouter({
  mode : 'history',
  routes,
});

export default router;
