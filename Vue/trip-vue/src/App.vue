<template>
    <app-board></app-board>
</template>

<script>

import AppBoard from "@/views/AppBoard.vue";

export default {
    name: 'App',
    components: {
        // eslint-disable-next-line vue/no-unused-components
        AppBoard,

    },
    data() {
        return {
            message: '',
        };
    },
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

nav {
    padding: 30px;
}

nav a {
    font-weight: bold;
    color: #2c3e50;
}

nav a.router-link-exact-active {
    color: #42b983;
}
</style>
