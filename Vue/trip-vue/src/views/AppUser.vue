<template>
  <div>
    <user-login></user-login>
  </div>
</template>

<script>
import UserLogin from "@/components/User/UserLogin.vue";

export default {
    name: "AppUser.vue",
    components :{
      UserLogin
    }
}
</script>

<style scoped>

</style>