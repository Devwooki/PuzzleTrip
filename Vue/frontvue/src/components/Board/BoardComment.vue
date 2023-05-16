<template>
  <div>
    <h4>댓글입니다.</h4>
    <table>
      <board-comment-list v-for="comment in getComments" :key="comment.no" :comment="comment"></board-comment-list>
    </table>
    <textarea ref="commentArea" v-model="content">
        </textarea>
    <button @click="writeComment">등록</button>
    <button @click="removeContent">취소</button>
  </div>
</template>

<script>
import BoardCommentList from "@/components/Board/BoardCommentList.vue";
import {mapGetters} from "vuex";
import axios from "@/util/axios";

export default {
  name: 'BoardComment',
  components: {
    BoardCommentList
  },
  data() {
    return {
      userId: 'ssafy',
      content: '',
    };
  },
  async created() {
    const response = await axios.get(`/comment/${this.getBoardType}/${this.getBoardNo}`)
    this.$store.commit('boardStore/SET_COMMENTS', response.data);

  },
  methods: {
    async writeComment() {
      const sendData = {
        userId: this.userId,
        content: this.content,
        boardType: this.getBoardType,
        boardNo: this.getBoardNo,
      }

      const response = await axios.post(`/comment/${this.getBoardType}/${this.getBoardNo}`, sendData)
      this.$store.commit('boardStore/SET_COMMENTS', response.data)
      this.content = ''
      this.$refs.commentArea.focus()
    },
    removeContent() {
      this.content = ''
    },
  },
  computed: {
    ...mapGetters('boardStore', ['getBoardType', 'getBoardNo', 'getComments'])
  }
};
</script>

<style scoped></style>