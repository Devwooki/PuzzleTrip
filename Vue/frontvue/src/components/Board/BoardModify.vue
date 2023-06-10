<template>
    <div>

        <div class="detail-container">
            <div class="container container1">
                <h3>게시판 번호 : {{ getBoardType }}</h3>
                <h3>{{ getBoardNo }}번 게시글 수정</h3>
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
                    <!-- 조회수, 작성일, 글번호 등이 나오는데 수정할 땐 제거 -->
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

                    <div class="show-only-img" >
                        <div class="img-container" v-for="(img, idx) in OnlyImage" :key="idx">
                            <img :src="`http://localhost:8989/profilePath/${img.saveFolder}/${img.saveFile}`">
                        </div>
                        <div class="img-container" v-for="(img, idx) in getOnlyImage" :key="idx">

                            <img :src="img">
                        </div>
                    </div>


                    <div class="explain">
                        <span class="explain-uploaded">기존 업로드 파일</span>
                        <span class="explain-new">새로운 파일</span>
                    </div>
                    <div class="sub-content">
                        <div class="file-container">
                            <div class="file-list">
                                <img id="upload-img" class="upload-img" :src="imgSrc" alt="파일 업로드" @click="uploadClick">
                                <input id="fileInput" type="file" multiple="multiple" @change="onFileChange"/>


                                <div>
                                    <ul>
                                        <li class="uploaded-file" v-for="fileInfo in this.fileInfos" :key="fileInfo.id">
                                            <a href="#" @click.prevent="deleteFile(fileInfo)">
                                                <span data-attr="파일">파일</span><span data-attr="삭제">삭제</span>
                                            </a>
                                            <label @click="deleteFile(fileInfo)">{{ fileInfo.originalFile }}</label>
                                        </li>
                                    </ul>
                                    <br>

                                    <board-file-list-for-write-modify v-if="getUploadFile.length !== 0"></board-file-list-for-write-modify>
                                </div>

                            </div>

                        </div>
                        <div class="board-recommand">
                        </div>
                    </div>
                </blockquote>
            </div>
            <div class="btn-loc">
                <button class="write-btn btn-del" type="button" @click="modifyCancle">취소</button>
                <button class="write-btn btn-list" type="button" @click="modify">수정</button>
            </div>
        </div>
    </div>
</template>

<script>

import {mapGetters, mapMutations} from "vuex";
import myAxios from "@/util/axios";
import BoardFileListForWriteModify from "@/components/Board/BoardFileListForWriteModify.vue";


export default {
    name: 'BoardModify',
    components: {BoardFileListForWriteModify},
    data() {
        return {
            selected: null,
            title: '',
            content: '',
            message1: '수정중',
            imgSrc : require('@/assets/upload.png'),
            files: [],
            fileInfos: {},
            OnlyImage : [],
        };
    },
    created: async function () {
        console.log("@@@@@@@@@@@@ 게시글 수정으로 이동")
        this.SET_UPLOAD_FILE({})
        this.selected = this.getBoardType;
        const response = await myAxios.get(`board/details/${this.getBoardType}/${this.getBoardNo}`)
        console.log(response);
        this.title = response.data.title
        this.content = response.data.content
        this.fileInfos = response.data.fileInfos

        this.makeOnlyImage()
    },
    computed: {
        //vuex모듈 중 boardStore에서 'getBoardType', 'getPageNo'를 얻어온다.
        ...mapGetters('boardStore', ['getBoardType', 'getPageNo', 'getBoardNo', 'getUploadFile', 'getOnlyImage']),
        ...mapGetters('userStore', ['checkUserInfo'])
    },
    methods: {
        ...mapMutations('boardStore', ['SET_UPLOAD_FILE', 'SET_ONLY_IMAGE']),
        makeOnlyImage(){
            this.OnlyImage=[]

            for(let fileInfo in this.fileInfos){
                console.log(this.fileInfos[fileInfo])

                const extension = this.fileInfos[fileInfo].saveFile.split('.').pop().toLowerCase();
                if (extension === 'jpg' || extension === 'png' || extension === 'gif') {
                    this.OnlyImage.push(this.fileInfos[fileInfo]);
                }
            }
        },
        setBoardType(event) {
            this.selected = event.target.value;
            console.log(this.selected)
        },

        onFileChange(event) {
            this.files = event.target.files;
            console.log("@파일 수정@")
            console.log(this.files);
            this.SET_UPLOAD_FILE(event.target.files);
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
            const response = await myAxios.put(`board/modify`, formData, {
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
            alert("글 수정 취소");
            this.$router.push({name: 'boardList'});
        },
        async deleteFile(fileInfo) {
            console.log("@@@@@파일 삭제@@@@@")
            if (confirm(`정말 ${fileInfo.originalFile}을 삭제하시겠습니까? \n 삭제된 파일은 복구할 수 없습니다.`)) {
                const response = await myAxios.delete(`board/deleteFile/${this.getBoardNo}/${fileInfo.saveFolder}/${fileInfo.saveFile}`)
                this.fileInfos = response.data;
            }
            this.makeOnlyImage()
        },
        uploadClick(){
            let fileInput = document.querySelector("#fileInput");
            fileInput.click();
        }
    },
    mounted() {
        this.$refs.content.focus()
        setInterval(() => {
            if (this.message1.endsWith('...')) {
                this.message1 = '수정중';
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

#fileInput {
//visibility: hidden; display: none;
}

.file-list .upload-img {
    width: 25px;
    height: 25px;
    margin: 10px;
}

.upload-img:hover {
    cursor: pointer;
}

.uploaded-file {
    display: flex;
    align-items: center;
}

.uploaded-file a {
    display: flex;
    align-items: center;
    text-decoration: none;
    margin-right: 10px; /* 요소 사이의 간격을 설정할 수 있습니다. 필요에 따라 조정해 주세요. */
}

.uploaded-file label {
    font-size: 13px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    flex-grow: 1;
}
.uploaded-file a {
    display: flex;
    align-items: center;
    text-decoration: none;
    text-transform: uppercase;
    font-size: 30px;
}

.uploaded-file a span {
    font-size: 13px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    padding: 2px;
    transition: .5s;
    position: relative;
}

.uploaded-file a span:nth-child(1) {
    color: #fff;
    background: #6E7783;
}

.uploaded-file a span:nth-child(2) {
    color: #fff;
    background: #77AAAD;
}

.uploaded-file a span:nth-child(1):before {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #77AAAD;
    padding: 2px;
    transition: 0.5S;
    transform-origin: top;
    transform: rotateX(90deg) translateY(-50%);
}

.uploaded-file a:hover span:nth-child(1):before {
    transform: rotateX(0deg) translateY(0%);
}

.uploaded-file a span:nth-child(2):before {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #6E7783;
    padding: 2px;
    transition: 0.5S;
    transform-origin: bottom;
    transform: rotateX(90deg) translateY(50%);
}

.uploaded-file a:hover span:nth-child(2):before {
    transform: rotateX(0deg) translateY(0%);
}

.uploaded-file a span:nth-child(1):after {
    content: attr(data-attr);
    padding: 2px;
    position: absolute;
    top: 0;
    left: 0;
    background: #6E7783;
    transform-origin: bottom;
    transform: rotateX(0deg) translateY(0%);
    transition: 0.5s;
}

.uploaded-file a:hover span:nth-child(1):after {
    transform: rotateX(90deg) translateY(50%);
}

.uploaded-file a span:nth-child(2):after {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #77AAAD;
    padding: 2px;
    transition: 0.5S;
    transform-origin: top;
    transform: rotateX(0deg) translateY(0%);
}

.uploaded-file a:hover span:nth-child(2):after {
    transform: rotateX(90deg) translateY(-50%);
}
.uploaded-file label:hover{
    cursor: pointer;
}

.explain{
    display: flex;
    justify-content: center;
    font-size: 13px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
}
.explain-uploaded{
    color: #77AAAD;
    margin-right: 15px;
}
.explain-new{
    color: #da6552;
    margin-left: 15px;
}
</style>

