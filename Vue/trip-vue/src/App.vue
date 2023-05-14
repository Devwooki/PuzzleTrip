<template>
  <div>
    <router-link :to="{ name: 'main' }">홈으로 | </router-link>
    <router-link :to="{ name: 'board' }">게시판 | </router-link>
    <router-link :to="{ name: 'user' }">유저 | </router-link>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "App",
};
</script>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
