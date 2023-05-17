import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Vuetify from 'vuetify/lib'
import 'vuetify/dist/vuetify.min.css'
import axios from "axios";
/* import fontawesome  */
import {library} from '@fortawesome/fontawesome-svg-core'
import {FontAwesomeIcon} from '@fortawesome/vue-fontawesome'

/* import specific icons */
/*import { faHeart as fasHeart} from '@fortawesome/free-solid-svg-icons'
import { faHeart as farHeart} from '@fortawesome/free-regular-svg-icons'*/

/* add icons to the library */
library.add(
  /*  fasHeart,
    farHeart*/
)


/* add font awesome icon component */
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.config.productionTip = false

Vue.use(Vuetify)
Vue.prototype.$http = axios

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
