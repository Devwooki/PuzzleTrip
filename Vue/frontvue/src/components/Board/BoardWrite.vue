<template>
  <div>
    {{ getBoardType }}번 게시판에 글쓰기<br><br>
    <label for="title"/> 제목
    <input type="text" id="title" name="title" v-model="title"/>
    <label for="content"/> 제목
    <textarea id="content" name="content" v-model="content"/>

    <label for="file"/> 파일 업로드
    <input type="file" multiple="multiple" @change="onFileChange"/>
    <button type="button" @click="write">글쓰기</button>
    <button type="button" @click="writeCancle">취소</button>

  </div>
</template>

<script>
import BoardDetail from "@/components/Board/BoardDetail.vue";
import BoardList from "@/components/Board/BoardList.vue";
import axios from "@/util/axios";
import {mapGetters} from "vuex";


export default {
  name: 'BoardWrite',
  computed: {
    //vuex모듈 중 boardStore에서 'getBoardType', 'getPageNo'를 얻어온다.
    ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo']),
    BoardDetail,
    BoardList
  },
  data() {
    return {
      //유저 아이디는 state에서 받아서 저장, JWT
      title: '',
      content: '',
      files: [],
    };
  },
  methods: {
    onFileChange(event) {
      this.files = event.target.files;
      console.log(this.files);
    },
    write() {
      //Vue에서는 Form을 이용한 전송보다 각 data 변수로 form 데이터 만들어서 전송하는게 효율이 좋다 - gpt 피셜
      //form은 HTML form 태그를 이용해 전송하는 방식
      //일반 JS의 객체와 비슷한 Key - value 형태지만
      //파일 업로드를 위해 어쩔 수 없이 사용해야한다.
      let formData = new FormData();
      formData.append('title', this.title);
      formData.append('content', this.content);
      formData.append('boardType', this.getBoardType);
      formData.append('userId', 'ssafy');
      console.log(this.files.length)
      for (let i = 0; i < this.files.length; i++) {
        formData.append('files', this.files[i]);
      }

      axios.post("board/write", formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }
      ).then(({data}) => {
        this.$store.commit('boardStore/SET_BOARD_NO', data);
        this.$router.push({name: 'boardDetail'});
      });
    },

    writeCancle() {
      alert("글쓰기 취소");
      this.$router.push({name: 'boardList'});
    }
  },
};
</script>

<style scoped></style>
