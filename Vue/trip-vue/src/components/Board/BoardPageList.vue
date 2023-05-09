<template>
  <div v-html="pageResult.listHTML"></div>
</template>

<script>
export default {
    name: "BoardPageList",
    props :{
        pageResult : Object,
    },
    data(){
        return {

        }
    },
    beforeUpdate(){
      console.log(this.pageResult);
    }
}
</script>

<style scoped>

</style>