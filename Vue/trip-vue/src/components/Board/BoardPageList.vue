<template>
  <div v-html="pageResult.listHTML"></div>
  <!-- <div>
  

    <input type="radio" id="first-page" name="pageList" value="1" @click="getPage" />
    <label for="first-page">처음</label>
    <input type="radio" id="prev-page" name="pageList" value="1" @click="getPage" />
    <label for="prev-page">이전</label>

    <input type="radio" id="next-page" name="pageList" value="1" @click="getPage" />
    <label for="next-page">다음</label>
    <input type="radio" id="last-page" name="pageList" value="1" @click="getPage" />
    <label for="last-page">마지막</label>
  </div> -->
</template>

<script>
export default {
  name: "BoardPageList",
  props: {
    pageResult: Object,
  },
  data() {
    return {};
  },
  methods: {
    getPage(event) {
      console.log(event.target.value);
    },
  },
};
</script>

<style scoped>
input {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border-radius: 0;
  border: none;
  outline: none;
}
label {
  cursor: pointer;
  text-decoration: none;
}

label:hover {
  text-decoration: underline;
}
</style>
