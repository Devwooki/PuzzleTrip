import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Vuetify from 'vuetify/lib'
import 'vuetify/dist/vuetify.min.css'
import VTooltip from 'v-tooltip';
import VueCookies from "vue-cookies";
import axios from "axios";
/* import fontawesome  */
import {library} from '@fortawesome/fontawesome-svg-core'
import {FontAwesomeIcon} from '@fortawesome/vue-fontawesome'

/* import specific icons */
import {
        faHeart as fasHeart,
        faPlus as fasPlus,
        faTemperatureHigh,
        faTint
} from '@fortawesome/free-solid-svg-icons'
import { faHeart as farHeart} from '@fortawesome/free-regular-svg-icons'



'fas', 'temperature-high'
/* add icons to the library */
library.add(
  fasHeart,
  farHeart,
  fasPlus,
  faTemperatureHigh,
  faTint
)


/* add font awesome icon component */
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.config.productionTip = false

Vue.use(Vuetify, VTooltip);

Vue.prototype.$http = axios


//쿠키 정보 등록, 글로벌 세팅으로 3일 뒤 쿠키는 자동으로 삭제된다
Vue.use(VueCookies);
Vue.$cookies.config("3d");

new Vue({
  router,
  store,

  vuetify: new Vuetify({
    theme: {
      themes: {
        light: {
          primary: '#3f51b5',
          secondary: '#b0bec5',
          accent: '#8c9eff',
          error: '#b71c1c',
        },
      },
    },
  }),
  render: (h) => h(App)
}).$mount("#app");