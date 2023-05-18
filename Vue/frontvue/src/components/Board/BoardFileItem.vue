<template>
  <ul>
    <li v-for="(fileInfo, index) in fileInfos" :key="index">
      <label> {{index +1}}번 파일명 : {{ fileInfo.originalFile }}</label>
      <input type="hidden">
      <button @click="downloadFile(fileInfo)">다운로드</button>
    </li>
  </ul>
</template>

<script>
import {mapState} from "vuex";
import axios from "@/util/axios";

export default {
  name: 'BoardFileItem',
  props: ['fileInfos'],
  data() {
    return {};
  },
  computed: {
    ...mapState('boardStore', ['boardType', 'boardNo'])
  },
  methods: {
    async downloadFile(data) {
      console.dir(data)
      axios.get(`file/download/${data.saveFolder}/${data.originalFile}/${data.saveFile}`, {
        responseType: 'blob',
      }).then(response => {
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', `${data.originalFile}`);
        link.style.display = 'none';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      });
    }
  }
};
</script>

<style scoped></style>