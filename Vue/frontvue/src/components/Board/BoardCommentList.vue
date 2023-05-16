<template>
  <tr>
    <td></td>
    <td>{{ comment.userId }}</td>
    <td>{{ comment.content }}</td>
    <td>{{ comment.createdAt }}</td>
    <td>{{ comment.like }}</td>
    <td>
      <button type="button" @click="commentDelete">삭제</button>
    </td>
  </tr>
</template>

<script>
import {mapGetters} from "vuex";
import axios from "@/util/axios";

export default {
  name: 'BoardCommentList',
  props: {
    comment: Object
  },
  data() {
    return {};
  },
  methods: {
    async commentDelete() {
      console.dir(this.comment)
      const response = await axios.delete(`/comment/${this.getBoardType}/${this.getBoardNo}/${this.comment.no}`)
      console.log(response)
      if (response !== undefined) this.$store.commit("boardStore/SET_COMMENTS", response.data)
    }
  },
  computed: {
    ...mapGetters('boardStore', ['getBoardNo', 'getBoardType']),
  }

};
</script>

<style scoped></style>