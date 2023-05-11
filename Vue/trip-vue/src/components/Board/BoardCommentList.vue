<template>
  <tr>
      <td>{{comment.userId}}</td>
      <td>{{comment.content}}</td>
      <td>{{comment.createdAt}}</td>
      <td>{{comment.like}}</td>
      <td><button type="button" @click="removeComment">삭제</button></td>
  </tr>
</template>

<script>
export default {
    name: 'BoardCommentList',
    props :{
        comment : Object
    },
    data() {
        return {

        };
    },

};
</script>

<style scoped></style>