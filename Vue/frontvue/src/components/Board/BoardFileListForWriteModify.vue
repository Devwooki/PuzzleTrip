<template>
    <ul>
        <li v-for="(fileInfo, index) in getUploadFile" :key="index">
            <a href="#" @click.prevent="remove(fileInfo)">
                <span data-attr="파일">다운</span><span data-attr="삭제">로드</span>
            </a>
            <label @click="downloadFile(fileInfo)">{{ fileInfo.name }}     ({{(fileInfo.size/1024/1024).toFixed(2)}}MB)</label>

        </li>
    </ul>
</template>

<script>
import {mapGetters, mapMutations, mapState} from "vuex";

export default {
    name: 'BoardFileListForWriteModify',
    data() {
        return {};
    },
    computed: {
        ...mapState('boardStore', ['boardType', 'boardNo',]),
        ...mapGetters('boardStore', ['getUploadFile'])
    },
    methods: {
        ...mapMutations('boardStore', ['REMOVE_UPLOAD_FILE']),
        remove(fileInfo){
            this.REMOVE_UPLOAD_FILE(fileInfo);
        }
    }
};
</script>

<style scoped>
* {
    font-size: 13px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
}

.file-list li {
    list-style: none; /* 리스트 마커 제거 */
    padding: 0; /* 내부 여백 제거 */
    margin: 0; /* 외부 여백 제거 */

}

li {
    display: flex;
    align-items: center;
}

li a {
    display: flex;
    align-items: center;
    text-decoration: none;
    margin-right: 10px; /* 요소 사이의 간격을 설정할 수 있습니다. 필요에 따라 조정해 주세요. */
}

li label {
    flex-grow: 1;
}
a {
    display: flex;
    align-items: center;
    text-decoration: none;
    text-transform: uppercase;
    font-size: 30px;
}

a span {
    padding: 2px;
    transition: .5s;
    position: relative;
}

a span:nth-child(1) {
    color: #fff;
    background: #77AAAD;
}

a span:nth-child(2) {
    color: #fff;
    background: #6E7783;
}

a span:nth-child(1):before {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #6E7783;
    padding: 2px;
    transition: 0.5S;
    transform-origin: top;
    transform: rotateX(90deg) translateY(-50%);
}

a:hover span:nth-child(1):before {
    transform: rotateX(0deg) translateY(0%);
}

a span:nth-child(2):before {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #da6552;
    padding: 2px;
    transition: 0.5S;
    transform-origin: bottom;
    transform: rotateX(90deg) translateY(50%);
}

a:hover span:nth-child(2):before {
    transform: rotateX(0deg) translateY(0%);
}

a span:nth-child(1):after {
    content: attr(data-attr);
    padding: 2px;
    position: absolute;
    top: 0;
    left: 0;
    background: #da6552;
    transform-origin: bottom;
    transform: rotateX(0deg) translateY(0%);
    transition: 0.5s;
}

a:hover span:nth-child(1):after {
    transform: rotateX(90deg) translateY(50%);
}

a span:nth-child(2):after {
    content: attr(data-attr);
    position: absolute;
    top: 0;
    left: 0;
    background: #6E7783;
    padding: 2px;
    transition: 0.5S;
    transform-origin: top;
    transform: rotateX(0deg) translateY(0%);
}

a:hover span:nth-child(2):after {
    transform: rotateX(90deg) translateY(-50%);
}
label:hover{
    cursor: pointer;
}
</style>