<template>
  <div>
    <div>
      <h3>게시판 번호 : {{ getBoardType }}</h3>
      <h3>{{ getBoardNo }}번 게시글 수정</h3>
      <br>
      <br>
      <label for="title"/> 제목
      <input type="text" id="title" name="title" v-model="title"/>
      <label for="content"/> 제목
      <textarea id="content" name="content" v-model="content"/>

      <label for="file"/> 파일 업로드
      <input type="file" multiple="multiple" @change="onFileChange"/>
      <button type="button" @click="modify">수정</button>
      <button type="button" @click="modifyCancle">취소</button>
    </div>

    <ul>
      <li v-for="fileInfo in this.fileInfos" :key="fileInfo">
        <label> 파일명 : {{ fileInfo.originalFile }}</label>
        <input type="hidden">
        <button @click="deleteFile(fileInfo)">삭제</button>
      </li>
    </ul>
  </div>
</template>

<script>

import {mapGetters} from "vuex";
import axios from "@/util/axios";


export default {
  name: 'BoardModify',
  data() {
    return {
      title: '',
      content: '',
      files: [],
      fileInfos: {},
    };
  },
  async created() {
    console.log("@@@@@@@@@@@@ 게시글 수정으로 이동")
    const response = await axios.get(`board/details/${this.getBoardType}/${this.getBoardNo}`)
    console.log(response);
    this.title = response.data.title
    this.content = response.data.content
    this.fileInfos = response.data.fileInfos
  },
  computed: {
    //vuex모듈 중 boardStore에서 'getBoardType', 'getPageNo'를 얻어온다.
    ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo']),
  },
  methods: {
    onFileChange(event) {
      this.files = event.target.files;
      console.log("@파일 수정@")
      console.log(this.files);
    },
    async modify() {
      let formData = new FormData();
      formData.append('title', this.title);
      formData.append('content', this.content);
      formData.append('typeNo', this.getBoardType);
      formData.append('boardNo', this.getBoardNo);
      formData.append('userId', 'ssafy');
      //console.log(this.files.length)
      for (let i = 0; i < this.files.length; i++) {
        formData.append('files', this.files[i]);
      }

      //게시글 정보 수정
      const response = await axios.put(`board/modify`, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }
      )
      console.log("$$$$$$$$$$$$수정완료");
      this.$store.commit('boardStore/SET_BOARD_NO', response.data);
      this.$router.push({name: 'boardDetail'});
    },
    modifyCancle() {
      alert("글쓰기 취소");
      this.$router.push({name: 'boardList'});
    },
    async deleteFile(fileInfo) {
      console.log("@@@@@파일 삭제@@@@@")
      if (confirm(`정말 ${fileInfo.originalFile}을 삭제하시겠습니까? \n 삭제된 파일은 복구할 수 없습니다.`)) {
        const response = await axios.delete(`board/deleteFile/${this.getBoardNo}/${fileInfo.saveFolder}/${fileInfo.saveFile}`)
        this.fileInfos = response.data;
      }
    }
  },
};
</script>

