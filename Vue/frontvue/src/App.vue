<template id="root">
  <div id="app">
    <div id="wrap">
      <header>
        <app-header id="header"></app-header>
      </header>
      <v-divider></v-divider>
      <div id="content-wrap">
        <router-view id="main"></router-view>
      </div>
    </div>
    <app-footer id="footer"></app-footer>
  </div>
</template>

<script>

import AppHeader from "@/views/layout/AppHeader.vue";
import AppFooter from "@/views/layout/AppFooter.vue";

export default {
  name: "App",
  components: {AppHeader, AppFooter},
};
</script>

<!--전역 스타일-->
<style>
body {
    margin: 0;
}
</style>

<!--지역스타일-->
<style scoped>
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

html {
    * {
        font-family: 'NanumSquareNeo-Variable';
    }
    margin: 0;
    padding: 0;
    height: 100%;
}
header {
    display: flex;
    justify-content: center;

}
#header{
    width: 80%;
}
#wrap {
    min-height: 100%;
    position: relative;
    padding-bottom: 70px;
}

#main {
    padding: 0;
    margin-top: 1rem;
}

#footer {
    position: relative;
(absolute - > relative) transform: translatY(- 100 %);
    height: 5rem;
}
</style>