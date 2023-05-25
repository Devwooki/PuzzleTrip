//import MyAxios from '@/util/axios';
const boardStore = {
    namespaced: true,
    state: { //Vue의 data 역할, application에서 공유해야할 data
        boardType: 2,
        pageNo : 1,
        boardNo : null,
        comments : [],
        pageCount : 1,
        uploadFile : {},
        OnlyImage : [],
    },
    getters: { //state의 값을 vueComponent에 전달해주는 역할
        getBoardType(state){
            return state.boardType;
        },
        getPageNo(state){
            return state.pageNo;
        },
        getBoardNo(state){
            return state.boardNo;
        },
        getComments(state){
            return state.comments
        },
        getPageCount(state){
            return state.pageCount
        },
        getUploadFile(state){
            return state.uploadFile
        },
        getOnlyImage(state){
            return state.OnlyImage
        }

    },
    mutations: {//state 값을 변경하기 위해 사용하는것 -> 직접호출은 불가하고 commit('정의된 이름')으로 호출
        RESET_BOARD_STORE(state){
            state.boardType = 2
            state.pageNo = 1
            state.boardNo = null
            state.comments = []
            state.pageCount = 1
        },
        SET_BOARD_TYPE(state, boardType){
            state.boardType = boardType
        },
        SET_PAGE_NO(state, pageNo){
            state.pageNo = pageNo;
        },
        SET_BOARD_NO(state, boardNo){
            state.boardNo = boardNo;
        },
        SET_COMMENTS(state, comments){
            state.comments = comments;
        },
        SET_PAGE_COUNT(state, pageCount){
            state.pageCount =pageCount
        },
        SET_UPLOAD_FILE(state, files){
            // mutation에서 mutation 호출 시 모듈명을 붙여주자
            //console.dir(this)
            state.uploadFile = files
            this.commit('boardStore/SET_ONLY_IMAGE')
            //console.log(state.OnlyImage)
        },
        REMOVE_UPLOAD_FILE(state, removefile){
            // FileList 객체를 배열로 변환
            const files = Array.from(state.uploadFile);

            let indexToDelete = null;
            for(let key in state.uploadFile){
                if(removefile.name === state.uploadFile[key].name){
                    indexToDelete = key;
                }
            }
            // 해당 인덱스의 파일을 배열에서 제거
            files.splice(indexToDelete, 1);
            state.uploadFile = files;
            this.commit('boardStore/SET_ONLY_IMAGE')
            
        },

        //
        SET_ONLY_IMAGE(state){
            state.OnlyImage = [];
            for(let idx = 0 ; idx < state.uploadFile.length ; ++idx){
                const extension = state.uploadFile[idx].name.split('.').pop().toLowerCase();
                if (extension === 'jpg' || extension === 'png' || extension === 'gif') {
                    console.log()
                    state.OnlyImage.push(URL.createObjectURL(state.uploadFile[idx]))
                }
            }
            // 
        },

        REMOVE_ONLY_IMAGE(state, removeImage){
            // FileList 객체를 배열로 변환
            const files = Array.from(state.uploadFile);

            let indexToDelete = null;
            for(let key in state.uploadFile){
                if(removeImage.name === state.uploadFile[key].name){
                    indexToDelete = key;
                }
            }

            // 해당 인덱스의 파일을 배열에서 제거
            files.splice(indexToDelete, 1);

            state.uploadFile = files;

            console.log(removeImage.name + "삭제완료")
            console.log(state.uploadFile)
        }
    },
    actions: { //비동기 작업 결과를 적용할 떄 사용한다
        // commit : 현재 store의 뮤테이션을 호출하는 객체, 해당 뮤테이션을 통해 state변경 가능
        // state : store에 저장된 상태 객체
        // async getBoardLists({commit, state}){
        //     const response = await MyAxios.get(`/board/lists/${state.boardType}/${state.pageNo}`)
        //     commit("SET_BOARD_LISTS", response.list)
        //     commit("SET_PAGE_RESULT", response.pageResult)
        // },
    },
};

export default boardStore;
