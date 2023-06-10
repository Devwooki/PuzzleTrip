<template>
    <div>
        <div class="detail-container">
            <div class="container container1">
                게시판 선택
                <ul class="board-type">
                    <li :class="{ boardactive: selected === 2 }" value="2" @click="setBoardType">자유게시판 : 2</li>
                    <li v-if="checkUserInfo.type === 'admin'" :class="{ boardactive: selected === 1 }" value="1"
                        @click="setBoardType">공지사항 : 1
                    </li>
                </ul>
            </div>
            <div>
                <div class="title">
                    <label for="title" style="font-size: 14px"/> 제목
                    <input ref="title" class="input-area" type="text" id="title" name="title" v-model="title"/>
                </div>

                <div class="infos">
                    <!-- 조회수, 작성일, 글번호 등이 나오는데 작성할 땐 제거 -->
                </div>

                <blockquote>
                    <div class="main-content">
                        <cite>{{ checkUserInfo.id }}님 {{ message1 }}</cite>
                        <p>
                            <label for="content"/> 본문 <br>
                            <textarea ref="content" class="input-area" id="content" name="content" v-model="content"
                                      v-autosize/>
                        </p>
                    </div>

                    <div class="show-only-img" v-if="getOnlyImage.length !== 0">
                        <div class="img-container" v-for="(img, idx) in getOnlyImage" :key="idx">
                            <img :src="img">
                        </div>
                    </div>


                    <div class="sub-content">
                        <div class="file-container">
                            <div class="file-list">
                                <img id="upload-img" class="upload-img" :src="imgSrc" alt="파일 업로드" @click="uploadClick">
                                <input id="fileInput" type="file" multiple="multiple" @change="onFileChange"/>
                                <board-file-list-for-write-modify v-if="getUploadFile.length !== 0"></board-file-list-for-write-modify>
                            </div>
                        </div>
                        <div class="board-recommand">
                        </div>
                    </div>
                </blockquote>
            </div>
            <div class="btn-loc">
                <button class="write-btn btn-del" type="button" @click="writeCancle">취소</button>
                <button class="write-btn btn-15" type="button" @click="write">글쓰기</button>
            </div>
        </div>
    </div>
</template>

<script>
import myAxios from "@/util/axios";
import {mapGetters, mapMutations} from "vuex";
import BoardFileListForWriteModify from "@/components/Board/BoardFileListForWriteModify.vue";



export default {
    name: 'BoardWrite',
    computed: {
        //vuex모듈 중 boardStore에서 'getBoardType', 'getPageNo'를 얻어온다.
        ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo', 'getBoardType', 'getUploadFile', 'getOnlyImage']),
        ...mapGetters('userStore', ['checkUserInfo'])
    },
    components: {BoardFileListForWriteModify},
    data() {
        return {
            //유저 아이디는 state에서 받아서 저장, JWT
            selected: null,
            title: '',
            content: '',
            message1: '작성중',
            imgSrc : require('@/assets/upload.png'),
        };
    },
    methods: {
        ...mapMutations('boardStore',['SET_UPLOAD_FILE']),
        setBoardType(event) {
            this.selected = event.target.value;
            console.log(this.selected)
        },
        onFileChange(event) {
            this.SET_UPLOAD_FILE(event.target.files);
            console.log(this.getUploadFile)
            // for(let idx = 0 ; idx < event.target.files.length ; ++idx){
            //     const extension = event.target.files[idx].name.split('.').pop().toLowerCase();
            //     if (extension === 'jpg' || extension === 'png' || extension === 'gif') {
            //         this.OnlyImage.push(URL.createObjectURL(event.target.files[idx]))
            //     }
            // }
            // console.log(this.OnlyImage)
        },
        write() {
            //Vue에서는 Form을 이용한 전송보다 각 data 변수로 form 데이터 만들어서 전송하는게 효율이 좋다 - gpt 피셜
            //form은 HTML form 태그를 이용해 전송하는 방식
            //일반 JS의 객체와 비슷한 Key - value 형태지만
            //파일 업로드를 위해 어쩔 수 없이 사용해야한다.

            //개행문자(줄바꿈) 등을 db에서 인식할 수 있게 수정한다.
            if (this.title.trim() === '') {
                this.$refs.title.focus()
                alert("제목을 입력해주세요.")
                return;
            } else if (this.content.trim() === '') {
                this.$refs.content.focus()
                alert("본문을 입력해주세요.")
                return;
            } else {
                let formData = new FormData();
                formData.append('title', this.title);
                formData.append('content', this.content);
                formData.append('boardType', this.selected);
                formData.append('userId', this.checkUserInfo.id);


                for (let i = 0; i < this.getUploadFile.length; i++) {
                    formData.append('files', this.getUploadFile[i]);
                }

                myAxios.post("board/write", formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    }
                ).then(({data}) => {
                    this.$store.commit('boardStore/SET_BOARD_NO', data);
                    this.$router.push({name: 'boardDetail'});
                });
            }
        },
        writeCancle() {
            alert("글쓰기 취소");
            this.$router.push({name: 'boardList'});
        },uploadClick(){
            let fileInput = document.querySelector("#fileInput");
            fileInput.click();
        }
    },
    created() {
        this.SET_UPLOAD_FILE({})
        this.selected = this.getBoardType;
    },
    mounted() {
        this.$refs.title.focus()
        setInterval(() => {
            if (this.message1.endsWith('...')) {
                this.message1 = '작성중';
            } else {
                this.message1 += '.';
            }
        }, 300);
    }
};
</script>

<style scoped>
* {
    list-style: none;
    text-decoration: none;
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

.container.container1 {
    width: 90%;
    margin: 0 auto;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

li {

}

.board-type {
    display: flex;
    justify-content: center;
    padding: 0 auto;
    max-width: 900px;
}

.board-type li {
    margin: 10px 0px;
    padding: 5px 15px 5px;
    font-size: 12px;
}

.board-type li:hover {
    background-color: #7D9600;
    color: #FFF;
    border-radius: 5px;
}

.board-type li:active {
    position: relative;
    top: 2px;
}

.boardactive {
    border-bottom: 4px solid #7D9600;
    font-weight: bold;
    border-radius: 5px;
}

.detail-div {
    position: relative;;
    top: 30px;
}

.detail-container {
    width: 90%;
    max-width: 900px;
    margin: 50px auto;
}

.detail-container .title {
    position: relative;
    border-top: 2px solid #7D9600;
    margin: auto;
    padding: 10px 30px;
    font-size: 20px;
}

.detail-container .infos {
    position: relative;
    font-family: "Roboto", sans-serif;
    font-size: 10px;
    margin: auto;
    padding: 0px 0px 5px 0px;
    text-align: right;
}

.detail-container blockquote {
    position: relative;
    border-top: 1px solid #7D9600;
    border-bottom: 2px solid #7D9600;
    padding: 10px 30px;
}

blockquote p {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: auto;
    padding: 10px 0 30px;
    position: relative;
    top: 5px;
}

.show-only-img {
    height: 300px;
    overflow-x: scroll;
    white-space: nowrap;
    display: flex;
    flex-direction: row;
    margin-bottom: 30px;
}

.img-container img {
    margin-right: 10px; /* 이미지 간격을 조정하고 싶은 경우 사용 */
    height: 270px;
    border-radius: 5px;
    border: 1.5px solid black;
}

.input-area {
    margin: 10px;
    background-color: white;
    width: 95%;
    height: auto;
    border-bottom: 1px solid #626262;
    resize: none; /*사용자가 크기를 조절할 수 없게 한다.*/
    overflow: hidden; /*내용이 넘치면 숨긴다*/
}


.detail-container blockquote:before {
    position: absolute;
    background-color: #FFFFFF;
    color: #7D9600;
    font-family: 'FontAwesome';
    content: '\f10d';
    line-height: 1;
    text-align: center;
    top: -20px;
    left: -10px;
    padding: 10px;
    font-size: 20px;
}

.detail-container blockquote:after {
    position: absolute;
    right: -10px;
    bottom: -20px;
    background-color: #FFFFFF;
    padding: 10px;
    color: #7D9600;
    font-family: 'FontAwesome';
    content: '\f10e';
    line-height: 1;
    text-align: center;
    font-size: 20px;
}

.detail-container blockquote cite {
    display: block;
    font-size: 1.2rem;
    text-align: right;
    padding: 15px 0 0;
    color: #808080;
}

.sub-content {
    display: flex;
    flex-direction: row;
}

.sub-content .file-container {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
    flex: 3;
}

.file-container h3 {
    flex: 1;
    text-align: center;
}

.file-container div {
    flex: 6;
}

.sub-content .board-recommand {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    flex: 1;
}

.file-list {
    display: flex;
    flex-direction: row;
    justify-content: left;
    align-items: center;
}

.btn-loc {
    display: flex;
    justify-content: right;
}

button {
    margin: 10px 10px 10px 0;
    outline: none;
    text-align: center;
    font-size: 12px;
}

.write-btn {
    width: 70px;
    height: 35px;
    padding: 10px 15px;
    border: 2px solid #000;
    font-weight: 200;
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-block;
    position: relative;
    right: 0;
}

/* 15 */
.btn-15 {
    background: #626262;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}

.btn-15:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #e0e5ec;
    transition: all 0.2s ease;
}

.btn-15:hover {
    color: #626262;
}

.btn-15:hover:after {
    left: 0;
    width: 100%;
}

.btn-15:active {
    top: 2px;
}

/*modi*/
.btn-modi {
    background: #7D9600;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}

.btn-modi:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #dce3bc;
    transition: all 0.2s ease;
}

.btn-modi:hover {
    color: #7D9600;
}

.btn-modi:hover:after {
    left: 0;
    width: 100%;
}

.btn-modi:active {
    top: 2px;
}

.btn-del {
    background: #d96161;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}

.btn-del:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #f3d3d3;
    transition: all 0.2s ease;
}

.btn-del:hover {
    color: #ce5252;
}

.btn-del:hover:after {
    left: 0;
    width: 100%;
}

.btn-del:active {
    top: 2px;
}

.btn-list {
    background: #2b90d9;
    color: #fff;
    z-index: 1;
    border-radius: 5px;
}

.btn-list:after {
    position: absolute;
    content: "";
    width: 0;
    height: 100%;
    top: 0;
    right: 0;
    z-index: -1;
    background: #c1d8ef;
    transition: all 0.2s ease;
}

.btn-list:hover {
    color: #2186cc;
}

.btn-list:hover:after {
    left: 0;
    width: 100%;
}

.btn-list:active {
    top: 2px;
}

#fileInput{
    //visibility: hidden;
    display: none;
}

.file-list .upload-img{
    width: 25px;
    height: 25px;
    margin : 10px;
}

.upload-img:hover{
    cursor : pointer;
}
</style>
