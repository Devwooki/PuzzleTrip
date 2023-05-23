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
import UserFindPw from "@/components/User/UserFindPw.vue";
import UserViewMyPage from "@/components/User/UserViewMyPage.vue";
import UserModifyMyPage from "@/components/User/UserModifyMyPage.vue";
import store from "@/store";
import AppPlay from "@/components/Attraction/AppPlay.vue";
import AppHotel from "@/components/Attraction/AppHotel.vue";


Vue.use(VueRouter);
//페이지 네비게이션 가드
//특정 페이지로 이동하기전에 제어하는 함수이다
// to : 이동할 경로
// from : 현재경로 나타냄
// next : 이동을 허용하기 위한 콜백함수, next("경로") 사용하면 이동,
const onlyAuthUser = async (to, from, next) => {
  const checkUserInfo = store.getters["userStore/checkUserInfo"];
  const checkToken = store.getters["userStore/checkToken"];
  let token = sessionStorage.getItem("accessToken");
  console.log("로그인 처리 전", checkUserInfo, token);

  if (checkUserInfo != null && token) {
    console.log("토큰 유효성 체크");
    await store.dispatch("userStore/getUserInfo", token);
  }


  if (!checkToken || checkUserInfo === null) {
    alert("로그인이 필요한 페이지입니다..");
    // next({ name: "login" });
    router.push({ name: "userLogin" });
  } else {
    console.log("로그인 했다!!!!!!!!!!!!!.");
    next();
  }
};

const routes = [
  {
    path: "/",
    name: "home",
    component : AppHome
  },
  {
    path: "/user",
    name: "user",
    component: AppUser,
    children : [
      {
        path: "login",
        name: "userLogin",
        component : UserLogin
      },
      {
        path: "findPw",
        name: "userFindPw",
        beforeEnter: onlyAuthUser,
        component : UserFindPw
      },
      {
        path: "myPage",
        name: "userMyPage",
        beforeEnter: onlyAuthUser,
        component : UserViewMyPage
      },
      {
        path: "modify",
        name: "userModify",
        beforeEnter: onlyAuthUser,
        component : UserModifyMyPage
      }
    ]
  },
  {
    path: "/attraction",
    name: "attraction",
    component: AppAttraction,
    children: [
      {
        path: "hotel",
        name: "hohelComp",
        component: AppHotel
      },
      {
        path: "play",
        name: "palyComp",
        component: AppPlay
      }
    ]
  },
  {
    path: "/myPlace",
    name: "myPlace",
    beforeEnter: onlyAuthUser,
    component: AppMyPlace
  },
  {
    path: "/hotPlace",
    name: "hotPlace",
    beforeEnter: onlyAuthUser,
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
          },
        ]
      },
      {
        path: "modify",
        name: "boardModify",
        beforeEnter: onlyAuthUser,
        component: BoardModify,
      },
      {
        path: "write",
        name: "boardWrite",
        beforeEnter: onlyAuthUser,
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
