<template>
  <div>
    <h1>게시판 리스트 출력</h1>
    <div>
      <input type="radio" id="free" name="boardType" value="2" @click="getList" />
      <label for="free">자유게시판</label>
      <input type="radio" id="notice" name="boardType" value="1" @click="getList" />
      <label for="notice">공지사항</label>
    </div>
    <div>
      <p>총 게시글 수 : {{ pageResult.totalBoard }}개</p>
      <table>
        <thead>
          <th>번호</th>
          <th>제목</th>
          <th>글쓴이</th>
          <th>조회수</th>
          <th>등록일</th>
        </thead>

        <tbody>
          <board-list-item v-for="board in boards" :key="board.no" :board="board"></board-list-item>
        </tbody>
      </table>
    </div>
    <board-page-list :pageResult="pageResult"></board-page-list>
  </div>
</template>

<script>
import BoardListItem from "@/components/Board/BoardListItem.vue";
import BoardPageList from "@/components/Board/BoardPageList.vue";

export default {
  name: "BoardList",
  components: { BoardListItem, BoardPageList },
  data() {
    return {
      boardType: 2,
      pageNo: 1,
      boards: {},
      pageResult: {},
    };
  },
  methods: {
    getPage(event) {
      console.log(event.target.value);
    },
    getList(event) {
      this.boardType = event.target.value;
      fetch("http://localhost:8989/board/lists/" + this.boardType + "/1")
        .then((response) => response.json())
        .then((data) => {
          this.boards = data.list;
          this.pageResult = data.pageResult;
          //console.dir(this.boards);
        });
    },
  },
  created() {
    console.log(this.boardType);
    fetch("http://localhost:8989/board/lists/" + this.boardType + "/1")
      .then((response) => response.json())
      .then((data) => {
        this.boards = data.list;
        this.pageResult = data.pageResult;
        console.dir(this.pageResult);
      });
  },
};
</script>

<style>
/* 라디오 버튼의 모양 지우고 글자로만 선택하기 위해서 추가한 css */
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
