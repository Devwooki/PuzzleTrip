<template>
  <div>
    <div>
      <h3>본문</h3>
      <label> 게시판 번호 : {{ board.typeNo }} | </label>
      <label> 글번호 : {{ board.no }} | </label>
      <label> 작성자 : {{ board.userId }} | </label>
      <label> 조회수 : {{ board.hit }} | </label>
      <label> 작성시간 : {{ board.createcAt }} | </label>

      <br>
      <label> 글제목 </label>
      <div>{{ board.title }}</div>
      <br>
      <label> 내용</label>
      <div>{{ board.content }}</div>
    </div>
    <div>
      <h3>파일</h3>
      <board-file-item :fileInfos="board.fileInfos"></board-file-item>
    </div>

    <div>
      <h4>게시글 추천</h4>
      <input type="checkbox" name="like" id="like" v-model="likeSelect" @change="changeLike">
      <label for="like">추천 수 : {{ likeCnt }}</label>
    </div>

    <div style="padding-top: 15px">
      <router-link :to="{name : 'boardModify'}">수정 |</router-link>
      <a @click="beforeRemove"> 삭제 |</a>
      <router-link :to="{name : 'board'}"> 목록 |</router-link>
      <router-link :to="{name : 'boardWrite'}">글쓰기</router-link>
    </div>
    <div>
      <h3>댓글</h3>
      <board-comment></board-comment>
    </div>
  </div>
</template>

<script>
import BoardFileItem from "@/components/Board/BoardFileItem.vue";
import BoardComment from "@/components/Board/BoardComment.vue";
import {mapGetters} from "vuex";
import axios from "@/util/axios";


export default {
  name: 'BoardDetail',
  components: {
    BoardFileItem,
    BoardComment
  },
  data() {
    return {
      board: {},
      likeSelect: false,
      likeCnt: 0,
    };
  },
  async created() {
    const response = await axios.get(`board/details/${this.getBoardType}/${this.getBoardNo}`)
    this.board = response.data
    console.log(this.board)
    this.likeCnt = this.board.likeCnt
  },
  methods: {
    async beforeRemove() {
      if (confirm("정말 해당 게시글을 삭제하시겠습니까?")) {
        await axios.delete(`board/${this.getBoardType}/${this.getBoardNo}`)
        await this.$router.push({name: 'board'});
      }
    },
    changeLike() {
      console.log(this.likeSelect)
      if (this.likeSelect) {
        this.likeCnt += 1;
      } else {
        this.likeCnt -= 1;
      }
      axios.put(`board/like`, {
        userId: 'ssafy',
        boardNo: this.board.no,
        likeSelect: this.likeSelect,
        typeNo: this.board.typeNo
      })
    }
  },
  computed: {
    ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo'])
  }
}
</script>

<style scoped></style>