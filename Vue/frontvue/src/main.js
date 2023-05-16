import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import VueCookies from "vue-cookies";
import axios from "axios";

Vue.use(Vuetify);
Vue.prototype.$http = axios;

//쿠키 정보 등록, 글로벌 세팅으로 3일 뒤 쿠키는 자동으로 삭제된다
Vue.use(VueCookies);
Vue.$cookies.config("3d");

new Vue({
  router,
  store,
  vuetify: new Vuetify(),
  render: (h) => h(App),
}).$mount("#app");
